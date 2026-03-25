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
/// Handles the full lifecycle of a change:
///   1. Build: assemble fields, optionally encrypt data
///   2. Sign: Ed25519 sign the serialized payload
///   3. Wrap: create RawTreeChange with signature
///   4. CID: compute content-addressable ID
///   5. Verify: validate CID and signature on receipt
library;

import 'dart:typed_data';

import '../crypto/aes_gcm.dart';
import '../crypto/cid.dart';
import '../crypto/keys.dart';
import 'change.dart';

/// Content for building a regular (non-root) change.
class ChangeContent {
  /// Current tree head IDs (become previousIds).
  final List<String> treeHeadIds;

  /// Current ACL head ID.
  final String aclHeadId;

  /// Snapshot this change is based on.
  final String snapshotBaseId;

  /// Encryption key ID (empty if unencrypted).
  final String readKeyId;

  /// Whether this is a snapshot change.
  final bool isSnapshot;

  /// The signing key.
  final Ed25519SigningKey signingKey;

  /// Optional encryption key.
  final AesKey? readKey;

  /// The raw change payload.
  final Uint8List content;

  /// Creation timestamp.
  final int timestamp;

  /// Semantic data type.
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
  /// The serialized and signed change bytes.
  final Uint8List rawData;

  /// The content-addressable ID (CID of rawData).
  final String id;

  const RawChange({required this.rawData, required this.id});
}

