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

import 'package:anytype_dart/src/crypto/slip21.dart';

void main() {
  group('SLIP-21', () {
    // Test vectors from the official SLIP-0021 specification
    // Seed: c76c4ac4f4e4a00d6b274d5c39c700bb4a7ddc04fbc6f78e85ca75007b5b495f
    //       74a9043eeb77bdd53aa6fc3a0e31462270316fa04b8c19114c8798706cd02ac8
    late Uint8List seed;

    setUp(() {
      seed = Uint8List.fromList(
        hex.decode(
          'c76c4ac4f4e4a00d6b274d5c39c700bb'
          '4a7ddc04fbc6f78e85ca75007b5b495f'
          '74a9043eeb77bdd53aa6fc3a0e31462270316fa04b8c19114c8798706cd02ac8',
        ),
      );
    });

    test('master node (m)', () {
      final node = Slip21Node.deriveForPath('m', seed);
      expect(
        hex.encode(node.symmetricKey),
        'dbf12b44133eaab506a740f6565cc117'
        '228cbf1dd70635cfa8ddfdc9af734756',
      );
    });

    test('m/SLIP-0021', () {
      final node = Slip21Node.deriveForPath('m/SLIP-0021', seed);
      expect(
        hex.encode(node.symmetricKey),
        '1d065e3ac1bbe5c7fad32cf2305f7d70'
        '9dc070d672044a19e610c77cdf33de0d',
      );
    });

    test('m/SLIP-0021/Master encryption key', () {
      final node = Slip21Node.deriveForPath(
        'm/SLIP-0021/Master encryption key',
        seed,
      );
      expect(
        hex.encode(node.symmetricKey),
        'ea163130e35bbafdf5ddee97a17b39ce'
        'f2be4b4f390180d65b54cf05c6a82fde',
      );
    });

    test('m/SLIP-0021/Authentication key', () {
      final node = Slip21Node.deriveForPath(
        'm/SLIP-0021/Authentication key',
        seed,
      );
      expect(
        hex.encode(node.symmetricKey),
        '47194e938ab24cc82bfa25f6486ed54b'
        'ebe79c40ae2a5a32ea6db294d81861a6',
      );
    });

    group('step-by-step derivation', () {
      test('matches path-based derivation', () {
        final byPath = Slip21Node.deriveForPath(
          'm/SLIP-0021/Master encryption key',
          seed,
        );

        final master = Slip21Node.master(seed);
        final child1 = master.derive('SLIP-0021');
        final child2 = child1.derive('Master encryption key');

        expect(
          hex.encode(child2.symmetricKey),
          hex.encode(byPath.symmetricKey),
        );
      });
    });

    group('Slip21KeyDeriver', () {
      test('produces same result as Slip21Node', () {
        final deriver = Slip21KeyDeriver([
          'SLIP-0021',
          'Master encryption key',
        ]);
        final key = deriver.deriveKey(seed);
        expect(
          hex.encode(key),
          'ea163130e35bbafdf5ddee97a17b39ce'
          'f2be4b4f390180d65b54cf05c6a82fde',
        );
      });
    });

    group('error handling', () {
      test('rejects invalid path', () {
        expect(
          () => Slip21Node.deriveForPath('invalid', seed),
          throwsArgumentError,
        );
      });
    });
  });
}
