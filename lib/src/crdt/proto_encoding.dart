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

/// Protobuf wire-format encoding for TreeChange and RawTreeChange.
///
/// Hand-coded to avoid protobuf runtime version mismatches while
/// producing byte-for-byte compatible output with the Go implementation.
///
/// Proto field numbers from treechange.proto:
///
///   TreeChange { repeated string treeHeadIds=1; string aclHeadId=2;
///     string snapshotBaseId=3; bytes changesData=4; string readKeyId=5;
///     int64 timestamp=6; bytes identity=7; bool isSnapshot=8;
///     string dataType=9; }
///
///   RootChange { string aclHeadId=1; string spaceId=2;
///     string changeType=3; int64 timestamp=4; bytes seed=5;
///     bytes identity=6; bytes changePayload=7; bool isDerived=8;
///     string parentId=9; }
///
///   RawTreeChange { bytes payload=1; bytes signature=2; }
///
///   RawTreeChangeWithId { bytes rawChange=1; string id=2; }
library;

import 'dart:convert';
import 'dart:typed_data';

// --- Protobuf wire types ---
const int _wtVarint = 0;
const int _wtLengthDelimited = 2;

// --- Low-level protobuf encoding ---

/// Encodes a varint.
void _writeVarint(BytesBuilder buf, int value) {
  var v = value;
  while (v > 0x7F) {
    buf.addByte((v & 0x7F) | 0x80);
    v >>= 7;
  }
  buf.addByte(v & 0x7F);
}

/// Encodes a field tag.
void _writeTag(BytesBuilder buf, int fieldNumber, int wireType) {
  _writeVarint(buf, (fieldNumber << 3) | wireType);
}

/// Encodes a length-delimited field (bytes or string).
void _writeBytes(BytesBuilder buf, int fieldNumber, List<int> data) {
  if (data.isEmpty) return; // proto3 default: skip empty
  _writeTag(buf, fieldNumber, _wtLengthDelimited);
  _writeVarint(buf, data.length);
  buf.add(data);
}

/// Encodes a string field.
void _writeString(BytesBuilder buf, int fieldNumber, String value) {
  if (value.isEmpty) return; // proto3 default
  _writeBytes(buf, fieldNumber, utf8.encode(value));
}

/// Encodes a varint field.
void _writeVarintField(BytesBuilder buf, int fieldNumber, int value) {
  if (value == 0) return; // proto3 default
  _writeTag(buf, fieldNumber, _wtVarint);
  _writeVarint(buf, value);
}

/// Encodes a bool field.
void _writeBool(BytesBuilder buf, int fieldNumber, bool value) {
  if (!value) return; // proto3 default
  _writeTag(buf, fieldNumber, _wtVarint);
  buf.addByte(1);
}

/// Encodes a signed int64 as varint (proto3 int64 uses standard varint).
void _writeInt64(BytesBuilder buf, int fieldNumber, int value) {
  if (value == 0) return;
  _writeTag(buf, fieldNumber, _wtVarint);
  // Proto3 int64 uses two's complement varint for negative values
  if (value >= 0) {
    _writeVarint(buf, value);
  } else {
    // Negative: encode as 10-byte varint (two's complement)
    var v = value;
    for (var i = 0; i < 9; i++) {
      buf.addByte((v & 0x7F) | 0x80);
      v >>= 7;
    }
    buf.addByte(v & 0x01);
  }
}

/// Encodes a repeated string field (each element is a separate field).
void _writeRepeatedString(BytesBuilder buf, int fieldNumber, List<String> values) {
  for (final v in values) {
    final encoded = utf8.encode(v);
    _writeTag(buf, fieldNumber, _wtLengthDelimited);
    _writeVarint(buf, encoded.length);
    buf.add(encoded);
  }
}

// --- TreeChange encoding (field numbers from treechange.proto) ---

