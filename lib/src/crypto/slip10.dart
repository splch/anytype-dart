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

/// SLIP-10 Ed25519 hierarchical deterministic key derivation.
///
/// Reference: https://github.com/satoshilabs/slips/blob/master/slip-0010.md
/// Reimplemented from the MIT-licensed Go implementation at
/// github.com/anyproto/go-slip10.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart' as crypto;

import 'hash_utils.dart';

/// The first index that is considered hardened (2^31).
const int firstHardenedIndex = 0x80000000;

final RegExp _pathRegex = RegExp(r"^m(/\d+')*$");

/// A node in the SLIP-10 key derivation tree.
///
/// Holds a 32-byte key (Ed25519 seed) and 32-byte chain code.
class Slip10Node {
  /// The 32-byte Ed25519 private key seed.
  final Uint8List key;

  /// The 32-byte chain code for child derivation.
  final Uint8List chainCode;

  Slip10Node(this.key, this.chainCode) {
    if (key.length != 32) {
      throw ArgumentError('Key must be 32 bytes, got ${key.length}');
    }
    if (chainCode.length != 32) {
      throw ArgumentError(
        'Chain code must be 32 bytes, got ${chainCode.length}',
      );
    }
  }

  /// Creates a master node from a root seed.
  ///
  /// The seed is typically 16-64 bytes (e.g. from BIP-39 mnemonic).
  /// Uses HMAC-SHA512 with key "ed25519 seed".
  factory Slip10Node.master(Uint8List seed) {
    final key = Uint8List.fromList(utf8.encode('ed25519 seed'));
    final hash = hmacSha512(key, seed);
    return Slip10Node(
      Uint8List.sublistView(hash, 0, 32),
      Uint8List.sublistView(hash, 32, 64),
    );
  }

  /// Derives a child node at the given hardened index.
  ///
  /// Only hardened derivation is supported for Ed25519 (index >= 2^31).
  Slip10Node derive(int index) {
    if (index < firstHardenedIndex) {
      throw ArgumentError(
        'Only hardened derivation is supported for Ed25519. '
        'Index must be >= $firstHardenedIndex, got $index',
      );
    }

    // data = 0x00 || key (32 bytes) || index (4 bytes big-endian)
    final data = Uint8List(37);
    data[0] = 0x00;
    data.setRange(1, 33, key);
    data.buffer.asByteData().setUint32(33, index, Endian.big);

    final hash = hmacSha512(chainCode, data);
    return Slip10Node(
      Uint8List.sublistView(hash, 0, 32),
      Uint8List.sublistView(hash, 32, 64),
    );
  }

  /// Derives a key at the given BIP-32 style path from a root seed.
  ///
  /// Path format: `m/index'/index'/...` (all indices must be hardened).
  /// Example: `m/44'/2046'/0'`
  static Slip10Node deriveForPath(String path, Uint8List seed) {
    if (!_pathRegex.hasMatch(path)) {
      throw ArgumentError('Invalid derivation path: $path');
    }

    var node = Slip10Node.master(seed);
    if (path == 'm') return node;

    final segments = path.split('/').skip(1); // skip "m"
    for (final segment in segments) {
      final indexStr = segment.substring(0, segment.length - 1); // remove "'"
      final index = int.parse(indexStr) + firstHardenedIndex;
      node = node.derive(index);
    }
    return node;
  }

  /// Returns the Ed25519 public key (32 bytes) derived from the seed.
  Future<Uint8List> publicKey() async {
    final algorithm = crypto.Ed25519();
    final keyPair = await algorithm.newKeyPairFromSeed(key.toList());
    final pubKey = await keyPair.extractPublicKey();
    return Uint8List.fromList(pubKey.bytes);
  }

  /// Returns the public key with a 0x00 prefix (33 bytes), as per SLIP-10.
  Future<Uint8List> publicKeyWithPrefix() async {
    final pubKey = await publicKey();
    final prefixed = Uint8List(33);
    prefixed[0] = 0x00;
    prefixed.setRange(1, 33, pubKey);
    return prefixed;
  }

  /// Serializes the node to 64 bytes: key || chainCode.
  Uint8List marshal() {
    final result = Uint8List(64);
    result.setRange(0, 32, key);
    result.setRange(32, 64, chainCode);
    return result;
  }

  /// Deserializes a node from 64 bytes.
  factory Slip10Node.unmarshal(Uint8List data) {
    if (data.length != 64) {
      throw ArgumentError('Expected 64 bytes, got ${data.length}');
    }
    return Slip10Node(
      Uint8List.sublistView(data, 0, 32),
      Uint8List.sublistView(data, 32, 64),
    );
  }
}
