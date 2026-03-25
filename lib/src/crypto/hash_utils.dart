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

import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/api.dart' show KeyParameter;

/// Computes HMAC-SHA512.
Uint8List hmacSha512(Uint8List key, Uint8List data) {
  final hmac = HMac(SHA512Digest(), 128);
  hmac.init(KeyParameter(key));
  return hmac.process(data);
}

/// Computes SHA-256 hash.
Uint8List sha256(Uint8List data) {
  final digest = SHA256Digest();
  return digest.process(data);
}