/// Encodes a TreeChange message in protobuf wire format.
Uint8List encodeTreeChange({
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
  final buf = BytesBuilder();
  _writeRepeatedString(buf, 1, treeHeadIds);  // field 1
  _writeString(buf, 2, aclHeadId);            // field 2
  _writeString(buf, 3, snapshotBaseId);        // field 3
  _writeBytes(buf, 4, changesData);            // field 4
  _writeString(buf, 5, readKeyId);             // field 5
  _writeInt64(buf, 6, timestamp);              // field 6
  _writeBytes(buf, 7, identity);               // field 7
  _writeBool(buf, 8, isSnapshot);              // field 8
  _writeString(buf, 9, dataType);              // field 9
  return buf.toBytes();
}

/// Encodes a RootChange message in protobuf wire format.
Uint8List encodeRootChange({
  required String aclHeadId,
  required String spaceId,
  required String changeType,
  required int timestamp,
  required Uint8List seed,
  required Uint8List identity,
  Uint8List? changePayload,
  bool isDerived = false,
  String parentId = '',
}) {
  final buf = BytesBuilder();
  _writeString(buf, 1, aclHeadId);             // field 1
  _writeString(buf, 2, spaceId);               // field 2
  _writeString(buf, 3, changeType);            // field 3
  _writeInt64(buf, 4, timestamp);              // field 4
  _writeBytes(buf, 5, seed);                   // field 5
  _writeBytes(buf, 6, identity);               // field 6
  if (changePayload != null && changePayload.isNotEmpty) {
    _writeBytes(buf, 7, changePayload);        // field 7
  }
  _writeBool(buf, 8, isDerived);               // field 8
  _writeString(buf, 9, parentId);              // field 9
  return buf.toBytes();
}

/// Encodes a RawTreeChange message (payload + signature).
Uint8List encodeRawTreeChange(Uint8List payload, Uint8List signature) {
  final buf = BytesBuilder();
  _writeBytes(buf, 1, payload);    // field 1: payload
  _writeBytes(buf, 2, signature);  // field 2: signature
  return buf.toBytes();
}

/// Encodes a RawTreeChangeWithId message.
Uint8List encodeRawTreeChangeWithId(Uint8List rawChange, String id) {
  final buf = BytesBuilder();
  _writeBytes(buf, 1, rawChange);              // field 1: rawChange
  _writeString(buf, 2, id);                    // field 2: id
  return buf.toBytes();
}

// --- Protobuf decoding ---

/// Decoded protobuf field.
class ProtoField {
  final int fieldNumber;
  final int wireType;
  final dynamic value; // int for varint, Uint8List for length-delimited

  const ProtoField(this.fieldNumber, this.wireType, this.value);
}

/// Decodes all fields from a protobuf message.
List<ProtoField> decodeProtoFields(Uint8List data) {
  final fields = <ProtoField>[];
  var pos = 0;

  while (pos < data.length) {
    final (tag, p1) = _readVarint(data, pos);
    pos = p1;
    final fieldNumber = tag >> 3;
    final wireType = tag & 0x07;

    switch (wireType) {
      case _wtVarint:
        final (value, p2) = _readVarint(data, pos);
        pos = p2;
        fields.add(ProtoField(fieldNumber, wireType, value));
      case _wtLengthDelimited:
        final (length, p2) = _readVarint(data, pos);
        pos = p2;
        fields.add(ProtoField(
          fieldNumber,
          wireType,
          Uint8List.sublistView(data, pos, pos + length),
        ));
        pos += length;
      case 0x01: // 64-bit (fixed64)
        fields.add(ProtoField(fieldNumber, wireType,
            Uint8List.sublistView(data, pos, pos + 8)));
        pos += 8;
      case 0x05: // 32-bit (fixed32)
        fields.add(ProtoField(fieldNumber, wireType,
            Uint8List.sublistView(data, pos, pos + 4)));
        pos += 4;
      default:
        throw FormatException('Unknown wire type: $wireType at pos $pos');
    }
  }
  return fields;
}

/// Decodes a RawTreeChange: extracts payload and signature.
(Uint8List? payload, Uint8List? signature) decodeRawTreeChange(Uint8List data) {
  final fields = decodeProtoFields(data);
  Uint8List? payload;
  Uint8List? signature;
  for (final f in fields) {
    if (f.fieldNumber == 1 && f.wireType == _wtLengthDelimited) {
      payload = f.value as Uint8List;
    } else if (f.fieldNumber == 2 && f.wireType == _wtLengthDelimited) {
      signature = f.value as Uint8List;
    }
  }
  return (payload, signature);
}

/// Decodes a TreeChange payload into a field map.
Map<String, dynamic> decodeTreeChange(Uint8List data) {
  final fields = decodeProtoFields(data);
  final result = <String, dynamic>{};
  final treeHeadIds = <String>[];

  for (final f in fields) {
    switch (f.fieldNumber) {
      case 1: // repeated string treeHeadIds
        treeHeadIds.add(utf8.decode(f.value as Uint8List));
      case 2: // string aclHeadId
        result['aclHeadId'] = utf8.decode(f.value as Uint8List);
      case 3: // string snapshotBaseId
        result['snapshotBaseId'] = utf8.decode(f.value as Uint8List);
      case 4: // bytes changesData
        result['changesData'] = f.value as Uint8List;
      case 5: // string readKeyId
        result['readKeyId'] = utf8.decode(f.value as Uint8List);
      case 6: // int64 timestamp
        result['timestamp'] = f.value as int;
      case 7: // bytes identity
        result['identity'] = f.value as Uint8List;
      case 8: // bool isSnapshot
        result['isSnapshot'] = (f.value as int) != 0;
      case 9: // string dataType
        result['dataType'] = utf8.decode(f.value as Uint8List);
    }
  }
  if (treeHeadIds.isNotEmpty) result['treeHeadIds'] = treeHeadIds;
  return result;
}

/// Decodes a RootChange payload into a field map.
Map<String, dynamic> decodeRootChange(Uint8List data) {
  final fields = decodeProtoFields(data);
  final result = <String, dynamic>{};

  for (final f in fields) {
    switch (f.fieldNumber) {
      case 1: result['aclHeadId'] = utf8.decode(f.value as Uint8List);
      case 2: result['spaceId'] = utf8.decode(f.value as Uint8List);
      case 3: result['changeType'] = utf8.decode(f.value as Uint8List);
      case 4: result['timestamp'] = f.value as int;
      case 5: result['seed'] = f.value as Uint8List;
      case 6: result['identity'] = f.value as Uint8List;
      case 7: result['changePayload'] = f.value as Uint8List;
      case 8: result['isDerived'] = (f.value as int) != 0;
      case 9: result['parentId'] = utf8.decode(f.value as Uint8List);
    }
  }
  return result;
}

(int value, int newPos) _readVarint(Uint8List buf, int pos) {
  var result = 0;
  var shift = 0;
  while (pos < buf.length) {
    final byte = buf[pos++];
    result |= (byte & 0x7F) << shift;
    if (byte & 0x80 == 0) return (result, pos);
    shift += 7;
  }
  throw FormatException('Incomplete varint');
}
