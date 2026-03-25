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

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:test/test.dart';

import 'package:anytype_dart/src/crypto/aes_gcm.dart';

void main() {
  group('AES-256-GCM', () {
    test('encrypt/decrypt roundtrip', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);

      final encrypted = await key.encrypt(plaintext);
      final decrypted = await key.decrypt(encrypted);

      expect(decrypted, equals(plaintext));
    });

    test('ciphertext format: nonce (12) + ciphertext + tag (16)', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List.fromList([1, 2, 3, 4, 5]);

      final encrypted = await key.encrypt(plaintext);

      // nonce (12) + ciphertext (same length as plaintext = 5) + tag (16)
      expect(encrypted.length, 12 + 5 + 16);
    });

    test('different encryptions produce different nonces', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List.fromList([1, 2, 3]);

      final encrypted1 = await key.encrypt(plaintext);
      final encrypted2 = await key.encrypt(plaintext);

      // Nonces (first 12 bytes) should differ
      final nonce1 = encrypted1.sublist(0, 12);
      final nonce2 = encrypted2.sublist(0, 12);
      expect(hex.encode(nonce1), isNot(hex.encode(nonce2)));

      // But both should decrypt to the same plaintext
      expect(await key.decrypt(encrypted1), equals(plaintext));
      expect(await key.decrypt(encrypted2), equals(plaintext));
    });

    test('decrypt rejects tampered ciphertext', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List.fromList([1, 2, 3, 4, 5]);
      final encrypted = await key.encrypt(plaintext);

      // Tamper with ciphertext byte
      encrypted[15] ^= 0xFF;

      expect(() => key.decrypt(encrypted), throwsA(anything));
    });

    test('decrypt rejects wrong key', () async {
      final key1 = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final key2 = AesKey(
        Uint8List.fromList(List.generate(32, (i) => i + 1)),
      );
      final plaintext = Uint8List.fromList([1, 2, 3, 4, 5]);

      final encrypted = await key1.encrypt(plaintext);
      expect(() => key2.decrypt(encrypted), throwsA(anything));
    });

    test('empty plaintext', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List(0);

      final encrypted = await key.encrypt(plaintext);
      // nonce (12) + tag (16) = 28 bytes minimum
      expect(encrypted.length, 12 + 0 + 16);

      final decrypted = await key.decrypt(encrypted);
      expect(decrypted, equals(plaintext));
    });

    test('large plaintext', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      final plaintext = Uint8List.fromList(
        List.generate(10000, (i) => i % 256),
      );

      final encrypted = await key.encrypt(plaintext);
      final decrypted = await key.decrypt(encrypted);
      expect(decrypted, equals(plaintext));
    });

    test('rejects invalid key size', () {
      expect(() => AesKey(Uint8List(16)), throwsArgumentError);
      expect(() => AesKey(Uint8List(31)), throwsArgumentError);
      expect(() => AesKey(Uint8List(33)), throwsArgumentError);
    });

    test('rejects too-short ciphertext', () async {
      final key = AesKey(Uint8List.fromList(List.generate(32, (i) => i)));
      expect(
        () => key.decrypt(Uint8List(10)),
        throwsArgumentError,
      );
    });
  });
}
