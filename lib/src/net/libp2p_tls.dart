// This file is part of anytype-dart.
//
// anytype-dart is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// anytype-dart is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with anytype-dart.  If not, see <https://www.gnu.org/licenses/>.

/// libp2p TLS identity — generates X.509 certificates with the
/// Ed25519 identity embedded in extension OID 1.3.6.1.4.1.53594.1.
///
/// The extension contains a protobuf-encoded SignedKey message:
///   SignedKey { PublicKey{type=Ed25519, data=pubkey}, signature }
/// where signature = Ed25519Sign(privkey, "libp2p-tls-handshake:" || DER(pubkey))
library;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../crypto/keys.dart';

/// The domain prefix for libp2p TLS handshake signatures.
const _signaturePrefix = 'libp2p-tls-handshake:';

/// DER encoding of Ed25519 SubjectPublicKeyInfo wrapper.
/// 30 2A 30 05 06 03 2B 65 70 03 21 00 [32 bytes pubkey]
Uint8List _derEncodeEd25519PublicKey(Uint8List pubkey) {
  return Uint8List.fromList([
    0x30, 0x2A, // SEQUENCE, length 42
    0x30, 0x05, // SEQUENCE (AlgorithmIdentifier)
    0x06, 0x03, 0x2B, 0x65, 0x70, // OID 1.3.101.112 (Ed25519)
    0x03, 0x21, // BIT STRING, length 33
    0x00, // no unused bits
    ...pubkey,
  ]);
}

/// Encode SignedKey as ASN.1 DER (what go-libp2p TLS expects):
///
///   SignedKey ::= SEQUENCE {
///     PubKey    OCTET STRING,  -- protobuf-encoded libp2p PublicKey
///     Signature OCTET STRING   -- Ed25519 signature bytes
///   }
///
/// The PubKey OCTET STRING contains a protobuf-encoded libp2p PublicKey:
///   { type: Ed25519(1), data: 32-byte pubkey }
Uint8List _encodeSignedKey(Uint8List pubkey, Uint8List signature) {
  // Protobuf-encode the libp2p PublicKey: { type=1, data=pubkey }
  final protoPubKey = Uint8List.fromList([
    0x08, 0x01, // field 1: type = Ed25519 (1)
    0x12, pubkey.length, // field 2: data length
    ...pubkey,
  ]);

  // ASN.1 DER: SEQUENCE { OCTET STRING(protoPubKey), OCTET STRING(signature) }
  final pubOctet = _derOctetString(protoPubKey);
  final sigOctet = _derOctetString(signature);

  final contentLen = pubOctet.length + sigOctet.length;
  final seq = BytesBuilder();
  seq.addByte(0x30); // SEQUENCE tag
  _derWriteLength(seq, contentLen);
  seq.add(pubOctet);
  seq.add(sigOctet);

  return seq.toBytes();
}

Uint8List _derOctetString(Uint8List data) {
  final buf = BytesBuilder();
  buf.addByte(0x04); // OCTET STRING tag
  _derWriteLength(buf, data.length);
  buf.add(data);
  return buf.toBytes();
}

void _derWriteLength(BytesBuilder buf, int length) {
  if (length < 128) {
    buf.addByte(length);
  } else if (length < 256) {
    buf.addByte(0x81);
    buf.addByte(length);
  } else {
    buf.addByte(0x82);
    buf.addByte((length >> 8) & 0xFF);
    buf.addByte(length & 0xFF);
  }
}

