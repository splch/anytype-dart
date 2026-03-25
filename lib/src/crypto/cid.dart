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

/// IPFS-compatible Content Identifier (CID) computation.
///
/// Uses CID v1 with DagCBOR codec and SHA-256 multihash,
/// matching the any-sync Go implementation.
library;

import 'dart:typed_data';

import 'hash_utils.dart';

/// Multihash function code for SHA2-256.
const int _sha2_256Code = 0x12;

/// SHA-256 digest size.
const int _sha256DigestSize = 0x20;

/// CID version 1.
const int _cidVersion = 0x01;

/// DagCBOR multicodec code.
const int _dagCborCodec = 0x71;

/// RFC 4648 base32 lowercase alphabet (no padding).
const String _base32Alphabet = 'abcdefghijklmnopqrstuvwxyz234567';

/// Computes a CID v1 (DagCBOR, SHA-256) for the given data.
///
/// Returns the raw CID bytes:
///   version (0x01) || codec (0x71) || multihash_code (0x12) || digest_size (0x20) || sha256(data)
Uint8List cidBytes(Uint8List data) {
  final hash = sha256(data);

  // CID v1 binary: version || codec || multihash
  // All values < 128 so single-byte varints
  final cid = Uint8List(4 + _sha256DigestSize);
  cid[0] = _cidVersion;
  cid[1] = _dagCborCodec;
  cid[2] = _sha2_256Code;
  cid[3] = _sha256DigestSize;
  cid.setRange(4, 4 + _sha256DigestSize, hash);
  return cid;
}

/// Computes a CID v1 string (multibase base32lower) for the given data.
///
/// Format: 'b' + base32lower(cid_bytes) — no padding.
String cidString(Uint8List data) {
  final bytes = cidBytes(data);
  return 'b${_base32EncodeNoPad(bytes)}';
}

/// Verifies that a CID string matches the given data.
bool verifyCid(Uint8List data, String cid) {
  return cidString(data) == cid;
}

/// RFC 4648 base32 lowercase encoding without padding.
String _base32EncodeNoPad(Uint8List data) {
  final result = StringBuffer();
  var buffer = 0;
  var bitsLeft = 0;

  for (final byte in data) {
    buffer = (buffer << 8) | byte;
    bitsLeft += 8;
    while (bitsLeft >= 5) {
      bitsLeft -= 5;
      result.write(_base32Alphabet[(buffer >> bitsLeft) & 0x1F]);
    }
  }

  // Encode remaining bits (if any)
  if (bitsLeft > 0) {
    result.write(_base32Alphabet[(buffer << (5 - bitsLeft)) & 0x1F]);
  }

  return result.toString();
}
