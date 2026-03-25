// Connects to a live any-sync node via TCP/yamux.
//
// Usage: dart run bin/tcp_connect.dart [host] [port]

import 'dart:io';
import 'dart:typed_data';

import 'package:anytype_dart/src/crypto/account.dart';
import 'package:anytype_dart/src/net/handshake.dart';
import 'package:anytype_dart/src/net/libp2p_tls.dart';

void main(List<String> args) async {
  final host = args.isNotEmpty ? args[0] : '192.168.0.2';
  final port = args.length > 1 ? int.parse(args[1]) : 33010;
  final remotePeer = args.length > 2
      ? args[2]
      : '12D3KooWK6GnEUdD9pZaUghESteqKm5Bvv9fkKn3nRL1zz2Y5F7p';

  // Generate identity
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  final localPeerId = derivePeerId(key.publicKey.raw);
  print('PeerId: $localPeerId');

  // Generate libp2p TLS certificate
  final (certPath, keyPath) = await generateLibp2pTlsCert(key);

  // TCP connect
  final rawSocket = await RawSocket.connect(host, port,
      timeout: const Duration(seconds: 5));
  print('[1] TCP connected to $host:$port');

  // TLS upgrade
  final ctx = SecurityContext();
  ctx.useCertificateChain(certPath);
  ctx.usePrivateKey(keyPath);
  final secSocket = await RawSecureSocket.secure(rawSocket,
      context: ctx, host: host, onBadCertificate: (_) => true);
  print('[2] TLS upgraded');

  // Credential handshake over TLS
  final server = await performCredentialHandshake(
    secSocket: secSocket,
    signingKey: key,
    localPeerId: localPeerId,
    remotePeerId: remotePeer,
  );
  print('[3] Credentials complete — server: ${server.client} (v${server.version})');

  // Yamux + proto handshake on raw socket
  rawSocket.write(buildYamuxProtoFrames());
  print('[4] Sent yamux SYN + proto');

  // Read yamux response
  rawSocket.readEventsEnabled = true;
  final buf = <int>[];
  final deadline = DateTime.now().add(const Duration(seconds: 3));
  while (DateTime.now().isBefore(deadline)) {
    final data = rawSocket.read();
    if (data != null) buf.addAll(data);
    await Future.delayed(const Duration(milliseconds: 5));
  }

  for (final frame in parseYamuxFrames(buf)) {
    final types = ['DATA', 'WINDOW', 'PING', 'GOAWAY'];
    final name = frame.type < 4 ? types[frame.type] : '?';
    print('  yamux: $name flags=0x${frame.flags.toRadixString(16)} '
        'stream=${frame.streamId}');
    if (frame.payload != null && frame.payload!.length >= 5) {
      final msgType = frame.payload![0];
      if (msgType == 2) {
        print('[5] Proto Ack received — connection established');
      }
    }
  }

  rawSocket.close();
  try {
    Directory(File(certPath).parent.path).deleteSync(recursive: true);
  } catch (_) {}
}
