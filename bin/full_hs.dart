import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:anytype_dart/src/crypto/account.dart';
import 'package:anytype_dart/src/crypto/keys.dart';
import 'package:anytype_dart/src/net/libp2p_tls.dart';

void wv(BytesBuilder b, int v) {
  while (v > 0x7F) { b.addByte((v & 0x7F) | 0x80); v >>= 7; }
  b.addByte(v & 0x7F);
}

void main() async {
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  final localPeerId = derivePeerId(key.publicKey.raw);
  final remotePeerId = '12D3KooWK6GnEUdD9pZaUghESteqKm5Bvv9fkKn3nRL1zz2Y5F7p';

  final (certPath, keyPath) = await generateLibp2pTlsCert(key);
  final ctx = SecurityContext();
  ctx.useCertificateChain(certPath);
  ctx.usePrivateKey(keyPath);
  final socket = await SecureSocket.connect('192.168.0.2', 33010,
    context: ctx, onBadCertificate: (_) => true, timeout: Duration(seconds: 5));

  final buf = <int>[];
  var closed = false;
  socket.listen(
    (d) { buf.addAll(d); },
    onDone: () { closed = true; },
  );

  Future<void> sendRaw(int type, Uint8List p) async {
    final h = Uint8List(5);
    h[0] = type; h.buffer.asByteData().setUint32(1, p.length, Endian.little);
    socket.add(h); if (p.isNotEmpty) socket.add(p); await socket.flush();
  }
  Future<void> wait(int n) async {
    for (var i = 0; i < 1000 && buf.length < n && !closed; i++) {
      await Future.delayed(Duration(milliseconds: 5));
    }
  }
  void drain() { buf.clear(); }

  // Credential handshake
  final cb = BytesBuilder();
  cb.addByte(0x08); cb.addByte(0x01);
  final pb = BytesBuilder();
  final idp = key.publicKey.marshalProto();
  pb.addByte(0x0A); wv(pb, idp.length); pb.add(idp);
  final sig = await key.sign(Uint8List.fromList(utf8.encode(localPeerId + remotePeerId)));
  pb.addByte(0x12); wv(pb, sig.length); pb.add(sig);
  final payload = pb.toBytes();
  cb.addByte(0x12); wv(cb, payload.length); cb.add(payload);
  cb.addByte(0x18); cb.addByte(0x08);
  final cv = utf8.encode('anytype-dart/0.1.0');
  cb.addByte(0x22); wv(cb, cv.length); cb.add(cv);

  await sendRaw(1, cb.toBytes());
  await wait(5); drain();
  await sendRaw(2, Uint8List(0));
  await wait(5); drain();
  print('[OK] Credential handshake complete');

  // Yamux SYN + Proto data in rapid succession
  // Frame 1: Window update with SYN for stream 1
  final ymxSyn = Uint8List(12);
  ByteData.sublistView(ymxSyn)
    ..setUint8(0, 0)..setUint8(1, 1)
    ..setUint16(2, 1, Endian.big)  // SYN
    ..setUint32(4, 1, Endian.big)  // stream 1
    ..setUint32(8, 262144, Endian.big);

  // Frame 2: Data frame with proto handshake on stream 1
  // Proto message: [type=3][size=0 LE][empty payload]
  final protoData = Uint8List.fromList([0x03, 0x00, 0x00, 0x00, 0x00]);
  final ymxData = Uint8List(12 + protoData.length);
  ByteData.sublistView(ymxData)
    ..setUint8(0, 0)..setUint8(1, 0)  // type=data
    ..setUint16(2, 0, Endian.big)     // flags=0
    ..setUint32(4, 1, Endian.big)     // stream 1
    ..setUint32(8, protoData.length, Endian.big);
  ymxData.setRange(12, 12 + protoData.length, protoData);

  // Send both frames
  socket.add(ymxSyn);
  socket.add(ymxData);
  await socket.flush();
  print('[OK] Sent yamux SYN + Proto on stream 1');

  // Wait for response (yamux ACK + proto Ack)
  print('[..] Waiting for response...');
  await Future.delayed(Duration(seconds: 5));
  print('Buffer: ${buf.length} bytes, closed=$closed');
  if (buf.isNotEmpty) {
    // Parse yamux frames
    var pos = 0;
    while (pos + 12 <= buf.length) {
      final v = buf[pos]; final tp = buf[pos+1];
      final fl = (buf[pos+2]<<8)|buf[pos+3];
      final sid = (buf[pos+4]<<24)|(buf[pos+5]<<16)|(buf[pos+6]<<8)|buf[pos+7];
      final len = (buf[pos+8]<<24)|(buf[pos+9]<<16)|(buf[pos+10]<<8)|buf[pos+11];
      final types = ['DATA','WINDOW','PING','GOAWAY'];
      print('  Yamux frame: ${types[tp]} flags=0x${fl.toRadixString(16)} stream=$sid len=$len');
      pos += 12;
      if (tp == 0 && len > 0 && pos + len <= buf.length) {
        // Data frame payload
        final data = buf.sublist(pos, pos + len);
        print('    Payload: ${data.take(30).map((b)=>b.toRadixString(16).padLeft(2,"0")).join(" ")}');
        pos += len;
      }
    }
  }

  await socket.close();
  try { Directory(File(certPath).parent.path).deleteSync(recursive: true); } catch(_) {}
}
