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

import 'package:anytype_dart/src/crypto/slip10.dart';

void main() {
  group('SLIP-10 Ed25519', () {
    // Test Vector 1 from the SLIP-10 specification
    // Seed: 000102030405060708090a0b0c0d0e0f
    group('Test Vector 1', () {
      late Uint8List seed;

      setUp(() {
        seed = Uint8List.fromList(
          hex.decode('000102030405060708090a0b0c0d0e0f'),
        );
      });

      test('master node (m)', () async {
        final node = Slip10Node.deriveForPath('m', seed);
        expect(
          hex.encode(node.key),
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '00a4b2856bfec510abab89753fac1ac0'
          'e1112364e7d250545963f135f2a33188ed',
        );
      });

      test("m/0'", () async {
        final node = Slip10Node.deriveForPath("m/0'", seed);
        expect(
          hex.encode(node.key),
          '68e0fe46dfb67e368c75379acec591da'
          'd19df3cde26e63b93a8e704f1dade7a3',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '008c8a13df77a28f3445213a0f432fde'
          '644acaa215fc72dcdf300d5efaa85d350c',
        );
      });

      test("m/0'/1'", () async {
        final node = Slip10Node.deriveForPath("m/0'/1'", seed);
        expect(
          hex.encode(node.key),
          'b1d0bad404bf35da785a64ca1ac54b26'
          '17211d2777696fbffaf208f746ae84f2',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '001932a5270f335bed617d5b935c80ae'
          'db1a35bd9fc1e31acafd5372c30f5c1187',
        );
      });

      test("m/0'/1'/2'", () async {
        final node = Slip10Node.deriveForPath("m/0'/1'/2'", seed);
        expect(
          hex.encode(node.key),
          '92a5b23c0b8a99e37d07df3fb9966917'
          'f5d06e02ddbd909c7e184371463e9fc9',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '00ae98736566d30ed0e9d2f4486a64bc'
          '95740d89c7db33f52121f8ea8f76ff0fc1',
        );
      });

      test("m/0'/1'/2'/2'", () async {
        final node = Slip10Node.deriveForPath("m/0'/1'/2'/2'", seed);
        expect(
          hex.encode(node.key),
          '30d1dc7e5fc04c31219ab25a27ae00b5'
          '0f6fd66622f6e9c913253d6511d1e662',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '008abae2d66361c879b900d204ad2cc4'
          '984fa2aa344dd7ddc46007329ac76c429c',
        );
      });

      test("m/0'/1'/2'/2'/1000000000'", () async {
        final node = Slip10Node.deriveForPath(
          "m/0'/1'/2'/2'/1000000000'",
          seed,
        );
        expect(
          hex.encode(node.key),
          '8f94d394a8e8fd6b1bc2f3f49f5c47e3'
          '85281d5c17e65324b0f62483e37e8793',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '003c24da049451555d51a7014a37337a'
          'a4e12d41e485abccfa46b47dfb2af54b7a',
        );
      });
    });

    // Test Vector 2 from the SLIP-10 specification
    group('Test Vector 2', () {
      late Uint8List seed;

      setUp(() {
        seed = Uint8List.fromList(
          hex.decode(
            'fffcf9f6f3f0edeae7e4e1dedbd8d5d2'
            'cfccc9c6c3c0bdbab7b4b1aeaba8a5a2'
            '9f9c999693908d8a8784817e7b787572'
            '6f6c696663605d5a5754514e4b484542',
          ),
        );
      });

      test('master node (m)', () async {
        final node = Slip10Node.deriveForPath('m', seed);
        expect(
          hex.encode(node.key),
          '171cb88b1b3c1db25add599712e36245'
          'd75bc65a1a5c9e18d76f9f2b1eab4012',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '008fe9693f8fa62a4305a140b9764c5e'
          'e01e455963744fe18204b4fb948249308a',
        );
      });

      test("m/0'", () async {
        final node = Slip10Node.deriveForPath("m/0'", seed);
        expect(
          hex.encode(node.key),
          '1559eb2bbec5790b0c65d8693e4d0875'
          'b1747f4970ae8b650486ed7470845635',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '0086fab68dcb57aa196c77c5f264f215'
          'a112c22a912c10d123b0d03c3c28ef1037',
        );
      });

      test("m/0'/2147483647'", () async {
        final node = Slip10Node.deriveForPath("m/0'/2147483647'", seed);
        expect(
          hex.encode(node.key),
          'ea4f5bfe8694d8bb74b7b59404632fd5'
          '968b774ed545e810de9c32a4fb4192f4',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '005ba3b9ac6e90e83effcd25ac4e58a1'
          '365a9e35a3d3ae5eb07b9e4d90bcf7506d',
        );
      });

      test("m/0'/2147483647'/1'", () async {
        final node = Slip10Node.deriveForPath("m/0'/2147483647'/1'", seed);
        expect(
          hex.encode(node.key),
          '3757c7577170179c7868353ada796c83'
          '9135b3d30554bbb74a4b1e4a5a58505c',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '002e66aa57069c86cc18249aecf5cb5a'
          '9cebbfd6fadeab056254763874a9352b45',
        );
      });

      test("m/0'/2147483647'/1'/2147483646'", () async {
        final node = Slip10Node.deriveForPath(
          "m/0'/2147483647'/1'/2147483646'",
          seed,
        );
        expect(
          hex.encode(node.key),
          '5837736c89570de861ebc173b1086da4'
          'f505d4adb387c6a1b1342d5e4ac9ec72',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '00e33c0f7d81d843c572275f287498e8'
          'd408654fdf0d1e065b84e2e6f157aab09b',
        );
      });

      test("m/0'/2147483647'/1'/2147483646'/2'", () async {
        final node = Slip10Node.deriveForPath(
          "m/0'/2147483647'/1'/2147483646'/2'",
          seed,
        );
        expect(
          hex.encode(node.key),
          '551d333177df541ad876a60ea71f0044'
          '7931c0a9da16f227c11ea080d7391b8d',
        );
        final pubKey = await node.publicKeyWithPrefix();
        expect(
          hex.encode(pubKey),
          '0047150c75db263559a70d5778bf36ab'
          'bab30fb061ad69f69ece61a72b0cfa4fc0',
        );
      });
    });

    group('error handling', () {
      test('rejects invalid path', () {
        final seed = Uint8List(16);
        expect(
          () => Slip10Node.deriveForPath('invalid', seed),
          throwsArgumentError,
        );
      });

      test('rejects non-hardened derivation', () {
        final node = Slip10Node.master(Uint8List(16));
        expect(() => node.derive(0), throwsArgumentError);
      });
    });

    group('serialization', () {
      test('marshal/unmarshal roundtrip', () {
        final seed = Uint8List.fromList(
          hex.decode('000102030405060708090a0b0c0d0e0f'),
        );
        final node = Slip10Node.deriveForPath("m/0'", seed);
        final marshaled = node.marshal();
        final restored = Slip10Node.unmarshal(marshaled);
        expect(hex.encode(restored.key), hex.encode(node.key));
        expect(hex.encode(restored.chainCode), hex.encode(node.chainCode));
      });
    });
  });
}
