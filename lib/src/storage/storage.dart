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

/// Storage interfaces for the offline-first data layer.
///
/// All writes go to local storage first; sync is background-only.
/// The storage layer must never lose data — it is the source of truth.
library;

import 'dart:typed_data';

export 'memory_storage.dart';

/// A stored change with metadata for persistence and sync.
class StoredChange {
  /// The CRDT tree this change belongs to.
  final String treeId;

  /// The change's content-addressable ID (CID).
  final String id;

  /// The raw signed change bytes.
  final Uint8List rawData;

  /// Lexicographic order ID for range queries.
  final String orderId;

  /// Space-global monotonic sequence (auto-assigned by storage).
  final int addSeq;

  /// Parent change IDs (for DAG reconstruction).
  final List<String> previousIds;

  /// Whether this is a snapshot change.
  final bool isSnapshot;

  /// The snapshot this change is based on.
  final String snapshotId;

  /// Unix timestamp.
  final int timestamp;

  const StoredChange({
    required this.treeId,
    required this.id,
    required this.rawData,
    this.orderId = '',
    this.addSeq = 0,
    this.previousIds = const [],
    this.isSnapshot = false,
    this.snapshotId = '',
    this.timestamp = 0,
  });
}

/// Stores and retrieves object snapshots (materialized state).
abstract class ObjectStore {
  /// Saves a serialized object snapshot.
  Future<void> saveSnapshot(String objectId, Uint8List data);

  /// Loads a serialized object snapshot.
  Future<Uint8List?> loadSnapshot(String objectId);

  /// Deletes an object snapshot.
  Future<void> deleteSnapshot(String objectId);

  /// Lists all stored object IDs.
  Future<List<String>> listObjectIds();
}

/// Stores and retrieves individual CRDT changes.
abstract class ChangeStore {
  /// Saves a change. Returns the assigned addSeq.
  Future<int> saveChange(StoredChange change);

  /// Saves multiple changes atomically.
  Future<void> saveChanges(List<StoredChange> changes);

  /// Loads a specific change.
  Future<StoredChange?> loadChange(String treeId, String changeId);

  /// Loads all changes for a tree.
  Future<List<StoredChange>> loadTree(String treeId);

  /// Loads changes with orderId > [afterOrderId], sorted by orderId.
  Future<List<StoredChange>> loadAfterOrder(
    String treeId,
    String afterOrderId,
  );

  /// Loads changes with addSeq > [afterSeq], sorted by addSeq.
  Future<List<StoredChange>> loadAfterSeq(String treeId, int afterSeq);

  /// Saves the current head IDs for a tree.
  Future<void> saveHeads(String treeId, List<String> headIds);

  /// Loads the current head IDs for a tree.
  Future<List<String>> loadHeads(String treeId);

  /// Checks if a change exists.
  Future<bool> hasChange(String treeId, String changeId);

  /// Deletes all changes for a tree.
  Future<void> deleteTree(String treeId);
}

/// Tracks sync progress per peer per tree.
abstract class SyncStateStore {
  /// Sets the last synced orderId for a peer+tree combination.
  Future<void> setLastSyncedOrder(
    String peerId,
    String treeId,
    String orderId,
  );

  /// Gets the last synced orderId for a peer+tree.
  Future<String?> getLastSyncedOrder(String peerId, String treeId);

  /// Sets the last synced addSeq for a peer+tree combination.
  Future<void> setLastSyncedSeq(String peerId, String treeId, int seq);

  /// Gets the last synced addSeq for a peer+tree.
  Future<int> getLastSyncedSeq(String peerId, String treeId);

  /// Clears all sync state for a peer.
  Future<void> clearPeer(String peerId);
}

/// Stores file blobs (images, attachments) locally.
abstract class FileStore {
  /// Saves a file blob by its content hash.
  Future<void> saveFile(String hash, Uint8List data);

  /// Loads a file blob by its content hash.
  Future<Uint8List?> loadFile(String hash);

  /// Checks if a file exists locally.
  Future<bool> hasFile(String hash);

  /// Deletes a file.
  Future<void> deleteFile(String hash);

  /// Returns total storage usage in bytes.
  Future<int> usageBytes();
}

/// Unified storage service combining all stores.
abstract class StorageService {
  ObjectStore get objects;
  ChangeStore get changes;
  SyncStateStore get syncState;
  FileStore get files;

  /// Initializes the storage (open database, create tables, etc.).
  Future<void> initialize();

  /// Closes the storage cleanly.
  Future<void> close();
}
