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

/// Builds, signs, and verifies changes for the CRDT tree.
///
/// Uses protobuf wire format for TreeChange and RawTreeChange messages,
/// producing byte-for-byte compatible output with the Go implementation.
library;

import 'dart:typed_data';

import '../crypto/aes_gcm.dart';
import '../crypto/cid.dart';
import '../crypto/keys.dart';
import 'change.dart';
import 'proto_encoding.dart';

/// Content for building a regular (non-root) change.
class ChangeContent {
  final List<String> treeHeadIds;
  final String aclHeadId;
  final String snapshotBaseId;
  final String readKeyId;
  final bool isSnapshot;
  final Ed25519SigningKey signingKey;
  final AesKey? readKey;
  final Uint8List content;
  final int timestamp;
  final String dataType;

  const ChangeContent({
    required this.treeHeadIds,
    required this.aclHeadId,
    required this.snapshotBaseId,
    this.readKeyId = '',
    this.isSnapshot = false,
    required this.signingKey,
    this.readKey,
    required this.content,
    required this.timestamp,
    this.dataType = '',
  });
}

/// Content for building a root (initial) change.
class RootChangeContent {
  final String aclHeadId;
  final Ed25519SigningKey signingKey;
  final String spaceId;
  final Uint8List seed;
  final String changeType;
  final Uint8List? changePayload;
  final int timestamp;

  const RootChangeContent({
    required this.aclHeadId,
    required this.signingKey,
    required this.spaceId,
    required this.seed,
    required this.changeType,
    this.changePayload,
    required this.timestamp,
  });
}

/// A signed, serialized change ready for storage and transmission.
class RawChange {
  /// The serialized RawTreeChange (protobuf: payload + signature).
  final Uint8List rawData;

  /// The content-addressable ID (CID of rawData).
  final String id;

  const RawChange({required this.rawData, required this.id});
}

/// Builds and verifies changes using protobuf-compatible wire format.
class ChangeBuilder {
  /// Builds a regular change, signs it, and computes its CID.
  static Future<(RawChange, Change)> build(ChangeContent content) async {
    // Optionally encrypt the payload
    Uint8List changesData;
    if (content.readKey != null) {
      changesData = await content.readKey!.encrypt(content.content);
    } else {
      changesData = content.content;
    }

    // Encode as protobuf TreeChange
    final payload = encodeTreeChange(
      treeHeadIds: content.treeHeadIds,
      aclHeadId: content.aclHeadId,
      snapshotBaseId: content.snapshotBaseId,
      changesData: changesData,
      readKeyId: content.readKeyId,
      timestamp: content.timestamp,
      identity: content.signingKey.publicKey.raw,
      isSnapshot: content.isSnapshot,
      dataType: content.dataType,
    );

    // Sign the payload
    final signature = await content.signingKey.sign(payload);

    // Wrap as protobuf RawTreeChange
    final rawData = encodeRawTreeChange(payload, signature);

    // Compute CID
    final id = cidString(rawData);

    final change = Change(
      id: id,
      previousIds: List.from(content.treeHeadIds),
      snapshotId: content.snapshotBaseId,
      isSnapshot: content.isSnapshot,
      data: content.content,
      dataType: content.dataType,
      timestamp: content.timestamp,
      signature: signature,
      identity: content.signingKey.publicKey.raw,
      aclHeadId: content.aclHeadId,
      readKeyId: content.readKeyId,
    );

    return (RawChange(rawData: rawData, id: id), change);
  }

  /// Builds a root change, signs it, and computes its CID.
  static Future<(RawChange, Change)> buildRoot(
    RootChangeContent content,
  ) async {
    final payload = encodeRootChange(
      aclHeadId: content.aclHeadId,
      spaceId: content.spaceId,
      changeType: content.changeType,
      timestamp: content.timestamp,
      seed: content.seed,
      identity: content.signingKey.publicKey.raw,
      changePayload: content.changePayload,
    );

    final signature = await content.signingKey.sign(payload);
    final rawData = encodeRawTreeChange(payload, signature);
    final id = cidString(rawData);

    final change = Change(
      id: id,
      previousIds: const [],
      isSnapshot: true,
      snapshotCounter: 0,
      data: content.changePayload,
      dataType: content.changeType,
      timestamp: content.timestamp,
      signature: signature,
      identity: content.signingKey.publicKey.raw,
      aclHeadId: content.aclHeadId,
    );

    return (RawChange(rawData: rawData, id: id), change);
  }

  /// Verifies a raw change: checks CID and signature.
  static Future<bool> verify(RawChange raw) async {
    // Verify CID
    if (!verifyCid(raw.rawData, raw.id)) return false;

    // Decode protobuf RawTreeChange
    final (payload, signature) = decodeRawTreeChange(raw.rawData);
    if (payload == null || signature == null) return false;

    // Extract identity from the payload (TreeChange or RootChange)
    final fields = decodeProtoFields(payload);
    Uint8List? identity;
    for (final f in fields) {
      // identity is field 7 in TreeChange, field 6 in RootChange
      if ((f.fieldNumber == 7 || f.fieldNumber == 6) && f.value is Uint8List) {
        final bytes = f.value as Uint8List;
        if (bytes.length == 32) {
          identity = bytes;
          break;
        }
      }
    }
    if (identity == null) return false;

    final pubKey = Ed25519PublicKey(identity);
    return pubKey.verify(payload, signature);
  }

  /// Unmarshals a raw change into a Change object.
  static Future<Change> unmarshal(
    RawChange raw, {
    bool verify = true,
    AesKey? readKey,
  }) async {
    if (verify) {
      final valid = await ChangeBuilder.verify(raw);
      if (!valid) {
        throw FormatException('Invalid change: CID or signature mismatch');
      }
    }

    final (payload, signature) = decodeRawTreeChange(raw.rawData);
    if (payload == null) {
      throw FormatException('Invalid RawTreeChange: missing payload');
    }

    // Try decoding as TreeChange first (has treeHeadIds)
    final fields = decodeTreeChange(payload);

    Uint8List? data = fields['changesData'] as Uint8List?;
    if (data != null && readKey != null) {
      data = await readKey.decrypt(data);
    }

    return Change(
      id: raw.id,
      previousIds: (fields['treeHeadIds'] as List<String>?) ?? const [],
      snapshotId: (fields['snapshotBaseId'] as String?) ?? '',
      isSnapshot: (fields['isSnapshot'] as bool?) ?? false,
      data: data ?? (fields['changePayload'] as Uint8List?),
      dataType: (fields['dataType'] as String?) ??
          (fields['changeType'] as String?) ??
          '',
      timestamp: (fields['timestamp'] as int?) ?? 0,
      signature: signature,
      identity: fields['identity'] as Uint8List?,
      aclHeadId: (fields['aclHeadId'] as String?) ?? '',
      readKeyId: (fields['readKeyId'] as String?) ?? '',
      isDerived: (fields['isDerived'] as bool?) ?? false,
      parentId: (fields['parentId'] as String?) ?? '',
    );
  }
}