/// Builds and verifies changes.
///
/// Uses a simple binary format for change serialization:
///   [type_byte] [field_count_varint] [field_tag field_data]...
///
/// This is a simplified format for the prototype. In production,
/// this would use the protobuf TreeChange/RootChange messages.
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

    // Serialize the change fields into a payload
    final payload = _serializeTreeChange(
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

    // Create raw change: payload || signature
    final rawData = _wrapRawChange(payload, signature);

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
    final payload = _serializeRootChange(
      aclHeadId: content.aclHeadId,
      spaceId: content.spaceId,
      changeType: content.changeType,
      timestamp: content.timestamp,
      seed: content.seed,
      identity: content.signingKey.publicKey.raw,
      changePayload: content.changePayload,
    );

    final signature = await content.signingKey.sign(payload);
    final rawData = _wrapRawChange(payload, signature);
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

    // Extract payload and signature
    final (payload, signature) = _unwrapRawChange(raw.rawData);
    if (payload == null || signature == null) return false;

    // Extract identity from payload
    final identity = _extractIdentity(payload);
    if (identity == null) return false;

    // Verify signature
    final pubKey = Ed25519PublicKey(identity);
    return pubKey.verify(payload, signature);
  }

  /// Unmarshals a raw change into a Change object.
  ///
  /// If [verify] is true, checks CID and signature first.
  /// If [readKey] is provided, decrypts the change data.
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

    final (payload, signature) = _unwrapRawChange(raw.rawData);
    final fields = _deserializeChange(payload!);

    Uint8List? data = fields['changesData'] as Uint8List?;
    if (data != null && readKey != null) {
      data = await readKey.decrypt(data);
    }

    return Change(
      id: raw.id,
      previousIds:
          (fields['treeHeadIds'] as List<String>?) ?? const [],
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

// --- Simple binary serialization format ---
//
// Format: [num_fields:u16] ([key_len:u8] [key:utf8] [val_type:u8] [val_len:u32] [val:bytes])*
//
// Value types: 0=bytes, 1=string, 2=int64, 3=bool, 4=string_list

const int _typeBytes = 0;
const int _typeString = 1;
const int _typeInt64 = 2;
const int _typeBool = 3;
const int _typeStringList = 4;

Uint8List _serializeTreeChange({
  required List<String> treeHeadIds,
  required String aclHeadId,
  required String snapshotBaseId,
  required Uint8List changesData,
  required String readKeyId,
  required int timestamp,
  required Uint8List identity,
  required bool isSnapshot,
  required String dataType,
}) {
  final fields = <String, (int, dynamic)>{
    'treeHeadIds': (_typeStringList, treeHeadIds),
    'aclHeadId': (_typeString, aclHeadId),
    'snapshotBaseId': (_typeString, snapshotBaseId),
    'changesData': (_typeBytes, changesData),
    'readKeyId': (_typeString, readKeyId),
    'timestamp': (_typeInt64, timestamp),
    'identity': (_typeBytes, identity),
    'isSnapshot': (_typeBool, isSnapshot),
    'dataType': (_typeString, dataType),
  };
  return _serializeFields(fields);
}

Uint8List _serializeRootChange({
  required String aclHeadId,
  required String spaceId,
  required String changeType,
  required int timestamp,
  required Uint8List seed,
  required Uint8List identity,
  Uint8List? changePayload,
}) {
  final fields = <String, (int, dynamic)>{
    'aclHeadId': (_typeString, aclHeadId),
    'spaceId': (_typeString, spaceId),
    'changeType': (_typeString, changeType),
    'timestamp': (_typeInt64, timestamp),
    'seed': (_typeBytes, seed),
    'identity': (_typeBytes, identity),
    if (changePayload != null)
      'changePayload': (_typeBytes, changePayload),
  };
  return _serializeFields(fields);
}

Uint8List _serializeFields(Map<String, (int, dynamic)> fields) {
  final buf = BytesBuilder();

  // Number of fields
  buf.addByte((fields.length >> 8) & 0xFF);
  buf.addByte(fields.length & 0xFF);

  for (final entry in fields.entries) {
    final keyBytes = Uint8List.fromList(entry.key.codeUnits);
    buf.addByte(keyBytes.length);
    buf.add(keyBytes);

    final (type, value) = entry.value;
    buf.addByte(type);

    switch (type) {
      case _typeBytes:
        final bytes = value as Uint8List;
        _writeU32(buf, bytes.length);
        buf.add(bytes);
      case _typeString:
        final strBytes = Uint8List.fromList((value as String).codeUnits);
        _writeU32(buf, strBytes.length);
        buf.add(strBytes);
      case _typeInt64:
        final intVal = value as int;
        final data = Uint8List(8);
        data.buffer.asByteData().setInt64(0, intVal, Endian.big);
        _writeU32(buf, 8);
        buf.add(data);
      case _typeBool:
        _writeU32(buf, 1);
        buf.addByte((value as bool) ? 1 : 0);
      case _typeStringList:
        final list = value as List<String>;
        final listBuf = BytesBuilder();
        _writeU16(listBuf, list.length);
        for (final s in list) {
          final sBytes = Uint8List.fromList(s.codeUnits);
          _writeU32(listBuf, sBytes.length);
          listBuf.add(sBytes);
        }
        final listData = listBuf.toBytes();
        _writeU32(buf, listData.length);
        buf.add(listData);
    }
  }

  return buf.toBytes();
}

Map<String, dynamic> _deserializeChange(Uint8List data) {
  final result = <String, dynamic>{};
  var pos = 0;

  if (data.length < 2) return result;
  final numFields = (data[pos] << 8) | data[pos + 1];
  pos += 2;

  for (var i = 0; i < numFields && pos < data.length; i++) {
    final keyLen = data[pos++];
    final key = String.fromCharCodes(data.sublist(pos, pos + keyLen));
    pos += keyLen;

    final type = data[pos++];
    final valLen = _readU32(data, pos);
    pos += 4;

    switch (type) {
      case _typeBytes:
        result[key] = Uint8List.fromList(data.sublist(pos, pos + valLen));
      case _typeString:
        result[key] = String.fromCharCodes(data.sublist(pos, pos + valLen));
      case _typeInt64:
        // Read int64 manually to avoid buffer offset issues with sublist views
        var v = 0;
        for (var j = 0; j < 8; j++) {
          v = (v << 8) | data[pos + j];
        }
        result[key] = v;
      case _typeBool:
        result[key] = data[pos] != 0;
      case _typeStringList:
        final list = <String>[];
        var lPos = pos;
        final listLen = (data[lPos] << 8) | data[lPos + 1];
        lPos += 2;
        for (var j = 0; j < listLen; j++) {
          final sLen = _readU32(data, lPos);
          lPos += 4;
          list.add(String.fromCharCodes(data.sublist(lPos, lPos + sLen)));
          lPos += sLen;
        }
        result[key] = list;
    }
    pos += valLen;
  }

  return result;
}

Uint8List? _extractIdentity(Uint8List payload) {
  final fields = _deserializeChange(payload);
  return fields['identity'] as Uint8List?;
}

/// Wraps payload + signature into a raw change.
/// Format: [payload_len:u32] [payload] [sig_len:u32] [signature]
Uint8List _wrapRawChange(Uint8List payload, Uint8List signature) {
  final buf = BytesBuilder();
  _writeU32(buf, payload.length);
  buf.add(payload);
  _writeU32(buf, signature.length);
  buf.add(signature);
  return buf.toBytes();
}

/// Extracts payload and signature from raw change bytes.
(Uint8List?, Uint8List?) _unwrapRawChange(Uint8List raw) {
  if (raw.length < 8) return (null, null);
  var pos = 0;
  final payloadLen = _readU32(raw, pos);
  pos += 4;
  if (pos + payloadLen > raw.length) return (null, null);
  final payload = Uint8List.sublistView(raw, pos, pos + payloadLen);
  pos += payloadLen;
  if (pos + 4 > raw.length) return (null, null);
  final sigLen = _readU32(raw, pos);
  pos += 4;
  if (pos + sigLen > raw.length) return (null, null);
  final signature = Uint8List.sublistView(raw, pos, pos + sigLen);
  return (payload, signature);
}

void _writeU32(BytesBuilder buf, int value) {
  buf.addByte((value >> 24) & 0xFF);
  buf.addByte((value >> 16) & 0xFF);
  buf.addByte((value >> 8) & 0xFF);
  buf.addByte(value & 0xFF);
}

void _writeU16(BytesBuilder buf, int value) {
  buf.addByte((value >> 8) & 0xFF);
  buf.addByte(value & 0xFF);
}

int _readU32(Uint8List data, int offset) {
  return (data[offset] << 24) |
      (data[offset + 1] << 16) |
      (data[offset + 2] << 8) |
      data[offset + 3];
}
