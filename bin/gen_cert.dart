import 'dart:io';
import 'package:anytype_dart/src/crypto/account.dart';
import 'package:anytype_dart/src/net/libp2p_tls.dart';

void main() async {
  final mnemonic = generateMnemonic();
  final account = await AccountKeys.fromMnemonic(mnemonic);
  final key = account.identityKey;
  print('PeerId: ${derivePeerId(key.publicKey.raw)}');

  final (certPath, keyPath) = await generateLibp2pTlsCert(key);
  print('Cert: $certPath');
  print('Key: $keyPath');

  final result = await Process.run('openssl', ['x509', '-in', certPath, '-text', '-noout']);
  for (final line in result.stdout.toString().split('\n')) {
    if (line.contains('53594') || line.contains('extension') || line.contains('Extension')) {
      print('  $line');
    }
  }
  print('Files preserved for manual testing.');
}
