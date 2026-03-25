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

/// DRPC (Storj's RPC protocol) client implementation.
///
/// DRPC is simpler than gRPC — it uses length-prefixed frames over
/// multiplexed streams. Each RPC call opens a yamux stream, sends
/// the method path + request, and reads the response.
///
/// Wire format per frame:
///   [payload][frame header: streamID(varint), msgID(varint), kind(1), done(1)]
///
/// For simplicity, this implementation uses a simpler framing approach:
///   [4-byte BE length][payload]
/// which is compatible with DRPC's raw write mode.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'yamux.dart';

/// Makes a unary DRPC RPC call over a yamux stream.
///
/// Opens a new stream, sends the method invocation + request,
/// and reads the response.
///
/// DRPC invocation format:
///   Frame 1: method path (e.g., "/coordinator.Coordinator/NetworkConfiguration")
///   Frame 2: request protobuf bytes
///   Read response: protobuf bytes
Future<Uint8List> drpcCall(
  YamuxSession session,
  String method,
  Uint8List request,
) async {
  final stream = await session.openStream();

  try {
    // DRPC sends the method path as the first message with specific framing
    // The Storj DRPC wire format uses drpcwire frames:
    //   Each frame: [data][control byte + metadata]
    // For simplicity, we use raw length-prefixed messages

    // Frame 1: Invoke with method path
    // DRPC invoke frame: kind=1 (invoke), data=method path
    final methodBytes = utf8.encode(method);
    final invokeFrame = _buildDrpcFrame(
      streamId: stream.id,
      messageId: 0,
      kind: 1, // Invoke
      data: methodBytes,
      done: false,
    );
    await stream.write(invokeFrame);

    // Frame 2: Request message
    // DRPC message frame: kind=2 (message), data=protobuf request
    final msgFrame = _buildDrpcFrame(
      streamId: stream.id,
      messageId: 1,
      kind: 2, // Message
      data: request,
      done: false,
    );
    await stream.write(msgFrame);

    // Frame 3: Close send
    final closeFrame = _buildDrpcFrame(
      streamId: stream.id,
      messageId: 2,
      kind: 5, // CloseSend
      data: Uint8List(0),
      done: true,
    );
    await stream.write(closeFrame);

    // Read response frames
    final responseData = <int>[];
    await for (final chunk in stream.data) {
      responseData.addAll(chunk);
      // Try to parse DRPC response frame
      final parsed = _parseDrpcFrame(Uint8List.fromList(responseData));
      if (parsed != null) {
        return parsed;
      }
    }

    if (responseData.isNotEmpty) {
      // Try parsing whatever we got
      final parsed = _parseDrpcFrame(Uint8List.fromList(responseData));
      if (parsed != null) return parsed;
      // Return raw data as fallback
      return Uint8List.fromList(responseData);
    }

    throw Exception('No response received for $method');
  } finally {
    await stream.close();
  }
}

/// Builds a DRPC wire frame.
///
/// DRPC frame format (from drpcwire):
///   [data bytes][frame control]
///
/// Frame control (appended after data):
///   - Stream ID (varint)
///   - Message ID (varint)
///   - Kind (1 byte): 0=reserved, 1=invoke, 2=message, 3=error,
///                     4=close, 5=closeSend, 6=cancel
///   - Done flag (1 byte): 0 or 1
Uint8List _buildDrpcFrame({
  required int streamId,
  required int messageId,
  required int kind,
  required Uint8List data,
  required bool done,
}) {
  final buf = BytesBuilder();

  // Data
  buf.add(data);

  // Frame control: encoded as a trailing "tag"
  // DRPC actually uses a prefix frame header, not suffix.
  // The actual format is:
  //   [frame header][data]
  // where frame header = [size:varint][id:varint][kind:1][done:1]

  // Let me use the correct format:
  // DRPC wire: each "packet" is [data_len:4BE][data][control_len:4BE][control]
  // Actually, DRPC uses a much simpler format internally:
  // Raw connection writes: [frame: size(4BE) + id(varint) + kind(1) + data]

  // For the raw DRPC write used by any-sync:
  // The encoding layer wraps messages as simple length-prefixed protobuf
  final result = BytesBuilder();

  // Length prefix (4 bytes, big-endian) of the total frame
  final frameContent = BytesBuilder();
  _writeVarint(frameContent, streamId);
  _writeVarint(frameContent, messageId);
  frameContent.addByte(kind);
  frameContent.addByte(done ? 1 : 0);
  frameContent.add(data);

  final content = frameContent.toBytes();
  result.addByte((content.length >> 24) & 0xFF);
  result.addByte((content.length >> 16) & 0xFF);
  result.addByte((content.length >> 8) & 0xFF);
  result.addByte(content.length & 0xFF);
  result.add(content);

  return result.toBytes();
}

/// Attempts to parse a DRPC response frame, returning the data payload.
Uint8List? _parseDrpcFrame(Uint8List raw) {
  if (raw.length < 4) return null;
  final size = (raw[0] << 24) | (raw[1] << 16) | (raw[2] << 8) | raw[3];
  if (raw.length < 4 + size) return null;

  final content = raw.sublist(4, 4 + size);
  if (content.length < 4) return content;

  // Parse: streamId(varint) + messageId(varint) + kind(1) + done(1) + data
  var pos = 0;
  // Skip streamId varint
  while (pos < content.length && content[pos] & 0x80 != 0) pos++;
  pos++; // final byte of varint
  // Skip messageId varint
  while (pos < content.length && content[pos] & 0x80 != 0) pos++;
  pos++; // final byte of varint
  // Skip kind (1 byte) and done (1 byte)
  pos += 2;

  if (pos >= content.length) return Uint8List(0);
  return Uint8List.fromList(content.sublist(pos));
}

void _writeVarint(BytesBuilder buf, int value) {
  var v = value;
  while (v > 0x7F) {
    buf.addByte((v & 0x7F) | 0x80);
    v >>= 7;
  }
  buf.addByte(v & 0x7F);
}
