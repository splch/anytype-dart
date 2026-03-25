import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:anytype_dart/src/crypto/account.dart';
import 'package:anytype_dart/src/crypto/keys.dart';
import 'package:anytype_dart/src/net/libp2p_tls.dart';

void writeVarint(BytesBuilder b, int v) {
  while (v > 0x7F) { b.addByte((v & 0x7F) | 0x80); v >>= 7; }
  b.addByte(v & 0x7F);
}

Future<Uint8List> buildSignedPeerIdsCred(Ed25519SigningKey key, String localPeerId, String remotePeerId) async {
  final buf = BytesBuilder();

  // field 1: type = SignedPeerIds (1)
  buf.addByte(0x08); buf.addByte(0x01);

  // Build PayloadSignedPeerIds
  final payloadBuf = BytesBuilder();
  // field 1: identity (proto Key message)
  final identityProto = key.publicKey.marshalProto();
  payloadBuf.addByte(0x0A); writeVarint(payloadBuf, identityProto.length);
  payloadBuf.add(identityProto);
  // field 2: signature of (localPeerId + remotePeerId)
  final sig = await key.sign(Uint8List.fromList(utf8.encode(localPeerId + remotePeerId)));
  payloadBuf.addByte(0x12); writeVarint(payloadBuf, sig.length);
  payloadBuf.add(sig);
  final payload = payloadBuf.toBytes();

  // field 2: payload
  buf.addByte(0x12); writeVarint(buf, payload.length);
  buf.add(payload);

  // field 3: version = 9
  buf.addByte(0x18); buf.addByte(0x09);

  // field 4: clientVersion
  final cv = utf8.encode('anytype-dart/0.1.0');
  buf.addByte(0x22); writeVarint(buf, cv.length);
  buf.add(cv);

  return buf.toBytes();
}

void main() async {
  // Generate identity
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  final localPeerId = derivePeerId(key.publicKey.raw);
  final remotePeerId = '12D3KooWK6GnEUdD9pZaUghESteqKm5Bvv9fkKn3nRL1zz2Y5F7p';

  // Generate cert
  final (certPath, keyPath) = await generateLibp2pTlsCert(key);
  print('PeerId: $localPeerId');

  // Connect
  final ctx = SecurityContext();
  ctx.useCertificateChain(certPath);
  ctx.usePrivateKey(keyPath);
  final socket = await SecureSocket.connect('192.168.0.2', 33010,
    context: ctx, onBadCertificate: (_) => true, timeout: Duration(seconds: 5));
  print('TLS connected');

  // Buffer
  final buf = <int>[];
  final gotData = Completer<void>();
  socket.listen(
    (data) { buf.addAll(data); if (!gotData.isCompleted) gotData.complete(); },
    onError: (e) { print('Error: $e'); if (!gotData.isCompleted) gotData.completeError(e); },
    onDone: () { print('Done'); if (!gotData.isCompleted) gotData.complete(); },
  );

  // Send SignedPeerIds credentials
  final cred = await buildSignedPeerIdsCred(key, localPeerId, remotePeerId);
  final header = Uint8List(5);
  header[0] = 1; // Credentials type
  header.buffer.asByteData().setUint32(1, cred.length, Endian.little);
  socket.add(header);
  socket.add(cred);
  await socket.flush();
  print('Sent ${5 + cred.length} bytes (SignedPeerIds)');

  // Wait for response
  await gotData.future.timeout(Duration(seconds: 5), onTimeout: () {
    print('Timeout (${buf.length} bytes in buffer)');
  });

  print('Response: ${buf.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}');
  if (buf.length >= 5) {
    final type = buf[0];
    final size = buf[1] | (buf[2] << 8) | (buf[3] << 16) | (buf[4] << 24);
    print('Type: $type, Size: $size');
    if (type == 1) {
      print('GOT CREDENTIALS RESPONSE! Server accepted our identity!');
    } else if (type == 2) {
      final errorCode = buf.length > 6 ? buf[6] : 0;
      final errors = {0: 'Success', 1: 'Unexpected', 2: 'InvalidCredentials',
        3: 'UnexpectedPayload', 4: 'SkipVerifyNotAllowed', 5: 'DeadlineExceeded',
        6: 'IncompatibleVersion', 7: 'IncompatibleProto'};
      print('Ack: ${errors[errorCode] ?? "Unknown($errorCode)"}');
    }
  }

  await socket.close();
  // Cleanup
  try { Directory(File(certPath).parent.path).deleteSync(recursive: true); } catch(_) {}
}
