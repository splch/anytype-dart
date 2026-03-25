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

/// Account identity and key generation.
///
/// Implements the Anytype key hierarchy:
///   BIP-39 mnemonic → seed → SLIP-10 master/identity keys
///                           → SLIP-21 symmetric keys (space, per-object)
///
/// Key derivation paths (from the any-sync MIT-licensed Go code):
///   Master key:   m/44'/2046'/index'
///   Identity key: m/44'/2046'/index'/0'
///   Space key:    m/SLIP-0021/anysync/space
///   Tree key:     m/SLIP-0021/anysync/tree/{id}
///   KV key:       m/SLIP-0021/anysync/keyvalue/{id}
library;

import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;

import 'keys.dart';
import 'slip10.dart';
import 'slip21.dart';

/// BIP-44 coin type for Anytype.
const int _anytypeCoinType = 2046;

/// Predefined SLIP-21 derivation paths used by any-sync.
class SymmetricKeyPaths {
  static const String space = 'm/SLIP-0021/anysync/space';
  static String tree(String id) => 'm/SLIP-0021/anysync/tree/$id';
  static String keyValue(String id) => 'm/SLIP-0021/anysync/keyvalue/$id';
  static const String oneToOne = 'm/SLIP-0021/anysync/onetoone/0';
  static const String oneToOneRead = 'm/SLIP-0021/anysync/onetooneread';
  static const String oneToOneMeta = 'm/SLIP-0021/anysync/onetoonemeta';
}

/// Entropy size mapping for BIP-39 mnemonic word counts.
int _entropyForWordCount(int wordCount) {
  switch (wordCount) {
    case 12:
      return 128;
    case 15:
      return 160;
    case 18:
      return 192;
    case 21:
      return 224;
    case 24:
      return 256;
    default:
      throw ArgumentError(
        'Word count must be 12, 15, 18, 21, or 24. Got: $wordCount',
      );
  }
}

/// Generates a new BIP-39 mnemonic phrase.
String generateMnemonic({int wordCount = 12}) {
  final entropy = _entropyForWordCount(wordCount);
  return bip39.generateMnemonic(strength: entropy);
}

/// Validates a BIP-39 mnemonic phrase.
bool validateMnemonic(String mnemonic) {
  return bip39.validateMnemonic(mnemonic);
}

/// Derives the BIP-39 seed (64 bytes) from a mnemonic.
Uint8List mnemonicToSeed(String mnemonic) {
  return bip39.mnemonicToSeed(mnemonic);
}

/// An Anytype account derived from a BIP-39 mnemonic.
///
/// Contains the master and identity Ed25519 signing keys,
/// plus methods for deriving per-space and per-object symmetric keys.
class AccountKeys {
  /// The master Ed25519 signing key (derived at m/44'/2046'/index').
  final Ed25519SigningKey masterKey;

  /// The identity Ed25519 signing key (derived at m/44'/2046'/index'/0').
  final Ed25519SigningKey identityKey;

  /// The BIP-39 seed used for SLIP-21 symmetric key derivation.
  final Uint8List _seed;

  /// The account index (typically 0).
  final int index;

  AccountKeys._({
    required this.masterKey,
    required this.identityKey,
    required Uint8List seed,
    required this.index,
  }) : _seed = seed;

  /// Creates account keys from a BIP-39 mnemonic phrase.
  ///
  /// [index] selects which account to derive (default 0).
  static Future<AccountKeys> fromMnemonic(
    String mnemonic, {
    int index = 0,
  }) async {
    if (!bip39.validateMnemonic(mnemonic)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = bip39.mnemonicToSeed(mnemonic);
    return fromSeed(seed, index: index);
  }

  /// Creates account keys from a raw BIP-39 seed (64 bytes).
  static Future<AccountKeys> fromSeed(
    Uint8List seed, {
    int index = 0,
  }) async {
    final masterPath = "m/44'/${_anytypeCoinType}'/$index'";
    final identityPath = "m/44'/${_anytypeCoinType}'/$index'/0'";

    final masterNode = Slip10Node.deriveForPath(masterPath, seed);
    final identityNode = Slip10Node.deriveForPath(identityPath, seed);

    final masterKey = await Ed25519SigningKey.fromSeed(masterNode.key);
    final identityKey = await Ed25519SigningKey.fromSeed(identityNode.key);

    return AccountKeys._(
      masterKey: masterKey,
      identityKey: identityKey,
      seed: seed,
      index: index,
    );
  }

  /// Derives the space-level symmetric encryption key (32 bytes).
  Uint8List deriveSpaceKey() {
    return Slip21Node.deriveForPath(SymmetricKeyPaths.space, _seed)
        .symmetricKey;
  }

  /// Derives a per-object (tree) symmetric encryption key (32 bytes).
  Uint8List deriveTreeKey(String objectId) {
    return Slip21Node.deriveForPath(SymmetricKeyPaths.tree(objectId), _seed)
        .symmetricKey;
  }

  /// Derives a per-key-value-store symmetric encryption key (32 bytes).
  Uint8List deriveKeyValueKey(String id) {
    return Slip21Node.deriveForPath(SymmetricKeyPaths.keyValue(id), _seed)
        .symmetricKey;
  }

  /// The identity public key's Account-format string.
  String get accountId => identityKey.publicKey.account;
}
