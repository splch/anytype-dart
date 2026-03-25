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

/// any-sync handshake protocol (Credentials + Proto negotiation).
///
/// Wire format: [type:1][size:4 LE][protobuf payload]
/// Runs directly over TLS, BEFORE yamux session creation.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../crypto/keys.dart';

const int _msgTypeCred = 1;
const int _msgTypeAck = 2;
const int _msgTypeProto = 3;
const int _maxMsgSize = 200 * 1024;
const int _protoVersion = 9;
const String _clientVersion = 'anytype-dart/0.1.0';

/// Ack error codes from the handshake protocol.
enum HandshakeError {
  success(0),
  unexpected(1),
  invalidCredentials(2),
  unexpectedPayload(3),
  skipVerifyNotAllowed(4),
  deadlineExceeded(5),
  incompatibleVersion(6),
  incompatibleProto(7);

  final int code;
  const HandshakeError(this.code);
  static HandshakeError fromCode(int code) {
    for (final e in values) {
      if (e.code == code) return e;
    }
    return unexpected;
  }
}

/// Result of a completed handshake.
class HandshakeResult {
  final int remoteVersion;
  final String remoteClientVersion;
  final bool snappyEncoding;
  /// Remaining buffered bytes after handshake (for yamux).
  final List<int> remainingBytes;

  const HandshakeResult({
    this.remoteVersion = 0,
    this.remoteClientVersion = '',
    this.snappyEncoding = false,
    this.remainingBytes = const [],
  });
}

/// Performs the any-sync handshake over a raw socket (not SecureSocket).
///
/// Uses a pre-buffered approach: collects data from the socket into a
/// buffer, then parses handshake messages from the buffer sequentially.
class Handshaker {
  final Socket _socket;
  final List<int> _buf = [];
  final Completer<void> _ready = Completer();
  StreamSubscription<Uint8List>? _sub;
  bool _closed = false;

  Handshaker(this._socket);

  /// Runs the full handshake: Credentials → Ack → Proto.
  ///
  /// After completion, remaining buffered bytes are available in
  /// [HandshakeResult.remainingBytes] for the yamux layer.
  Future<HandshakeResult> perform() async {
    // Set up buffered listener FIRST, before sending anything
    final dataCompleter = Completer<void>();
    _sub = _socket.listen(
      (data) {
        _buf.addAll(data);
        if (!dataCompleter.isCompleted) dataCompleter.complete();
      },
      onError: (e) {
        _closed = true;
        if (!dataCompleter.isCompleted) dataCompleter.completeError(e);
      },
      onDone: () {
        _closed = true;
        if (!dataCompleter.isCompleted) dataCompleter.complete();
      },
    );

    // Send Credentials
    await _sendMsg(_msgTypeCred, await _buildCredentials());

    // Read Credentials or Ack
    final (respType, respPayload) = await _readMsg();
    if (respType == _msgTypeAck) {
      final err = _decodeAckError(respPayload);
      throw HandshakeException('Server rejected: ${err.name}');
    }
    if (respType != _msgTypeCred) {
      throw HandshakeException('Expected Credentials, got type $respType');
    }
    final remoteCred = _decodeCredentials(respPayload);

    // Send Ack success
    await _sendMsg(_msgTypeAck, Uint8List(0));

    // Read Ack
    final (ackType, ackPayload) = await _readMsg();
    if (ackType != _msgTypeAck) {
      throw HandshakeException('Expected Ack, got type $ackType');
    }
    final ackErr = _decodeAckError(ackPayload);
    if (ackErr != HandshakeError.success) {
      throw HandshakeException('Server Ack error: ${ackErr.name}');
    }

    // Send Proto (DRPC, no snappy)
    await _sendMsg(_msgTypeProto, _buildProto());

    // Read Proto or Ack
    final (protoType, protoPayload) = await _readMsg();
    bool snappy = false;
    if (protoType == _msgTypeProto) {
      snappy = _protoHasSnappy(protoPayload);
    } else if (protoType == _msgTypeAck) {
      final pe = _decodeAckError(protoPayload);
      if (pe != HandshakeError.success) {
        throw HandshakeException('Proto rejected: ${pe.name}');
      }
    }

    // Detach listener and capture remaining buffer
    await _sub?.cancel();
    _sub = null;

    return HandshakeResult(
      remoteVersion: (remoteCred['version'] as int?) ?? 0,
      remoteClientVersion: (remoteCred['clientVersion'] as String?) ?? '',
      snappyEncoding: snappy,
      remainingBytes: List.from(_buf),
    );
  }

  Future<void> _sendMsg(int type, Uint8List payload) async {
    final header = Uint8List(5);
    header[0] = type;
    header.buffer.asByteData().setUint32(1, payload.length, Endian.little);
    _socket.add(header);
    if (payload.isNotEmpty) _socket.add(payload);
    await _socket.flush();
  }

