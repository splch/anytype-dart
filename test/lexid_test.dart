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

import 'package:test/test.dart';

import 'package:anytype_dart/src/crdt/lexid.dart';

void main() {
  group('LexId', () {
    late LexId lexId;

    setUp(() {
      lexId = LexId();
    });

    group('first()', () {
      test('returns string of minimum length', () {
        final id = lexId.first();
        expect(id.length, lexId.minLen);
      });

      test('uses first character of alphabet', () {
        final id = lexId.first();
        expect(id, '0' * lexId.minLen);
      });
    });

    group('next()', () {
      test('returns first() for empty input', () {
        expect(lexId.next(''), lexId.first());
      });

      test('generates strictly increasing IDs', () {
        var prev = '';
        for (var i = 0; i < 100; i++) {
          final id = lexId.next(prev);
          if (prev.isNotEmpty) {
            expect(
              id.compareTo(prev),
              greaterThan(0),
              reason: '"$id" should be > "$prev" (iteration $i)',
            );
          }
          prev = id;
        }
      });

      test('increments last character when possible', () {
        final id = lexId.next('0000');
        expect(id.compareTo('0000'), greaterThan(0));
      });

      test('handles overflow by extending', () {
        // All max chars should extend
        final maxChar = lexId.chars[lexId.base - 1];
        final allMax = maxChar * 4;
        final id = lexId.next(allMax);
        expect(id.length, greaterThan(4));
        expect(id.compareTo(allMax), greaterThan(0));
      });

      test('result respects minimum length', () {
        final id = lexId.next('');
        expect(id.length, greaterThanOrEqualTo(lexId.minLen));
      });
    });

    group('nextBefore()', () {
      test('generates ID between two values', () {
        final a = '0000';
        final b = 'zzzz';
        final mid = lexId.nextBefore(a, b);
        expect(mid.compareTo(a), greaterThan(0), reason: '"$mid" > "$a"');
        expect(mid.compareTo(b), lessThan(0), reason: '"$mid" < "$b"');
      });

      test('generates ID between adjacent values', () {
        final a = '0000';
        final b = '0001';
        final mid = lexId.nextBefore(a, b);
        expect(mid.compareTo(a), greaterThan(0), reason: '"$mid" > "$a"');
        expect(mid.compareTo(b), lessThan(0), reason: '"$mid" < "$b"');
      });

      test('generates ID between close values', () {
        final a = 'AAAA';
        final b = 'AAAB';
        final mid = lexId.nextBefore(a, b);
        expect(mid.compareTo(a), greaterThan(0));
        expect(mid.compareTo(b), lessThan(0));
      });

      test('works with different length strings', () {
        final a = '0000';
        final b = '00001';
        // Only valid if a < b
        if (a.compareTo(b) < 0) {
          final mid = lexId.nextBefore(a, b);
          expect(mid.compareTo(a), greaterThan(0));
          expect(mid.compareTo(b), lessThan(0));
        }
      });

      test('throws for invalid order', () {
        expect(() => lexId.nextBefore('zzzz', '0000'), throwsArgumentError);
        expect(() => lexId.nextBefore('0000', '0000'), throwsArgumentError);
      });

      test('supports many insertions between same bounds', () {
        var a = '0000';
        final b = 'zzzz';
        for (var i = 0; i < 50; i++) {
          final mid = lexId.nextBefore(a, b);
          expect(mid.compareTo(a), greaterThan(0),
              reason: 'iteration $i: "$mid" > "$a"');
          expect(mid.compareTo(b), lessThan(0),
              reason: 'iteration $i: "$mid" < "$b"');
          a = mid;
        }
      });
    });

    group('ordering properties', () {
      test('sequence of next() maintains order', () {
        final ids = <String>[];
        var prev = '';
        for (var i = 0; i < 200; i++) {
          prev = lexId.next(prev);
          ids.add(prev);
        }

        // Verify sorted order
        for (var i = 1; i < ids.length; i++) {
          expect(ids[i].compareTo(ids[i - 1]), greaterThan(0));
        }
      });

      test('interleaved insertions maintain order', () {
        // Create a sequence: a, b, c
        final a = lexId.next('');
        final c = lexId.next(a);

        // Insert between a and c
        final b = lexId.nextBefore(a, c);
        expect(a.compareTo(b), lessThan(0));
        expect(b.compareTo(c), lessThan(0));
      });
    });

    group('edge cases', () {
      test('custom alphabet', () {
        final lex = LexId(chars: 'abc', minLen: 2, maxLen: 50);
        final first = lex.first();
        expect(first, 'aa');

        final second = lex.next(first);
        expect(second.compareTo(first), greaterThan(0));
      });

      test('rejects unsorted alphabet', () {
        expect(() => LexId(chars: 'cba'), throwsArgumentError);
      });

      test('rejects single-char alphabet', () {
        expect(() => LexId(chars: 'a'), throwsArgumentError);
      });
    });
  });
}
