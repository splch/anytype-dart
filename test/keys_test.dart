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

import 'package:anytype_dart/src/crypto/keys.dart';

void main() {
  group('Ed25519SigningKey', () {
    test('fromSeed produces valid keypair', () async {
      // Use a known seed from SLIP-10 test vector 1, path m
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);

      // Public key should match SLIP-10 test vector
      expect(
        hex.encode(key.publicKey.raw),
        'a4b2856bfec510abab89753fac1ac0e1'
        '112364e7d250545963f135f2a33188ed',
      );
    });

    test('sign and verify roundtrip', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      final message = Uint8List.fromList([1, 2, 3, 4, 5]);

      final signature = await key.sign(message);
      expect(signature.length, 64);

      final isValid = await key.publicKey.verify(message, signature);
      expect(isValid, isTrue);
    });

    test('verify rejects wrong message', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      final message = Uint8List.fromList([1, 2, 3, 4, 5]);
      final wrongMessage = Uint8List.fromList([5, 4, 3, 2, 1]);

      final signature = await key.sign(message);
      final isValid = await key.publicKey.verify(wrongMessage, signature);
      expect(isValid, isFalse);
    });

    test('raw key is 64 bytes (seed || pubkey)', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      final raw = key.raw;
      expect(raw.length, 64);
      expect(hex.encode(raw.sublist(0, 32)), hex.encode(seed));
      expect(hex.encode(raw.sublist(32, 64)), hex.encode(key.publicKey.raw));
    });

    test('fromFullKey reconstructs correctly', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final original = await Ed25519SigningKey.fromSeed(seed);
      final restored = Ed25519SigningKey.fromFullKey(original.raw);

      expect(hex.encode(restored.seed), hex.encode(original.seed));
      expect(
        hex.encode(restored.publicKey.raw),
        hex.encode(original.publicKey.raw),
      );
    });

    test('proto marshal/unmarshal roundtrip', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      final proto = key.marshalProto();
      final restored = Ed25519SigningKey.unmarshalProto(proto);

      expect(hex.encode(restored.seed), hex.encode(key.seed));
      expect(
        hex.encode(restored.publicKey.raw),
        hex.encode(key.publicKey.raw),
      );
    });
  });

  group('Ed25519PublicKey', () {
    test('account string starts with A', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      expect(key.publicKey.account, startsWith('A'));
    });

    test('network string starts with N', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      expect(key.publicKey.network, startsWith('N'));
    });

    test('proto marshal/unmarshal roundtrip', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key = await Ed25519SigningKey.fromSeed(seed);
      final proto = key.publicKey.marshalProto();
      final restored = Ed25519PublicKey.unmarshalProto(proto);

      expect(hex.encode(restored.raw), hex.encode(key.publicKey.raw));
    });

    test('equality', () async {
      final seed = Uint8List.fromList(
        hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        ),
      );
      final key1 = await Ed25519SigningKey.fromSeed(seed);
      final key2 = await Ed25519SigningKey.fromSeed(seed);

      expect(key1.publicKey, equals(key2.publicKey));
      expect(key1.publicKey.hashCode, key2.publicKey.hashCode);
    });
  });
}
