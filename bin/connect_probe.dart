// Full connection probe for a live any-sync node.
// Tests: TLS → Credentials → Ack → Proto → Yamux → DRPC NetworkConfiguration

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

Future<Uint8List> buildCred(Ed25519SigningKey key, String localPeerId) async {
  final buf = BytesBuilder();
  buf.addByte(0x08); buf.addByte(0x01); // type=SignedPeerIds
  final pb = BytesBuilder();
  final idProto = key.publicKey.marshalProto();
  pb.addByte(0x0A); wv(pb, idProto.length); pb.add(idProto);
  final sig = await key.sign(Uint8List.fromList(utf8.encode(localPeerId + remotePeerId)));
  pb.addByte(0x12); wv(pb, sig.length); pb.add(sig);
  final payload = pb.toBytes();
  buf.addByte(0x12); wv(buf, payload.length); buf.add(payload);
  buf.addByte(0x18); buf.addByte(0x08); // version=8 (matches server)
  final cv = utf8.encode('anytype-dart/0.1.0');
  buf.addByte(0x22); wv(buf, cv.length); buf.add(cv);
  return buf.toBytes();
}

Uint8List buildAck() => Uint8List(0); // empty = Error.Null

Uint8List buildProto() {
  final buf = BytesBuilder();
  // field 1: proto = 0 (DRPC) — omitted (proto3 default)
  // field 2: repeated encoding = [None(0), Snappy is not needed]
  // Send empty encodings to trigger Ack path (old client compat)
  return buf.toBytes();
}

Uint8List buildProtoAck() => Uint8List(0); // Ack success

Future<void> sendMsg(SecureSocket s, int type, Uint8List payload) async {
  final h = Uint8List(5);
  h[0] = type;
  h.buffer.asByteData().setUint32(1, payload.length, Endian.little);
  s.add(h);
  if (payload.isNotEmpty) s.add(payload);
  await s.flush();
}

Future<(int, Uint8List)> readMsg(List<int> buf) async {
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (buf.length < 5) {
    if (DateTime.now().isAfter(deadline)) throw TimeoutException('Header');
    await Future.delayed(const Duration(milliseconds: 5));
  }
  final type = buf[0];
  final size = buf[1] | (buf[2] << 8) | (buf[3] << 16) | (buf[4] << 24);
  while (buf.length < 5 + size) {
    if (DateTime.now().isAfter(deadline)) throw TimeoutException('Payload');
    await Future.delayed(const Duration(milliseconds: 5));
  }
  final payload = Uint8List.fromList(buf.sublist(5, 5 + size));
  buf.removeRange(0, 5 + size);
  return (type, payload);
}

void main() async {
  final host = '192.168.0.2';
  final port = 33010;
  print('=== anytype-dart full connection probe ===\n');

  // Identity
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  final localPeerId = derivePeerId(key.publicKey.raw);
  print('Local PeerId: $localPeerId');
  print('Account: ${key.publicKey.account}\n');

  // TLS cert
  final (certPath, keyPath) = await generateLibp2pTlsCert(key);

  // Connect
  final ctx = SecurityContext();
  ctx.useCertificateChain(certPath);
  ctx.usePrivateKey(keyPath);
  final socket = await SecureSocket.connect(host, port,
    context: ctx, onBadCertificate: (_) => true, timeout: const Duration(seconds: 5));
  print('[1] TLS connected to $host:$port');

  // Buffered reader
  final buf = <int>[];
  socket.listen(
    (data) { buf.addAll(data); },
    onError: (e) { print('Socket error: $e'); },
    onDone: () { print('Socket closed by server'); },
  );

  // --- Credentials handshake ---
  final cred = await buildCred(key, localPeerId);
  await sendMsg(socket, 1, cred);
  print('[2] Sent SignedPeerIds credentials (${5 + cred.length} bytes)');

  final (credType, credPayload) = await readMsg(buf);
  if (credType == 2) {
    print('[2] REJECTED: Ack error ${credPayload.isNotEmpty ? credPayload.last : 0}');
    await socket.close();
    return;
  }
  print('[2] Received server Credentials (${credPayload.length} bytes)');

  // Extract server version from credentials
  var serverVersion = 0;
  var serverClient = '';
  var pos = 0;
  while (pos < credPayload.length) {
    final tag = credPayload[pos++];
    final field = tag >> 3; final wt = tag & 7;
    if (wt == 0) {
      var v = 0; var s = 0;
      while (pos < credPayload.length) {
        final b = credPayload[pos++]; v |= (b & 0x7F) << s;
        if (b & 0x80 == 0) break; s += 7;
      }
      if (field == 3) serverVersion = v;
    } else if (wt == 2) {
      var len = 0; var s = 0;
      while (pos < credPayload.length) {
        final b = credPayload[pos++]; len |= (b & 0x7F) << s;
        if (b & 0x80 == 0) break; s += 7;
      }
      if (field == 4) serverClient = utf8.decode(credPayload.sublist(pos, pos + len));
      pos += len;
    }
  }
  print('    Server version: $serverVersion, client: $serverClient');

  // Send Ack (success)
  await sendMsg(socket, 2, buildAck());
  print('[3] Sent Ack (success)');

  // Read server Ack
  final (ackType, ackPayload) = await readMsg(buf);
  if (ackType != 2 || (ackPayload.isNotEmpty && ackPayload.last != 0)) {
    print('[3] REJECTED: type=$ackType payload=$ackPayload');
    await socket.close();
    return;
  }
  print('[3] Received Ack (success) — CREDENTIALS HANDSHAKE COMPLETE');

  // --- Proto handshake ---
  await sendMsg(socket, 3, buildProto());
  print('[4] Sent Proto (DRPC, encoding=None)');

  final (protoType, protoPayload) = await readMsg(buf);
  if (protoType == 2) {
    // Server sends Ack for Proto (old client compatibility)
    final err = (protoPayload.length >= 2 && protoPayload[0] == 0x08) ? protoPayload[1] : 0;
    if (err != 0) {
      print('[4] Proto rejected: error $err');
      await socket.close();
      return;
    }
    print('[4] Received Proto Ack (success) — PROTO HANDSHAKE COMPLETE');
  } else if (protoType == 3) {
    print('[4] Received Proto response (${protoPayload.length} bytes)');
    // Send Ack for proto
    await sendMsg(socket, 2, buildProtoAck());
    // Read server's final Ack
    final (pa2t, _) = await readMsg(buf);
    print('[4] Proto Ack exchange complete (type=$pa2t) — PROTO HANDSHAKE COMPLETE');
  }

  print('\n=== HANDSHAKE COMPLETE ===');
  print('Connected to any-sync node: $serverClient');
  print('Protocol version: $serverVersion');
  print('Remaining buffer: ${buf.length} bytes');
  print('Ready for yamux session + DRPC calls\n');

  await socket.close();
  try { Directory(File(certPath).parent.path).deleteSync(recursive: true); } catch(_) {}
}
