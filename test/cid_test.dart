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

import 'package:anytype_dart/src/crypto/cid.dart';
import 'package:anytype_dart/src/crypto/hash_utils.dart';

void main() {
  group('CID', () {
    test('cidBytes produces correct format', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final cid = cidBytes(data);

      // CID v1 header
      expect(cid[0], 0x01); // version
      expect(cid[1], 0x71); // DagCBOR codec
      expect(cid[2], 0x12); // SHA2-256
      expect(cid[3], 0x20); // 32 bytes digest

      // Total length: 4 header + 32 hash = 36 bytes
      expect(cid.length, 36);

      // Verify embedded hash matches SHA-256
      final expectedHash = sha256(data);
      expect(cid.sublist(4), equals(expectedHash));
    });

    test('cidString starts with b (base32lower multibase)', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final cid = cidString(data);
      expect(cid, startsWith('b'));
    });

    test('verifyCid returns true for matching data', () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final cid = cidString(data);
      expect(verifyCid(data, cid), isTrue);
    });

    test('verifyCid returns false for wrong data', () {
      final data1 = Uint8List.fromList([1, 2, 3, 4, 5]);
      final data2 = Uint8List.fromList([5, 4, 3, 2, 1]);
      final cid = cidString(data1);
      expect(verifyCid(data2, cid), isFalse);
    });

    test('deterministic: same input produces same CID', () {
      final data = Uint8List.fromList([72, 101, 108, 108, 111]); // "Hello"
      final cid1 = cidString(data);
      final cid2 = cidString(data);
      expect(cid1, cid2);
    });

    test('different inputs produce different CIDs', () {
      final data1 = Uint8List.fromList([1]);
      final data2 = Uint8List.fromList([2]);
      expect(cidString(data1), isNot(cidString(data2)));
    });

    test('empty data produces valid CID', () {
      final data = Uint8List(0);
      final cid = cidString(data);
      expect(cid, startsWith('b'));
      expect(verifyCid(data, cid), isTrue);
    });

    test('SHA-256 of known input matches expected', () {
      // SHA-256("") = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
      final emptyHash = sha256(Uint8List(0));
      expect(
        hex.encode(emptyHash),
        'e3b0c44298fc1c149afbf4c8996fb924'
        '27ae41e4649b934ca495991b7852b855',
      );
    });
  });
}
