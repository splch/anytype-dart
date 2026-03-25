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

/// any-sync credential handshake over TLS.
///
/// Wire format: [type:1][size:4 LE][protobuf payload]
/// Message types: 1=Credentials, 2=Ack, 3=Proto
///
/// The credential exchange runs over TLS on a RawSecureSocket.
/// After completion, the caller switches to raw TCP for yamux.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../crypto/keys.dart';

/// Protocol version. Must match the server's compatible set.
const int protoVersion = 8;

/// Client version string sent during handshake.
const String clientVersion = 'anytype-dart/0.1.0';

/// Performs the any-sync credential handshake over a [RawSecureSocket].
///
/// Returns the server's protocol version and client version string.
/// After this completes, the caller should stop using the secure socket
/// and switch to writing raw yamux frames on the underlying [RawSocket].
Future<({int version, String client})> performCredentialHandshake({
  required RawSecureSocket secSocket,
  required Ed25519SigningKey signingKey,
  required String localPeerId,
  required String remotePeerId,
}) async {
  final buf = <int>[];
  final sub = secSocket.listen((event) {
    if (event == RawSocketEvent.read) {
      final data = secSocket.read();
      if (data != null) buf.addAll(data);
    }
  });

  try {
    // Build and send SignedPeerIds credentials
    final cred = await _buildCredentials(signingKey, localPeerId, remotePeerId);
    _tlsWrite(secSocket, 1, cred);

    // Read server Credentials
    await _waitFor(buf, 5);
    final credType = buf[0];
    if (credType == 2) {
      throw HandshakeException('Server rejected credentials');
    }
    if (credType != 1) {
      throw HandshakeException('Expected Credentials (1), got $credType');
    }
    final credSize = _readLeU32(buf, 1);
    await _waitFor(buf, 5 + credSize);
    final credPayload = Uint8List.fromList(buf.sublist(5, 5 + credSize));
    buf.removeRange(0, 5 + credSize);

    // Parse server version
    final serverInfo = _parseCredentials(credPayload);

    // Send Ack (success)
    _tlsWrite(secSocket, 2, Uint8List(0));

    // Read server Ack
    await _waitFor(buf, 5);
    final ackType = buf[0];
    final ackSize = _readLeU32(buf, 1);
    await _waitFor(buf, 5 + ackSize);
    buf.removeRange(0, 5 + ackSize);
    if (ackType != 2) {
      throw HandshakeException('Expected Ack (2), got $ackType');
    }

    return serverInfo;
  } finally {
    await sub.cancel();
  }
}

/// Sends the proto handshake as a yamux data frame on stream 1.
///
/// Must be called AFTER the credential handshake, on the raw socket.
/// Returns the raw bytes to write (yamux SYN + proto data frames).
Uint8List buildYamuxProtoFrames() {
  final out = BytesBuilder();

  // Yamux frame 1: Window update with SYN flag for stream 1
  final syn = Uint8List(12);
  ByteData.sublistView(syn)
    ..setUint8(0, 0) // yamux version
    ..setUint8(1, 1) // type = windowUpdate
    ..setUint16(2, 1, Endian.big) // flags = SYN
    ..setUint32(4, 1, Endian.big) // streamID = 1
    ..setUint32(8, 262144, Endian.big); // window = 256KB
  out.add(syn);

  // Yamux frame 2: Data frame with empty Proto handshake on stream 1
  // Proto message: type=3, size=0, no payload (triggers server Ack path)
  final protoMsg = Uint8List.fromList([0x03, 0x00, 0x00, 0x00, 0x00]);
  final data = Uint8List(12 + protoMsg.length);
  ByteData.sublistView(data)
    ..setUint8(0, 0) // yamux version
    ..setUint8(1, 0) // type = data
    ..setUint16(2, 0, Endian.big) // flags = 0
    ..setUint32(4, 1, Endian.big) // streamID = 1
    ..setUint32(8, protoMsg.length, Endian.big);
  data.setRange(12, 12 + protoMsg.length, protoMsg);
  out.add(data);

  return out.toBytes();
}