  Future<(int, Uint8List)> _readMsg() async {
    await _waitFor(5);
    final type = _buf[0];
    final size = _buf[1] | (_buf[2] << 8) | (_buf[3] << 16) | (_buf[4] << 24);
    if (size > _maxMsgSize) throw HandshakeException('Msg too large: $size');
    await _waitFor(5 + size);
    final payload = Uint8List.fromList(_buf.sublist(5, 5 + size));
    _buf.removeRange(0, 5 + size);
    return (type, payload);
  }

  Future<void> _waitFor(int n) async {
    final deadline = DateTime.now().add(const Duration(seconds: 10));
    while (_buf.length < n) {
      if (_closed) {
        // Server may have sent data AND closed — check buffer one more time
        if (_buf.length >= n) break;
        throw SocketException(
          'Connection closed during handshake (have ${_buf.length} of $n bytes)',
        );
      }
      if (DateTime.now().isAfter(deadline)) {
        throw HandshakeException('Timeout waiting for $n bytes (have ${_buf.length})');
      }
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  Ed25519SigningKey? _signingKey;
  String _localPeerId = '';
  String _remotePeerId = '';

  /// Sets the identity for SignedPeerIds authentication.
  void setIdentity(Ed25519SigningKey key, String localPeerId, String remotePeerId) {
    _signingKey = key;
    _localPeerId = localPeerId;
    _remotePeerId = remotePeerId;
  }

  Future<Uint8List> _buildCredentials() async {
    final buf = BytesBuilder();

    if (_signingKey != null && _localPeerId.isNotEmpty) {
      // SignedPeerIds mode (type=1)
      buf.addByte(0x08); buf.addByte(0x01); // field 1: type = 1

      // Build PayloadSignedPeerIds
      final payloadBuf = BytesBuilder();
      // field 1: identity (proto-encoded public key)
      final identityProto = _signingKey!.publicKey.marshalProto();
      payloadBuf.addByte(0x0A); _wv(payloadBuf, identityProto.length);
      payloadBuf.add(identityProto);

      // field 2: sign = Ed25519Sign(localPeerId + remotePeerId)
      final message = utf8.encode(_localPeerId + _remotePeerId);
      final sig = await _signingKey!.sign(Uint8List.fromList(message));
      payloadBuf.addByte(0x12); _wv(payloadBuf, sig.length);
      payloadBuf.add(sig);
      final payload = payloadBuf.toBytes();

      // field 2: payload
      buf.addByte(0x12); _wv(buf, payload.length);
      buf.add(payload);
    }
    // else: SkipVerify (type=0, omitted)

    // field 3: version
    buf.addByte(0x18);
    _wv(buf, _protoVersion);
    // field 4: clientVersion
    final cv = utf8.encode(_clientVersion);
    buf.addByte(0x22);
    _wv(buf, cv.length);
    buf.add(cv);
    return buf.toBytes();
  }

  Uint8List _buildProto() {
    final buf = BytesBuilder();
    buf.addByte(0x10); buf.addByte(0x00); // encoding=None
    return buf.toBytes();
  }

  HandshakeError _decodeAckError(Uint8List p) {
    if (p.isEmpty) return HandshakeError.success;
    if (p.length >= 2 && p[0] == 0x08) return HandshakeError.fromCode(p[1]);
    return HandshakeError.success;
  }

  Map<String, dynamic> _decodeCredentials(Uint8List p) {
    final r = <String, dynamic>{};
    var pos = 0;
    while (pos < p.length) {
      final tag = p[pos++];
      final field = tag >> 3;
      final wt = tag & 0x07;
      if (wt == 0) {
        final (v, np) = _rv(p, pos); pos = np;
        if (field == 3) r['version'] = v;
      } else if (wt == 2) {
        final (len, np) = _rv(p, pos); pos = np;
        if (field == 4) r['clientVersion'] = utf8.decode(p.sublist(pos, pos + len));
        pos += len;
      }
    }
    return r;
  }

  bool _protoHasSnappy(Uint8List p) {
    var pos = 0;
    while (pos < p.length) {
      final tag = p[pos++];
      final field = tag >> 3;
      final wt = tag & 0x07;
      if (wt == 0) {
        final (v, np) = _rv(p, pos); pos = np;
        if (field == 2 && v == 1) return true;
      } else if (wt == 2) {
        final (len, np) = _rv(p, pos); pos = np + len;
      }
    }
    return false;
  }

  void _wv(BytesBuilder b, int v) {
    while (v > 0x7F) { b.addByte((v & 0x7F) | 0x80); v >>= 7; }
    b.addByte(v & 0x7F);
  }

  (int, int) _rv(Uint8List b, int p) {
    var r = 0, s = 0;
    while (p < b.length) {
      final byte = b[p++];
      r |= (byte & 0x7F) << s;
      if (byte & 0x80 == 0) return (r, p);
      s += 7;
    }
    return (r, p);
  }
}

class HandshakeException implements Exception {
  final String message;
  HandshakeException(this.message);
  @override
  String toString() => 'HandshakeException: $message';
}
