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

/// Sync client for the any-sync protocol.
///
/// Manages space subscriptions, head sync, and bidirectional
/// change exchange with sync nodes and peers.
///
/// Protocol flow:
///   1. Connect to sync node (TLS + handshake)
///   2. Subscribe to spaces
///   3. HeadSync: hash-range consistency check per space
///   4. ObjectSync: exchange changes for divergent objects
///   5. Idle: wait for push updates
library;

import 'dart:typed_data';

import '../crdt/change_builder.dart';
import '../storage/storage.dart';
import 'sync_state.dart';

/// A sync message between peers.
sealed class SyncMessage {
  String get objectId;
}

/// Announces new heads and changes for an object.
class HeadUpdate extends SyncMessage {
  @override
  final String objectId;
  final List<String> heads;
  final List<RawChange> changes;
  final List<String> snapshotPath;

  HeadUpdate({
    required this.objectId,
    required this.heads,
    required this.changes,
    this.snapshotPath = const [],
  });
}

/// Requests full sync for an object.
class FullSyncRequest extends SyncMessage {
  @override
  final String objectId;
  final List<String> heads;
  final List<String> snapshotPath;

  FullSyncRequest({
    required this.objectId,
    required this.heads,
    this.snapshotPath = const [],
  });
}

/// Response with full state for an object.
class FullSyncResponse extends SyncMessage {
  @override
  final String objectId;
  final List<String> heads;
  final List<RawChange> changes;
  final List<String> snapshotPath;

  FullSyncResponse({
    required this.objectId,
    required this.heads,
    required this.changes,
    this.snapshotPath = const [],
  });
}

/// An element in the head sync hash-range protocol.
class HeadSyncElement {
  final String objectId;
  final String head;

  const HeadSyncElement({required this.objectId, required this.head});
}

/// Result of a head sync range comparison.
class HeadSyncResult {
  final Uint8List hash;
  final List<HeadSyncElement> elements;
  final int count;

  const HeadSyncResult({
    required this.hash,
    required this.elements,
    required this.count,
  });
}

/// Abstract transport layer for sending/receiving sync messages.
///
/// Implementations provide gRPC, WebSocket, or direct P2P transports.
abstract class SyncTransport {
  /// Sends a sync message to a peer.
  Future<void> send(String peerId, SyncMessage message);

  /// Stream of incoming messages from peers.
  Stream<(String peerId, SyncMessage message)> get incoming;

  /// Connects to a peer.
  Future<void> connect(String peerId, String address);

  /// Disconnects from a peer.
  Future<void> disconnect(String peerId);

  /// Whether a peer is connected.
  bool isConnected(String peerId);
}

/// The sync client orchestrates change exchange with peers.
///
/// It uses the storage layer to persist changes and track sync state,
/// and the transport layer for network communication.
class SyncClient {
  final StorageService storage;
  final SyncStateMachine stateMachine;
  final SyncTransport? transport;

  /// Spaces this client is subscribed to.
  final Set<String> _subscribedSpaces = {};

  /// Known peer IDs.
  final Set<String> _peers = {};

  SyncClient({
    required this.storage,
    SyncTransport? transport,
  })  : stateMachine = SyncStateMachine(),
        transport = transport;

  /// Subscribes to a space for sync.
  void subscribeSpace(String spaceId) {
    _subscribedSpaces.add(spaceId);
  }

  /// Unsubscribes from a space.
  void unsubscribeSpace(String spaceId) {
    _subscribedSpaces.remove(spaceId);
  }

  /// Registers a peer for sync.
  void addPeer(String peerId) {
    _peers.add(peerId);
  }

  /// Handles an incoming head update from a peer.
  ///
  /// Stores the new changes and checks if heads match.
  /// Returns true if heads now match, false if full sync is needed.
  Future<bool> handleHeadUpdate(
    String peerId,
    HeadUpdate update,
  ) async {
    // Store the incoming changes
    final storedChanges = <StoredChange>[];
    for (final raw in update.changes) {
      storedChanges.add(StoredChange(
        treeId: update.objectId,
        id: raw.id,
        rawData: raw.rawData,
      ));
    }
    await storage.changes.saveChanges(storedChanges);

    // Check if our heads match the peer's heads
    final ourHeads = await storage.changes.loadHeads(update.objectId);
    if (_headsMatch(ourHeads, update.heads)) {
      await storage.syncState.setLastSyncedOrder(
        peerId,
        update.objectId,
        update.heads.join(','),
      );
      return true;
    }

    return false; // Need full sync
  }

  /// Handles a full sync request from a peer.
  ///
  /// Finds the common snapshot and returns all changes since then.
  Future<FullSyncResponse> handleFullSyncRequest(
    FullSyncRequest request,
  ) async {
    final allChanges = await storage.changes.loadTree(request.objectId);
    final heads = await storage.changes.loadHeads(request.objectId);

    return FullSyncResponse(
      objectId: request.objectId,
      heads: heads,
      changes: allChanges
          .map((c) => RawChange(rawData: c.rawData, id: c.id))
          .toList(),
    );
  }

  /// Handles a full sync response from a peer.
  Future<void> handleFullSyncResponse(
    String peerId,
    FullSyncResponse response,
  ) async {
    final storedChanges = <StoredChange>[];
    for (final raw in response.changes) {
      if (!await storage.changes.hasChange(response.objectId, raw.id)) {
        storedChanges.add(StoredChange(
          treeId: response.objectId,
          id: raw.id,
          rawData: raw.rawData,
        ));
      }
    }
    await storage.changes.saveChanges(storedChanges);
    await storage.changes.saveHeads(response.objectId, response.heads);
  }

  /// Prepares a head update to send to peers after local changes.
  Future<HeadUpdate> prepareHeadUpdate(
    String objectId,
    List<RawChange> newChanges,
  ) async {
    final heads = await storage.changes.loadHeads(objectId);
    return HeadUpdate(
      objectId: objectId,
      heads: heads,
      changes: newChanges,
    );
  }

  /// Broadcasts a head update to all connected peers.
  Future<void> broadcastHeadUpdate(HeadUpdate update) async {
    if (transport == null) return;
    for (final peerId in _peers) {
      if (transport!.isConnected(peerId)) {
        await transport!.send(peerId, update);
      }
    }
  }

  bool _headsMatch(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    final sortedA = List<String>.from(a)..sort();
    final sortedB = List<String>.from(b)..sort();
    for (var i = 0; i < sortedA.length; i++) {
      if (sortedA[i] != sortedB[i]) return false;
    }
    return true;
  }
}