/// Parses yamux frames from raw bytes.
/// Returns a list of (type, flags, streamId, payload) tuples.
List<({int type, int flags, int streamId, Uint8List? payload})>
    parseYamuxFrames(List<int> buf) {
  final frames = <({int type, int flags, int streamId, Uint8List? payload})>[];
  var pos = 0;
  while (pos + 12 <= buf.length) {
    final type = buf[pos + 1];
    final flags = (buf[pos + 2] << 8) | buf[pos + 3];
    final streamId = (buf[pos + 4] << 24) |
        (buf[pos + 5] << 16) |
        (buf[pos + 6] << 8) |
        buf[pos + 7];
    final length = (buf[pos + 8] << 24) |
        (buf[pos + 9] << 16) |
        (buf[pos + 10] << 8) |
        buf[pos + 11];
    pos += 12;

    Uint8List? payload;
    if (type == 0 && length > 0 && pos + length <= buf.length) {
      payload = Uint8List.fromList(buf.sublist(pos, pos + length));
      pos += length;
    }
    frames.add((type: type, flags: flags, streamId: streamId, payload: payload));
  }
  return frames;
}

// --- Internal helpers ---

Future<Uint8List> _buildCredentials(
  Ed25519SigningKey key, String localPeerId, String remotePeerId,
) async {
  final buf = BytesBuilder();

  // field 1: type = SignedPeerIds (1)
  buf.addByte(0x08);
  buf.addByte(0x01);

  // field 2: PayloadSignedPeerIds { identity, sign }
  final payloadBuf = BytesBuilder();
  final identityProto = key.publicKey.marshalProto();
  payloadBuf.addByte(0x0A);
  _writeVarint(payloadBuf, identityProto.length);
  payloadBuf.add(identityProto);
  final sig = await key.sign(
    Uint8List.fromList(utf8.encode(localPeerId + remotePeerId)),
  );
  payloadBuf.addByte(0x12);
  _writeVarint(payloadBuf, sig.length);
  payloadBuf.add(sig);
  final payload = payloadBuf.toBytes();
  buf.addByte(0x12);
  _writeVarint(buf, payload.length);
  buf.add(payload);

  // field 3: version
  buf.addByte(0x18);
  _writeVarint(buf, protoVersion);

  // field 4: clientVersion
  final cv = utf8.encode(clientVersion);
  buf.addByte(0x22);
  _writeVarint(buf, cv.length);
  buf.add(cv);

  return buf.toBytes();
}

({int version, String client}) _parseCredentials(Uint8List p) {
  var version = 0;
  var client = '';
  var pos = 0;
  while (pos < p.length) {
    final tag = p[pos++];
    final field = tag >> 3;
    final wt = tag & 0x07;
    if (wt == 0) {
      final (v, np) = _readVarint(p, pos);
      pos = np;
      if (field == 3) version = v;
    } else if (wt == 2) {
      final (len, np) = _readVarint(p, pos);
      pos = np;
      if (field == 4) client = utf8.decode(p.sublist(pos, pos + len));
      pos += len;
    }
  }
  return (version: version, client: client);
}

void _tlsWrite(RawSecureSocket s, int type, Uint8List payload) {
  final header = Uint8List(5);
  header[0] = type;
  header.buffer.asByteData().setUint32(1, payload.length, Endian.little);
  s.write(header);
  if (payload.isNotEmpty) s.write(payload);
}

Future<void> _waitFor(List<int> buf, int n) async {
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (buf.length < n) {
    if (DateTime.now().isAfter(deadline)) {
      throw HandshakeException(
        'Timeout waiting for $n bytes (have ${buf.length})',
      );
    }
    await Future.delayed(const Duration(milliseconds: 5));
  }
}

int _readLeU32(List<int> buf, int offset) =>
    buf[offset] |
    (buf[offset + 1] << 8) |
    (buf[offset + 2] << 16) |
    (buf[offset + 3] << 24);

void _writeVarint(BytesBuilder buf, int value) {
  var v = value;
  while (v > 0x7F) {
    buf.addByte((v & 0x7F) | 0x80);
    v >>= 7;
  }
  buf.addByte(v & 0x7F);
}

(int, int) _readVarint(Uint8List buf, int pos) {
  var result = 0;
  var shift = 0;
  while (pos < buf.length) {
    final byte = buf[pos++];
    result |= (byte & 0x7F) << shift;
    if (byte & 0x80 == 0) return (result, pos);
    shift += 7;
  }
  return (result, pos);
}

class HandshakeException implements Exception {
  final String message;
  HandshakeException(this.message);
  @override
  String toString() => 'HandshakeException: $message';
}
