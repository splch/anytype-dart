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

/// Ed25519 key types with signing, verification, and protobuf marshaling.
///
/// Key format matches the any-sync Go implementation:
///   - Private keys are 64 bytes: seed (32) || public_key (32)
///   - Public keys are 32 bytes
///   - Proto marshaling uses the Key message from crypto.proto
///   - Account strings use Base58 with CRC-16 XMODEM checksum
library;

import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as crypto;

/// Version byte for Account-format key strings (encodes to 'A...').
const int _accountVersion = 0x5b;

/// Version byte for Network-format key strings (encodes to 'N...').
const int _networkVersion = 0xd3;

/// Ed25519 signing key (private key).
///
/// Stores the 32-byte seed and 32-byte public key. Provides signing,
/// proto marshaling, and public key extraction.
class Ed25519SigningKey {
  final Uint8List _seed;
  final Uint8List _publicKeyBytes;

  Ed25519SigningKey._(this._seed, this._publicKeyBytes);

  /// Creates a signing key from a 32-byte Ed25519 seed.
  static Future<Ed25519SigningKey> fromSeed(Uint8List seed) async {
    if (seed.length != 32) {
      throw ArgumentError('Seed must be 32 bytes, got ${seed.length}');
    }
    final algorithm = crypto.Ed25519();
    final keyPair = await algorithm.newKeyPairFromSeed(seed.toList());
    final publicKey = await keyPair.extractPublicKey();
    return Ed25519SigningKey._(
      Uint8List.fromList(seed),
      Uint8List.fromList(publicKey.bytes),
    );
  }

  /// Creates a signing key from a 64-byte full key (seed || publicKey).
  factory Ed25519SigningKey.fromFullKey(Uint8List fullKey) {
    if (fullKey.length == 64) {
      return Ed25519SigningKey._(
        Uint8List.sublistView(fullKey, 0, 32),
        Uint8List.sublistView(fullKey, 32, 64),
      );
    }
    // Some Go implementations store 96 bytes (64-byte priv + 32-byte pub)
    if (fullKey.length == 96) {
      return Ed25519SigningKey._(
        Uint8List.sublistView(fullKey, 0, 32),
        Uint8List.sublistView(fullKey, 64, 96),
      );
    }
    throw ArgumentError(
      'Expected 64 or 96 bytes, got ${fullKey.length}',
    );
  }

  /// Deserializes from protobuf Key message bytes.
  static Ed25519SigningKey unmarshalProto(Uint8List data) {
    final (type, keyData) = _unmarshalKeyProto(data);
    if (type != keyTypeEd25519Private) {
      throw ArgumentError(
        'Expected Ed25519Private key type ($keyTypeEd25519Private), got $type',
      );
    }
    return Ed25519SigningKey.fromFullKey(keyData);
  }

  /// The 32-byte Ed25519 seed.
  Uint8List get seed => Uint8List.fromList(_seed);

  /// The corresponding public key.
  Ed25519PublicKey get publicKey => Ed25519PublicKey(_publicKeyBytes);

  /// The 64-byte raw key (seed || publicKey), matching Go's ed25519.PrivateKey.
  Uint8List get raw {
    final result = Uint8List(64);
    result.setRange(0, 32, _seed);
    result.setRange(32, 64, _publicKeyBytes);
    return result;
  }

  /// Signs a message with this key.
  Future<Uint8List> sign(Uint8List message) async {
    final algorithm = crypto.Ed25519();
    final keyPair = await algorithm.newKeyPairFromSeed(_seed.toList());
    final signature = await algorithm.sign(
      message.toList(),
      keyPair: keyPair,
    );
    return Uint8List.fromList(signature.bytes);
  }

  /// Serializes to protobuf Key message bytes.
  Uint8List marshalProto() {
    return _marshalKeyProto(keyTypeEd25519Private, raw);
  }

  @override
  bool operator ==(Object other) =>
      other is Ed25519SigningKey && _constantTimeEquals(_seed, other._seed);

  @override
  int get hashCode => Object.hashAll(_seed);
}

/// Ed25519 public key.
///
/// Provides signature verification, proto marshaling, and
/// Account/Network string encoding.
class Ed25519PublicKey {
  final Uint8List _bytes;

