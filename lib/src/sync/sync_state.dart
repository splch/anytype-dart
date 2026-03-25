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

/// Sync engine state machine.
///
/// State flow:
///   DISCONNECTED → CONNECTING → HANDSHAKE → SYNCING → IDLE
///                                              ↕
///                                       RECEIVING / SENDING
///
/// Reconnection uses a fixed 1-minute timeout after failure.
library;

/// The state of the sync connection.
enum SyncStatus {
  /// Not connected to any sync node.
  disconnected,

  /// TCP/TLS connection being established.
  connecting,

  /// Credential exchange and protocol negotiation.
  handshake,

  /// Actively exchanging changes.
  syncing,

  /// Connected and up-to-date, waiting for new changes.
  idle,

  /// Receiving changes from a peer.
  receiving,

  /// Sending changes to a peer.
  sending,

  /// Connection failed, waiting to reconnect.
  reconnecting,
}

/// Events that trigger state transitions.
enum SyncEvent {
  connect,
  connectionEstablished,
  handshakeComplete,
  syncStarted,
  syncComplete,
  incomingChanges,
  outgoingChanges,
  transferComplete,
  disconnected,
  error,
  reconnectTimeout,
}

/// The sync state machine.
///
/// Manages transitions between sync states based on events.
/// The sync engine observes state changes to drive I/O operations.
class SyncStateMachine {
  SyncStatus _status = SyncStatus.disconnected;

  /// The current sync status.
  SyncStatus get status => _status;

  /// Callback invoked on state transitions.
  void Function(SyncStatus oldStatus, SyncStatus newStatus)? onTransition;

  /// Processes an event and transitions to the appropriate state.
  ///
  /// Returns true if the transition was valid.
  bool processEvent(SyncEvent event) {
    final newStatus = _nextState(_status, event);
    if (newStatus == null) return false;

    final oldStatus = _status;
    _status = newStatus;
    onTransition?.call(oldStatus, newStatus);
    return true;
  }

  /// Forces a specific state (for error recovery).
  void forceState(SyncStatus status) {
    final old = _status;
    _status = status;
    onTransition?.call(old, status);
  }

  /// Computes the next state given current state and event.
  static SyncStatus? _nextState(SyncStatus current, SyncEvent event) {
    return switch ((current, event)) {
      // From disconnected
      (SyncStatus.disconnected, SyncEvent.connect) => SyncStatus.connecting,

      // From connecting
      (SyncStatus.connecting, SyncEvent.connectionEstablished) =>
        SyncStatus.handshake,
      (SyncStatus.connecting, SyncEvent.error) => SyncStatus.reconnecting,

      // From handshake
      (SyncStatus.handshake, SyncEvent.handshakeComplete) =>
        SyncStatus.syncing,
      (SyncStatus.handshake, SyncEvent.error) => SyncStatus.reconnecting,

      // From syncing
      (SyncStatus.syncing, SyncEvent.syncComplete) => SyncStatus.idle,
      (SyncStatus.syncing, SyncEvent.error) => SyncStatus.reconnecting,

      // From idle
      (SyncStatus.idle, SyncEvent.incomingChanges) => SyncStatus.receiving,
      (SyncStatus.idle, SyncEvent.outgoingChanges) => SyncStatus.sending,
      (SyncStatus.idle, SyncEvent.disconnected) => SyncStatus.disconnected,
      (SyncStatus.idle, SyncEvent.error) => SyncStatus.reconnecting,

      // From receiving/sending
      (SyncStatus.receiving, SyncEvent.transferComplete) => SyncStatus.idle,
      (SyncStatus.receiving, SyncEvent.error) => SyncStatus.reconnecting,
      (SyncStatus.sending, SyncEvent.transferComplete) => SyncStatus.idle,
      (SyncStatus.sending, SyncEvent.error) => SyncStatus.reconnecting,

      // From reconnecting
      (SyncStatus.reconnecting, SyncEvent.reconnectTimeout) =>
        SyncStatus.connecting,
      (SyncStatus.reconnecting, SyncEvent.disconnected) =>
        SyncStatus.disconnected,

      // Any state can be explicitly disconnected
      (_, SyncEvent.disconnected) => SyncStatus.disconnected,

      _ => null, // Invalid transition
    };
  }
}
