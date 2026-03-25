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

/// Yamux stream multiplexer (hashicorp/yamux v0.1.2 compatible).
///
/// Frame format: 12-byte header
///   [version:1][type:1][flags:2 BE][streamID:4 BE][length:4 BE]
///   followed by 'length' bytes of payload.
library;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

// Yamux protocol constants
const int _yamuxVersion = 0;
const int _typeData = 0;
const int _typeWindowUpdate = 1;
const int _typePing = 2;
const int _typeGoAway = 3;

const int _flagSYN = 0x0001;
const int _flagACK = 0x0002;
const int _flagFIN = 0x0004;
const int _flagRST = 0x0008;

const int _initialWindowSize = 256 * 1024; // 256 KB

/// A yamux stream (virtual connection within a session).
class YamuxStream {
  final int id;
  final YamuxSession _session;
  final _dataController = StreamController<Uint8List>();
  int _recvWindow = _initialWindowSize;
  bool _closed = false;

  YamuxStream(this.id, this._session);

  Stream<Uint8List> get data => _dataController.stream;
  bool get isClosed => _closed;

  Future<void> write(Uint8List payload) async {
    if (_closed) throw StateError('Stream $id is closed');
    await _session._sendFrame(_typeData, 0, id, payload);
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _session._sendFrame(_typeData, _flagFIN, id, Uint8List(0));
    _dataController.close();
  }

  void _onData(Uint8List data) {
    if (!_closed) _dataController.add(data);
  }

  void _onClose() {
    _closed = true;
    _dataController.close();
  }
}

/// A yamux multiplexing session over a raw socket.
class YamuxSession {
  final Socket _socket;
  final bool _isClient;
  final Map<int, YamuxStream> _streams = {};
  int _nextStreamId;
  final List<int> _readBuf = [];
  bool _closed = false;
  late StreamSubscription _socketSub;
  final _incomingStreams = StreamController<YamuxStream>();

  YamuxSession(this._socket, {bool isClient = true})
      : _isClient = isClient,
        _nextStreamId = isClient ? 1 : 2 {
    _socketSub = _socket.listen(
      _onSocketData,
      onError: _onSocketError,
      onDone: _onSocketDone,
    );
  }

  Stream<YamuxStream> get incomingStreams => _incomingStreams.stream;
  bool get isClosed => _closed;

  /// Opens a new stream (client-initiated).
  Future<YamuxStream> openStream() async {
    final id = _nextStreamId;
    _nextStreamId += 2; // Client uses odd IDs, server uses even

    final stream = YamuxStream(id, this);
    _streams[id] = stream;

    // Send SYN + window update
    await _sendFrame(_typeWindowUpdate, _flagSYN, id,
        Uint8List(0), length: _initialWindowSize);

    return stream;
  }

  /// Closes the session.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    // Send GoAway
    await _sendFrame(_typeGoAway, 0, 0, Uint8List(0));
    for (final s in _streams.values) {
      s._onClose();
    }
    _streams.clear();
    await _socketSub.cancel();
    _incomingStreams.close();
  }

  Future<void> _sendFrame(int type, int flags, int streamId,
      Uint8List payload, {int? length}) async {
    final header = Uint8List(12);
    final view = ByteData.sublistView(header);
    view.setUint8(0, _yamuxVersion);
    view.setUint8(1, type);
    view.setUint16(2, flags, Endian.big);
    view.setUint32(4, streamId, Endian.big);
    view.setUint32(8, length ?? payload.length, Endian.big);
    _socket.add(header);
    if (payload.isNotEmpty) _socket.add(payload);
    await _socket.flush();
  }

  void _onSocketData(Uint8List data) {
    _readBuf.addAll(data);
    _processFrames();
  }

  void _processFrames() {
    while (_readBuf.length >= 12) {
      final version = _readBuf[0];
      if (version != _yamuxVersion) {
        _close('Invalid yamux version: $version');
        return;
      }

      final type = _readBuf[1];
      final flags = (_readBuf[2] << 8) | _readBuf[3];
      final streamId = (_readBuf[4] << 24) |
          (_readBuf[5] << 16) |
          (_readBuf[6] << 8) |
          _readBuf[7];
      final length = (_readBuf[8] << 24) |
          (_readBuf[9] << 16) |
          (_readBuf[10] << 8) |
          _readBuf[11];

      if (type == _typeData && _readBuf.length < 12 + length) {
        return; // Wait for complete frame
      }

      _readBuf.removeRange(0, 12);

      Uint8List? payload;
      if (type == _typeData && length > 0) {
        payload = Uint8List.fromList(_readBuf.sublist(0, length));
        _readBuf.removeRange(0, length);
      }

      _handleFrame(type, flags, streamId, length, payload);
    }
  }

  void _handleFrame(int type, int flags, int streamId, int length,
      Uint8List? payload) {
    // Handle SYN flag — new stream from remote
    if (flags & _flagSYN != 0) {
      if (!_streams.containsKey(streamId)) {
        final stream = YamuxStream(streamId, this);
        _streams[streamId] = stream;
        _incomingStreams.add(stream);
        // Send ACK
        _sendFrame(_typeWindowUpdate, _flagACK, streamId,
            Uint8List(0), length: _initialWindowSize);
      }
    }

    // Handle ACK flag
    if (flags & _flagACK != 0) {
      // Stream acknowledged
    }

    // Handle data
    if (type == _typeData && payload != null && payload.isNotEmpty) {
      final stream = _streams[streamId];
      stream?._onData(payload);
    }

    // Handle FIN flag — remote closing
    if (flags & _flagFIN != 0) {
      _streams[streamId]?._onClose();
    }

    // Handle RST flag — stream reset
    if (flags & _flagRST != 0) {
      _streams[streamId]?._onClose();
      _streams.remove(streamId);
    }

    // Handle GoAway
    if (type == _typeGoAway) {
      _close('Remote sent GoAway');
    }

    // Handle Ping
    if (type == _typePing) {
      // Send pong (ping with ACK flag, same stream ID/length)
      _sendFrame(_typePing, _flagACK, streamId, Uint8List(0), length: length);
    }

    // Handle WindowUpdate
    if (type == _typeWindowUpdate) {
      // Update send window for stream (length = window increment)
    }
  }

  void _onSocketError(Object error) {
    _close('Socket error: $error');
  }

  void _onSocketDone() {
    _close('Socket closed');
  }

  void _close(String reason) {
    if (_closed) return;
    _closed = true;
    for (final s in _streams.values) {
      s._onClose();
    }
    _streams.clear();
    _incomingStreams.close();
  }
}