  Ed25519PublicKey(Uint8List bytes)
      : _bytes = Uint8List.fromList(bytes) {
    if (_bytes.length != 32) {
      throw ArgumentError(
        'Public key must be 32 bytes, got ${_bytes.length}',
      );
    }
  }

  /// Deserializes from protobuf Key message bytes.
  static Ed25519PublicKey unmarshalProto(Uint8List data) {
    final (type, keyData) = _unmarshalKeyProto(data);
    if (type != keyTypeEd25519Public) {
      throw ArgumentError(
        'Expected Ed25519Public key type ($keyTypeEd25519Public), got $type',
      );
    }
    return Ed25519PublicKey(keyData);
  }

  /// The raw 32-byte public key.
  Uint8List get raw => Uint8List.fromList(_bytes);

  /// Verifies an Ed25519 signature over the given data.
  Future<bool> verify(Uint8List data, Uint8List signature) async {
    final algorithm = crypto.Ed25519();
    final publicKey = crypto.SimplePublicKey(
      _bytes.toList(),
      type: crypto.KeyPairType.ed25519,
    );
    final sig = crypto.Signature(
      signature.toList(),
      publicKey: publicKey,
    );
    return algorithm.verify(data.toList(), signature: sig);
  }

  /// Serializes to protobuf Key message bytes.
  Uint8List marshalProto() {
    return _marshalKeyProto(keyTypeEd25519Public, _bytes);
  }

  /// Account-format string (starts with 'A').
  ///
  /// Encoding: Base58(version_byte || raw_key || CRC16_XMODEM(version_byte || raw_key))
  String get account => _encodeStrKey(_accountVersion, _bytes);

  /// Network-format string (starts with 'N').
  String get network => _encodeStrKey(_networkVersion, _bytes);

  @override
  bool operator ==(Object other) =>
      other is Ed25519PublicKey && _constantTimeEquals(_bytes, other._bytes);

  @override
  int get hashCode => Object.hashAll(_bytes);

  @override
  String toString() => 'Ed25519PublicKey(${account})';
}

/// Decodes any proto-encoded key, returning the appropriate type.
Object decodeKeyFromProto(Uint8List data) {
  final (type, keyData) = _unmarshalKeyProto(data);
  switch (type) {
    case keyTypeEd25519Public:
      return Ed25519PublicKey(keyData);
    case keyTypeEd25519Private:
      return Ed25519SigningKey.fromFullKey(keyData);
    default:
      throw ArgumentError('Unknown key type: $type');
  }
}

// --- Proto wire-format constants for crypto.proto Key message ---
// Avoids dependency on generated protobuf code with version compatibility issues.
//
// message Key { KeyType Type = 1; bytes Data = 2; }
// enum KeyType { Ed25519Public = 0; Ed25519Private = 1; AES = 2; }

/// KeyType enum values matching crypto.proto.
const int keyTypeEd25519Public = 0;
const int keyTypeEd25519Private = 1;
const int keyTypeAes = 2;

/// Hand-coded protobuf marshaling for the Key message.
///
/// Wire format:
///   field 1 (varint): 0x08 <type>
///   field 2 (bytes):  0x12 <length_varint> <data>
Uint8List _marshalKeyProto(int type, Uint8List data) {
  final lengthBytes = _encodeVarint(data.length);
  // field 1: tag (0x08) + type varint
  // field 2: tag (0x12) + length varint + data
  final typeBytes = _encodeVarint(type);
  final result = Uint8List(
    1 + typeBytes.length + 1 + lengthBytes.length + data.length,
  );
  var offset = 0;
  result[offset++] = 0x08; // field 1, wire type 0 (varint)
  result.setRange(offset, offset + typeBytes.length, typeBytes);
  offset += typeBytes.length;
  result[offset++] = 0x12; // field 2, wire type 2 (length-delimited)
  result.setRange(offset, offset + lengthBytes.length, lengthBytes);
  offset += lengthBytes.length;
  result.setRange(offset, offset + data.length, data);
  return result;
}

