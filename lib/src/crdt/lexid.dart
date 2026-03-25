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

/// Dense lexicographic ID generation for deterministic change ordering.
///
/// Reimplemented from the MIT-licensed github.com/anyproto/lexid library.
/// Generates string IDs that maintain lexicographic ordering and support
/// arbitrary insertions between existing values.
///
/// Properties:
///   - Deterministic: same inputs always produce same output
///   - Dense: IDs use minimal length
///   - Ordered: string comparison preserves insertion order
///   - Insertable: can always generate an ID between two existing ones
library;

/// Default character set matching `CharsAllNoEscape` in the Go library.
/// All printable ASCII characters that don't require escaping, in sorted order.
const String defaultLexIdChars =
    '0123456789'
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    'abcdefghijklmnopqrstuvwxyz';

/// Generates dense, lexicographically ordered string IDs.
///
/// Used by the CRDT change tree for deterministic ordering of changes.
/// Each change gets an OrderId such that topological order is preserved
/// and all peers compute identical orderings.
class LexId {
  /// The character alphabet, must be in sorted order.
  final String chars;

  /// Minimum ID length.
  final int minLen;

  /// Maximum ID length.
  final int maxLen;

  /// Number of characters in the alphabet (base of the number system).
  final int base;

  /// Pre-computed index lookup for O(1) character → index.
  final Map<int, int> _charIndex;

  LexId({
    this.chars = defaultLexIdChars,
    this.minLen = 4,
    this.maxLen = 100,
  })  : base = chars.length,
        _charIndex = {
          for (var i = 0; i < chars.length; i++)
            chars.codeUnitAt(i): i,
        } {
    if (chars.length < 2) {
      throw ArgumentError('Alphabet must have at least 2 characters');
    }
    if (minLen < 1) {
      throw ArgumentError('minLen must be >= 1');
    }
    // Verify alphabet is sorted
    for (var i = 1; i < chars.length; i++) {
      if (chars.codeUnitAt(i) <= chars.codeUnitAt(i - 1)) {
        throw ArgumentError('Alphabet must be in strictly ascending order');
      }
    }
  }

  /// Index of character in alphabet, or -1 if not found.
  int _indexOf(int codeUnit) => _charIndex[codeUnit] ?? -1;

  /// Character at index in alphabet.
  String _charAt(int index) => chars[index];

  /// Generate the first ID (smallest possible).
  String first() => chars[0] * minLen;

  /// Generate the next ID after [prev].
  ///
  /// Returns the smallest dense ID that is lexicographically greater
  /// than [prev]. If [prev] is empty, returns [first()].
  String next(String prev) {
    if (prev.isEmpty) return first();

    // Try incrementing from the rightmost position
    final units = prev.codeUnits.toList();
    for (var i = units.length - 1; i >= 0; i--) {
      final idx = _indexOf(units[i]);
      if (idx < 0) {
        throw ArgumentError(
          'Character "${String.fromCharCode(units[i])}" not in alphabet',
        );
      }
      if (idx < base - 1) {
        // Can increment at this position — truncate and return
        units[i] = chars.codeUnitAt(idx + 1);
        final result = String.fromCharCodes(units.sublist(0, i + 1));
        // Ensure minimum length by padding with first char
        if (result.length < minLen) {
          return result.padRight(minLen, chars[0]);
        }
        return result;
      }
      // This position is at max — reset and carry
      units[i] = chars.codeUnitAt(0);
    }

    // All positions overflowed — extend by appending mid-range character
    if (prev.length >= maxLen) {
      throw StateError('Cannot generate next ID: max length $maxLen reached');
    }
    return prev + _charAt(base ~/ 2);
  }

  /// Generate an ID strictly between [after] and [before].
  ///
  /// Returns a string `s` such that `after < s < before` lexicographically.
  /// Throws if no such string can be generated.
  String nextBefore(String after, String before) {
    if (after.compareTo(before) >= 0) {
      throw ArgumentError('"after" must be < "before": "$after" >= "$before"');
    }

    return _midpoint(after, before);
  }

  /// Computes a string between [a] and [b] where a < b.
  String _midpoint(String a, String b) {
    final result = StringBuffer();
    final maxDigits = a.length > b.length ? a.length + 1 : b.length + 1;

    for (var i = 0; i < maxDigits; i++) {
      final aDigit = i < a.length ? _indexOf(a.codeUnitAt(i)) : 0;
      final bDigit = i < b.length ? _indexOf(b.codeUnitAt(i)) : base;

      if (aDigit < 0 || (bDigit < 0 && i < b.length)) {
        throw ArgumentError('Character not in alphabet');
      }

      if (aDigit == bDigit) {
        result.write(_charAt(aDigit));
        continue;
      }

      // There's a gap at this position
      if (bDigit - aDigit > 1) {
        // Room for a midpoint character
        result.write(_charAt((aDigit + bDigit) ~/ 2));
        final s = result.toString();
        return s.length < minLen ? s.padRight(minLen, chars[0]) : s;
      }

      // Adjacent digits (bDigit == aDigit + 1) — need to go deeper.
      // Keep aDigit at this position and find midpoint in suffix range.
      result.write(_charAt(aDigit));

      // We're now looking for a midpoint between:
      //   a's remaining suffix and the "max" suffix (all last-chars)
      // This gives us room to insert between the two adjacent values.
      final aSuffix = i + 1 < a.length ? a.substring(i + 1) : '';
      final bSuffix = _charAt(base - 1) * (maxDigits - i - 1);

      if (aSuffix.isEmpty || aSuffix.compareTo(bSuffix) < 0) {
        // Find midpoint in suffix space
        final mid = _suffixMidpoint(aSuffix, base - 1, maxDigits - i - 1);
        result.write(mid);
        final s = result.toString();
        return s.length < minLen ? s.padRight(minLen, chars[0]) : s;
      }
    }

    throw StateError('Cannot generate midpoint between "$a" and "$b"');
  }

  /// Generates a midpoint between [suffix] and a string of [maxChar] repeated.
  String _suffixMidpoint(String suffix, int maxCharIdx, int targetLen) {
    final buf = StringBuffer();

    for (var i = 0; i < targetLen; i++) {
      final sDigit = i < suffix.length ? _indexOf(suffix.codeUnitAt(i)) : 0;
      final mid = (sDigit + maxCharIdx + 1) ~/ 2;

      if (mid > sDigit) {
        buf.write(_charAt(mid));
        return buf.toString();
      }

      buf.write(_charAt(sDigit));
    }

    // Extend by one more character at midpoint
    buf.write(_charAt(base ~/ 2));
    return buf.toString();
  }
}

/// The default LexId instance matching the any-sync configuration.
final defaultLexId = LexId(
  chars: defaultLexIdChars,
  minLen: 4,
  maxLen: 100,
);
