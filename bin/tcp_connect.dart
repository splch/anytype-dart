// TCP/yamux connection to a live any-sync node.
//
// Flow (matching Go any-sync):
//   1. Raw TCP connect
//   2. TLS upgrade (libp2p cert) — for credential handshake only
//   3. Credential exchange over TLS
//   4. Shutdown TLS, switch to raw TCP
//   5. Yamux session on raw TCP
//   6. Proto handshake on yamux stream
//   7. DRPC calls on additional yamux streams

import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:anytype_dart/src/crypto/account.dart';
import 'package:anytype_dart/src/crypto/keys.dart';
import 'package:anytype_dart/src/net/libp2p_tls.dart';

const remotePeerId = '12D3KooWK6GnEUdD9pZaUghESteqKm5Bvv9fkKn3nRL1zz2Y5F7p';

void wv(BytesBuilder b, int v) {
  while (v > 0x7F) { b.addByte((v & 0x7F) | 0x80); v >>= 7; }
  b.addByte(v & 0x7F);
}

void main() async {
  final host = '192.168.0.2';
  final port = 33010;
  print('=== TCP/yamux connection probe ===\n');

  // Generate identity
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  final localPeerId = derivePeerId(key.publicKey.raw);
  print('PeerId: $localPeerId');

  // Generate libp2p TLS cert
  final (certPath, keyPath) = await generateLibp2pTlsCert(key);

  // Step 1: Raw TCP connect
  final rawSocket = await RawSocket.connect(host, port, timeout: Duration(seconds: 5));
  print('[1] TCP connected');

  // Step 2: TLS upgrade with libp2p cert
  final ctx = SecurityContext();
  ctx.useCertificateChain(certPath);
  ctx.usePrivateKey(keyPath);
  final secSocket = await RawSecureSocket.secure(rawSocket,
    context: ctx, host: host, onBadCertificate: (_) => true);
  print('[2] TLS upgraded');

  // Helper: read/write through TLS for credential handshake
  final tlsBuf = <int>[];
  final tlsSub = secSocket.listen((event) {
    if (event == RawSocketEvent.read) {
      final data = secSocket.read();
      if (data != null) tlsBuf.addAll(data);
    }
  });

  Future<void> tlsSend(int type, Uint8List payload) async {
    final h = Uint8List(5);
    h[0] = type;
    h.buffer.asByteData().setUint32(1, payload.length, Endian.little);
    secSocket.write(h);
    if (payload.isNotEmpty) secSocket.write(payload);
  }

  Future<void> waitTlsBytes(int n) async {
    for (var i = 0; i < 1000 && tlsBuf.length < n; i++) {
      await Future.delayed(Duration(milliseconds: 5));
    }
  }

  // Step 3: Credential handshake over TLS
  final cb = BytesBuilder();
  cb.addByte(0x08); cb.addByte(0x01); // type=SignedPeerIds
  final pb = BytesBuilder();
  final idp = key.publicKey.marshalProto();
  pb.addByte(0x0A); wv(pb, idp.length); pb.add(idp);
  final sig = await key.sign(Uint8List.fromList(utf8.encode(localPeerId + remotePeerId)));
  pb.addByte(0x12); wv(pb, sig.length); pb.add(sig);
  final payload = pb.toBytes();
  cb.addByte(0x12); wv(cb, payload.length); cb.add(payload);
  cb.addByte(0x18); cb.addByte(0x08); // version=8
  final cv = utf8.encode('anytype-dart/0.1.0');
  cb.addByte(0x22); wv(cb, cv.length); cb.add(cv);

  await tlsSend(1, cb.toBytes());
  await waitTlsBytes(5);
  if (tlsBuf.isEmpty) { print('[3] No credential response'); exit(1); }
  final credSize = tlsBuf[1]|(tlsBuf[2]<<8)|(tlsBuf[3]<<16)|(tlsBuf[4]<<24);
  await waitTlsBytes(5 + credSize);
  print('[3] Credential response: type=${tlsBuf[0]}, size=$credSize');
  tlsBuf.removeRange(0, 5 + credSize);

  // Send Ack
  await tlsSend(2, Uint8List(0));
  await waitTlsBytes(5);
  final ackSize = tlsBuf.length >= 5 ? tlsBuf[1]|(tlsBuf[2]<<8)|(tlsBuf[3]<<16)|(tlsBuf[4]<<24) : 0;
  await waitTlsBytes(5 + ackSize);
  print('[3] Ack exchange: type=${tlsBuf.isNotEmpty ? tlsBuf[0] : -1}');
  tlsBuf.clear();
  print('[3] Credential handshake complete');

  // Step 4: Stop TLS, switch to raw
  // Cancel our TLS listener — we're done with encrypted communication
  await tlsSub.cancel();
  // Don't close secSocket — that would close the underlying TCP.
  // Just stop using it. Write directly to rawSocket from now on.
  print('[4] TLS abandoned — switching to raw TCP');

  // Step 5: Yamux on raw TCP
  // We can't re-listen on rawSocket (single subscription, used by SecureSocket).
  // Instead, poll for raw data using a timer.
  final rawBuf = <int>[];
  var closed = false;

  // Send yamux SYN for stream 1
  final ymxSyn = Uint8List(12);
  ByteData.sublistView(ymxSyn)
    ..setUint8(0, 0)  // version
    ..setUint8(1, 1)  // type=window_update
    ..setUint16(2, 1, Endian.big)  // flags=SYN
    ..setUint32(4, 1, Endian.big)  // streamID=1
    ..setUint32(8, 262144, Endian.big);  // window=256KB
  rawSocket.write(ymxSyn);
  print('[5] Sent yamux SYN (stream 1)');

  // Send proto handshake data on stream 1
  final protoData = Uint8List.fromList([0x03, 0x00, 0x00, 0x00, 0x00]); // Proto type=3, empty
  final ymxData = Uint8List(12 + protoData.length);
  ByteData.sublistView(ymxData)
    ..setUint8(0, 0)  // version
    ..setUint8(1, 0)  // type=data
    ..setUint16(2, 0, Endian.big)  // flags=0
    ..setUint32(4, 1, Endian.big)  // streamID=1
    ..setUint32(8, protoData.length, Endian.big);
  ymxData.setRange(12, 12 + protoData.length, protoData);
  rawSocket.write(ymxData);
  print('[5] Sent proto on yamux stream 1');

  // Wait for response by polling rawSocket.read()
  print('[5] Waiting for yamux responses...');
  rawSocket.readEventsEnabled = true;
  // Read for 3 seconds, collecting all yamux frames
  final readDeadline = DateTime.now().add(Duration(seconds: 3));
  while (DateTime.now().isBefore(readDeadline) && !closed) {
    final data = rawSocket.read();
    if (data != null && data.isNotEmpty) {
      rawBuf.addAll(data);
    }
    await Future.delayed(Duration(milliseconds: 5));
  }
  print('[5] Buffer: ${rawBuf.length} bytes');

  if (rawBuf.length >= 12) {
    var pos = 0;
    while (pos + 12 <= rawBuf.length) {
      final v = rawBuf[pos]; final tp = rawBuf[pos+1];
      final fl = (rawBuf[pos+2]<<8)|rawBuf[pos+3];
      final sid = (rawBuf[pos+4]<<24)|(rawBuf[pos+5]<<16)|(rawBuf[pos+6]<<8)|rawBuf[pos+7];
      final len = (rawBuf[pos+8]<<24)|(rawBuf[pos+9]<<16)|(rawBuf[pos+10]<<8)|rawBuf[pos+11];
      final types = ['DATA','WINDOW','PING','GOAWAY'];
      print('  Yamux: ${tp < 4 ? types[tp] : "UNKNOWN($tp)"} flags=0x${fl.toRadixString(16)} stream=$sid len=$len');
      pos += 12;
      if (tp == 0 && len > 0 && pos + len <= rawBuf.length) {
        final data = rawBuf.sublist(pos, pos + len);
        print('  Payload: ${data.map((b)=>b.toRadixString(16).padLeft(2,"0")).join(" ")}');
        pos += len;
      }
    }
  }

  // Read more data (proto response should come on stream 1 as a data frame)
  print('[6] Waiting for proto response on stream 1...');
  for (var i = 0; i < 500; i++) {
    final data = rawSocket.read();
    if (data != null && data.isNotEmpty) {
      rawBuf.addAll(data);
      print('  >> Raw read: ${data.length} bytes (total ${rawBuf.length})');
    }
    if (rawBuf.length > 12) break; // Got data beyond the first frame
    await Future.delayed(Duration(milliseconds: 10));
  }

  if (rawBuf.length > 0) {
    var pos = 0;
    while (pos + 12 <= rawBuf.length) {
      final tp = rawBuf[pos+1];
      final fl = (rawBuf[pos+2]<<8)|rawBuf[pos+3];
      final sid = (rawBuf[pos+4]<<24)|(rawBuf[pos+5]<<16)|(rawBuf[pos+6]<<8)|rawBuf[pos+7];
      final len = (rawBuf[pos+8]<<24)|(rawBuf[pos+9]<<16)|(rawBuf[pos+10]<<8)|rawBuf[pos+11];
      final types = ['DATA','WINDOW','PING','GOAWAY'];
      print('  Yamux: ${tp < 4 ? types[tp] : "?"} flags=0x${fl.toRadixString(16)} stream=$sid len=$len');
      pos += 12;
      if (tp == 0 && len > 0 && pos + len <= rawBuf.length) {
        final payload = rawBuf.sublist(pos, pos + len);
        print('  Payload: ${payload.map((b)=>b.toRadixString(16).padLeft(2,"0")).join(" ")}');
        // Decode as handshake message
        if (payload.length >= 5) {
          final msgType = payload[0];
          final msgSize = payload[1]|(payload[2]<<8)|(payload[3]<<16)|(payload[4]<<24);
          final msgTypes = {1: 'CREDENTIALS', 2: 'ACK', 3: 'PROTO'};
          print('  Handshake: ${msgTypes[msgType] ?? "UNKNOWN($msgType)"} size=$msgSize');
          if (msgType == 2 && msgSize == 0) {
            print('\n=== PROTO HANDSHAKE COMPLETE ===');
            print('=== FULL CONNECTION ESTABLISHED ===');
            print('Ready for DRPC calls on yamux streams');
          }
        }
        pos += len;
      }
    }
  }

  rawSocket.close();
  try { Directory(File(certPath).parent.path).deleteSync(recursive: true); } catch(_) {}
  print('\nDone.');
}