/// Hand-coded protobuf unmarshaling for the Key message.
(int type, Uint8List data) _unmarshalKeyProto(Uint8List buf) {
  var type = 0;
  Uint8List? data;
  var pos = 0;

  while (pos < buf.length) {
    final (tag, newPos) = _decodeVarint(buf, pos);
    pos = newPos;
    final fieldNumber = tag >> 3;
    final wireType = tag & 0x07;

    if (fieldNumber == 1 && wireType == 0) {
      // varint
      final (value, np) = _decodeVarint(buf, pos);
      type = value;
      pos = np;
    } else if (fieldNumber == 2 && wireType == 2) {
      // length-delimited
      final (length, np) = _decodeVarint(buf, pos);
      pos = np;
      data = Uint8List.sublistView(buf, pos, pos + length);
      pos += length;
    } else {
      // Skip unknown field
      if (wireType == 0) {
        final (_, np) = _decodeVarint(buf, pos);
        pos = np;
      } else if (wireType == 2) {
        final (length, np) = _decodeVarint(buf, pos);
        pos = np + length;
      } else {
        throw ArgumentError('Unsupported wire type: $wireType');
      }
    }
  }

  if (data == null) throw ArgumentError('Missing Data field in Key message');
  return (type, data);
}

Uint8List _encodeVarint(int value) {
  if (value < 0) throw ArgumentError('Negative varint');
  if (value < 128) return Uint8List.fromList([value]);
  final bytes = <int>[];
  var v = value;
  while (v > 0) {
    bytes.add((v & 0x7F) | (v > 0x7F ? 0x80 : 0));
    v >>= 7;
  }
  return Uint8List.fromList(bytes);
}

(int value, int newPos) _decodeVarint(Uint8List buf, int pos) {
  var result = 0;
  var shift = 0;
  while (pos < buf.length) {
    final byte = buf[pos++];
    result |= (byte & 0x7F) << shift;
    if (byte & 0x80 == 0) return (result, pos);
    shift += 7;
  }
  throw ArgumentError('Incomplete varint');
}

// --- Strkey encoding (Stellar-style Base58 + CRC-16 XMODEM) ---

String _encodeStrKey(int version, Uint8List data) {
  final payload = Uint8List(1 + data.length + 2);
  payload[0] = version;
  payload.setRange(1, 1 + data.length, data);

  final checksum = _crc16Xmodem(Uint8List.sublistView(payload, 0, 1 + data.length));
  // Little-endian checksum
  payload[1 + data.length] = checksum & 0xFF;
  payload[1 + data.length + 1] = (checksum >> 8) & 0xFF;

  return _base58Encode(payload);
}

/// CRC-16 XMODEM (polynomial 0x1021, initial value 0x0000).
int _crc16Xmodem(Uint8List data) {
  var crc = 0;
  for (final byte in data) {
    crc ^= byte << 8;
    for (var j = 0; j < 8; j++) {
      if (crc & 0x8000 != 0) {
        crc = (crc << 1) ^ 0x1021;
      } else {
        crc <<= 1;
      }
      crc &= 0xFFFF;
    }
  }
  return crc;
}

const _base58Alphabet =
    '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

String _base58Encode(Uint8List input) {
  if (input.isEmpty) return '';

  // Count leading zeros
  var leadingZeros = 0;
  for (final byte in input) {
    if (byte != 0) break;
    leadingZeros++;
  }

  // Convert byte array to BigInt
  var value = BigInt.zero;
  for (final byte in input) {
    value = value * BigInt.from(256) + BigInt.from(byte);
  }

  // Convert to base58
  final chars = <String>[];
  final base = BigInt.from(58);
  while (value > BigInt.zero) {
    final remainder = value % base;
    chars.add(_base58Alphabet[remainder.toInt()]);
    value = value ~/ base;
  }

  // Add leading '1' for each leading zero byte
  final result = StringBuffer();
  for (var i = 0; i < leadingZeros; i++) {
    result.write('1');
  }
  for (var i = chars.length - 1; i >= 0; i--) {
    result.write(chars[i]);
  }
  return result.toString();
}

/// Constant-time byte comparison to prevent timing attacks.
bool _constantTimeEquals(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  var result = 0;
  for (var i = 0; i < a.length; i++) {
    result |= a[i] ^ b[i];
  }
  return result == 0;
}
