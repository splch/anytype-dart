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

/// SLIP-21 symmetric key derivation.
///
/// Reference: https://github.com/satoshilabs/slips/blob/master/slip-0021.md
/// Reimplemented from the MIT-licensed Go implementation at
/// github.com/anyproto/go-slip21.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'hash_utils.dart';

final RegExp _pathRegex = RegExp(r'^m(/.+)*$');

/// A node in the SLIP-21 key derivation tree.
///
/// Each node holds a 32-byte symmetric key and a 32-byte chain code.
/// Unlike SLIP-10, child derivation uses arbitrary string labels
/// instead of numeric indices.
class Slip21Node {
  /// The 32-byte chain code (used as HMAC key for child derivation).
  ///
  /// Note: in SLIP-21, the chain code is the *first* 32 bytes of the
  /// HMAC output, and the key is the *last* 32 bytes. This is reversed
  /// from SLIP-10.
  final Uint8List chainCode;

  /// The 32-byte symmetric key.
  final Uint8List key;

  Slip21Node(this.chainCode, this.key) {
    if (chainCode.length != 32) {
      throw ArgumentError(
        'Chain code must be 32 bytes, got ${chainCode.length}',
      );
    }
    if (key.length != 32) {
      throw ArgumentError('Key must be 32 bytes, got ${key.length}');
    }
  }

  /// Creates a master node from a seed.
  ///
  /// Uses HMAC-SHA512 with key "Symmetric key seed".
  /// The first 32 bytes of output become the chain code,
  /// the last 32 bytes become the master key.
  factory Slip21Node.master(Uint8List seed) {
    final hmacKey = Uint8List.fromList(utf8.encode('Symmetric key seed'));
    final hash = hmacSha512(hmacKey, seed);
    return Slip21Node(
      Uint8List.sublistView(hash, 0, 32),
      Uint8List.sublistView(hash, 32, 64),
    );
  }

  /// Derives a child node using a string label.
  ///
  /// The derivation data is: 0x00 || label_bytes.
  /// HMAC-SHA512 is keyed with the parent's chain code.
  Slip21Node derive(String label) {
    final labelBytes = utf8.encode(label);
    final data = Uint8List(1 + labelBytes.length);
    data[0] = 0x00;
    data.setRange(1, data.length, labelBytes);

    final hash = hmacSha512(chainCode, data);
    return Slip21Node(
      Uint8List.sublistView(hash, 0, 32),
      Uint8List.sublistView(hash, 32, 64),
    );
  }

  /// Derives a key at the given path from a seed.
  ///
  /// Path format: `m/label1/label2/...`
  /// Example: `m/SLIP-0021/Master encryption key`
  static Slip21Node deriveForPath(String path, Uint8List seed) {
    if (!_pathRegex.hasMatch(path)) {
      throw ArgumentError('Invalid derivation path: $path');
    }

    var node = Slip21Node.master(seed);
    if (path == 'm') return node;

    final segments = path.split('/').skip(1); // skip "m"
    for (final label in segments) {
      node = node.derive(label);
    }
    return node;
  }

  /// Returns the 32-byte symmetric key.
  Uint8List get symmetricKey => key;
}

/// Pre-computed key deriver for efficient repeated derivation with
/// different seeds but the same path structure.
///
/// Used by the any-sync protocol for deriving per-object encryption keys.
class Slip21KeyDeriver {
  final List<Uint8List> _labels;

  Slip21KeyDeriver(List<String> pathLabels)
      : _labels = pathLabels
            .map((label) {
              final bytes = utf8.encode(label);
              final data = Uint8List(1 + bytes.length);
              data[0] = 0x00;
              data.setRange(1, data.length, bytes);
              return data;
            })
            .toList(growable: false);

  /// Derives a symmetric key from the given seed through all labels.
  Uint8List deriveKey(Uint8List seed) {
    var node = Slip21Node.master(seed);
    for (final label in _labels) {
      final hash = hmacSha512(node.chainCode, label);
      node = Slip21Node(
        Uint8List.sublistView(hash, 0, 32),
        Uint8List.sublistView(hash, 32, 64),
      );
    }
    return node.key;
  }
}
