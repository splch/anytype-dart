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

/// AES-256-GCM authenticated encryption.
///
/// Wire format matches the any-sync Go implementation:
///   encrypt(key, plaintext) → nonce (12 bytes) || ciphertext || tag (16 bytes)
///   decrypt(key, data) → plaintext
library;

import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Size of the AES-256 key in bytes.
const int aesKeySize = 32;

/// Size of the GCM nonce in bytes.
const int aesNonceSize = 12;

/// Size of the GCM authentication tag in bytes.
const int aesTagSize = 16;

/// AES-256-GCM symmetric key for encryption and decryption.
///
/// Wire format: nonce (12 bytes) || ciphertext || tag (16 bytes)
/// This matches the Go any-sync implementation where the nonce is
/// prepended and the GCM tag is appended to the ciphertext.
class AesKey {
  final Uint8List _bytes;

  AesKey(this._bytes) {
    if (_bytes.length != aesKeySize) {
      throw ArgumentError(
        'AES key must be $aesKeySize bytes, got ${_bytes.length}',
      );
    }
  }

  /// Creates an AES key from raw bytes.
  factory AesKey.fromBytes(List<int> bytes) =>
      AesKey(Uint8List.fromList(bytes));

  /// The raw 32-byte key.
  Uint8List get raw => Uint8List.fromList(_bytes);

  /// Encrypts plaintext using AES-256-GCM.
  ///
  /// Returns: nonce (12 bytes) || ciphertext || tag (16 bytes).
  Future<Uint8List> encrypt(Uint8List plaintext) async {
    final algorithm = AesGcm.with256bits();
    final secretKey = SecretKey(_bytes.toList());

    final box = await algorithm.encrypt(
      plaintext.toList(),
      secretKey: secretKey,
    );

    // Wire format: nonce || ciphertext || mac
    final result = Uint8List(
      box.nonce.length + box.cipherText.length + box.mac.bytes.length,
    );
    var offset = 0;
    result.setRange(offset, offset + box.nonce.length, box.nonce);
    offset += box.nonce.length;
    result.setRange(offset, offset + box.cipherText.length, box.cipherText);
    offset += box.cipherText.length;
    result.setRange(offset, offset + box.mac.bytes.length, box.mac.bytes);
    return result;
  }

  /// Decrypts data produced by [encrypt].
  ///
  /// Expects: nonce (12 bytes) || ciphertext || tag (16 bytes).
  Future<Uint8List> decrypt(Uint8List data) async {
    if (data.length < aesNonceSize + aesTagSize) {
      throw ArgumentError(
        'Encrypted data too short: ${data.length} bytes '
        '(minimum ${aesNonceSize + aesTagSize})',
      );
    }

    final nonce = data.sublist(0, aesNonceSize);
    final cipherText = data.sublist(aesNonceSize, data.length - aesTagSize);
    final mac = Mac(data.sublist(data.length - aesTagSize));

    final box = SecretBox(cipherText, nonce: nonce, mac: mac);

    final algorithm = AesGcm.with256bits();
    final secretKey = SecretKey(_bytes.toList());

    final plaintext = await algorithm.decrypt(box, secretKey: secretKey);
    return Uint8List.fromList(plaintext);
  }

  @override
  bool operator ==(Object other) =>
      other is AesKey && _constantTimeEquals(_bytes, other._bytes);

  @override
  int get hashCode => Object.hashAll(_bytes);
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