/// Generates a libp2p-compatible TLS certificate and key files.
///
/// The certificate is self-signed with Ed25519 and contains the
/// libp2p identity extension (OID 1.3.6.1.4.1.53594.1).
///
/// Returns (certPath, keyPath) pointing to temporary PEM files.
Future<(String, String)> generateLibp2pTlsCert(
  Ed25519SigningKey identityKey,
) async {
  final identityPubBytes = identityKey.publicKey.raw;

  // Create temp directory
  final tmpDir = await Directory.systemTemp.createTemp('lp2p_');
  final keyPath = '${tmpDir.path}/key.pem';
  final certPath = '${tmpDir.path}/cert.pem';
  final derPubPath = '${tmpDir.path}/tlspub.der';
  final extPath = '${tmpDir.path}/ext.cnf';

  // Step 1: Generate TLS ECDSA P-256 private key (matching server's choice)
  var result = await Process.run('openssl', [
    'ecparam', '-genkey', '-name', 'prime256v1', '-noout', '-out', keyPath,
  ]);
  if (result.exitCode != 0) {
    throw StateError('Failed to generate key: ${result.stderr}');
  }

  // Step 2: Extract the TLS public key in DER (SubjectPublicKeyInfo) format
  result = await Process.run('openssl', [
    'ec', '-in', keyPath, '-pubout', '-outform', 'DER', '-out', derPubPath,
  ]);
  if (result.exitCode != 0) {
    throw StateError('Failed to extract public key: ${result.stderr}');
  }
  final tlsPubDer = await File(derPubPath).readAsBytes();

  // Step 3: Sign the TLS cert's public key with the IDENTITY key
  // message = "libp2p-tls-handshake:" || DER(TLS_certificate_public_key)
  final messageToSign = Uint8List.fromList([
    ...utf8.encode(_signaturePrefix),
    ...tlsPubDer,
  ]);
  final signature = await identityKey.sign(messageToSign);

  // Step 4: Build SignedKey protobuf with identity pubkey + signature
  final signedKey = _encodeSignedKey(identityPubBytes, signature);

  final hexValue = signedKey
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();

  // Step 5: Create cert with libp2p extension (OID 1.3.6.1.4.1.53594.1)
  await File(extPath).writeAsString('''
[req]
distinguished_name = req_dn
x509_extensions = v3_ext
prompt = no

[req_dn]
serialNumber = 0

[v3_ext]
1.3.6.1.4.1.53594.1.1 = DER:$hexValue
basicConstraints = CA:FALSE
''');

  result = await Process.run('openssl', [
    'req', '-new', '-x509',
    '-key', keyPath,
    '-out', certPath,
    '-days', '1',
    '-config', extPath,
  ]);
  if (result.exitCode != 0) {
    throw StateError('Failed to generate cert: ${result.stderr}');
  }

  return (certPath, keyPath);
}

/// Derives a libp2p peer ID from an Ed25519 public key.
///
/// Format: multihash(SHA-256(protobuf(KeyType=Ed25519, Data=pubkey)))
/// Then base58-encoded with "12D3KooW" prefix (for Ed25519 keys > 42 bytes
/// after encoding, which they always are at 38 bytes).
///
/// Actually for Ed25519 keys, the peer ID is the identity multihash
/// of the protobuf-encoded key (since it's small enough).
String derivePeerId(Uint8List ed25519PubKey) {
  // Encode as libp2p protobuf PublicKey
  final encoded = Uint8List.fromList([
    0x08, 0x01, // field 1: type = Ed25519 (1)
    0x12, 0x20, // field 2: data, length 32
    ...ed25519PubKey,
  ]);

  // For keys <= 42 bytes, peer ID = identity multihash (no hashing)
  // Identity multihash: code=0x00, length=encoded.length, data=encoded
  if (encoded.length <= 42) {
    final mh = Uint8List.fromList([
      0x00, // identity hash function
      encoded.length,
      ...encoded,
    ]);
    return _base58Encode(mh);
  }

  // For larger keys, use SHA-256 multihash
  // (shouldn't happen for Ed25519 but included for completeness)
  throw UnimplementedError('SHA-256 peer ID not needed for Ed25519');
}

const _base58Alphabet =
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

String _base58Encode(Uint8List input) {
  if (input.isEmpty) return '';
  var leadingZeros = 0;
  for (final byte in input) {
    if (byte != 0) break;
    leadingZeros++;
  }
  var value = BigInt.zero;
  for (final byte in input) {
    value = value * BigInt.from(256) + BigInt.from(byte);
  }
  final chars = <String>[];
  final base = BigInt.from(58);
  while (value > BigInt.zero) {
    chars.add(_base58Alphabet[(value % base).toInt()]);
    value = value ~/ base;
  }
  final result = StringBuffer();
  for (var i = 0; i < leadingZeros; i++) {
    result.write('1');
  }
  for (var i = chars.length - 1; i >= 0; i--) {
    result.write(chars[i]);
  }
  return result.toString();
}
