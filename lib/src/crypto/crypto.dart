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

/// Cryptographic primitives for the any-sync protocol.
///
/// Provides SLIP-10/21 key derivation, Ed25519 signing, AES-256-GCM
/// encryption, CID computation, and account identity management.
library;

export 'account.dart';
export 'aes_gcm.dart';
export 'cid.dart';
export 'hash_utils.dart' show hmacSha512, sha256;
export 'keys.dart';
export 'slip10.dart';
export 'slip21.dart';
