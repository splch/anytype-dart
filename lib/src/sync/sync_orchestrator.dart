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

/// Sync orchestrator — ties storage, CRDT trees, and sync client together.
///
/// Responsibilities:
///   - Persists local changes to storage before syncing
///   - Loads changes from storage into CRDT trees
///   - Coordinates sync client operations
///   - Tracks which objects need syncing
///   - Manages background sync lifecycle
library;

import 'dart:async';
import 'dart:typed_data';

import '../crdt/change.dart';
import '../crdt/change_builder.dart';
import '../crdt/object_tree.dart';
import '../crdt/tree.dart';
import '../storage/storage.dart';
import 'conflict.dart';
import 'sync_client.dart';
import 'sync_state.dart';

/// Manages the background sync lifecycle.
///
/// Ensures all writes go to local storage first (offline-first),
/// then queues changes for sync when connectivity is available.
class SyncOrchestrator {
  final StorageService storage;
  final SyncClient syncClient;
  final ConflictDetector conflictDetector;

  /// Trees currently loaded in memory, keyed by tree ID.
  final Map<String, ObjectTree> _activeTrees = {};

  /// Tree IDs with pending outgoing changes.
  final Set<String> _pendingSync = {};

  /// Current conflict state per tree.
  final Map<String, ConflictInfo> _conflicts = {};

  /// Stream controller for conflict state changes.
  final _conflictController = StreamController<ConflictInfo>.broadcast();

  /// Stream of conflict events.
  Stream<ConflictInfo> get onConflict => _conflictController.stream;

  /// Timer for periodic sync attempts.
  Timer? _syncTimer;

  /// Whether background sync is active.
  bool _running = false;

  SyncOrchestrator({
    required this.storage,
    required this.syncClient,
    ConflictDetector? conflictDetector,
  }) : conflictDetector = conflictDetector ?? ConflictDetector();

  /// Starts the background sync loop.
  void start({Duration interval = const Duration(seconds: 30)}) {
    if (_running) return;
    _running = true;
    _syncTimer = Timer.periodic(interval, (_) => _syncPending());
  }

  /// Stops the background sync loop.
  void stop() {
    _running = false;
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  /// Registers an active tree for sync tracking.
  void registerTree(ObjectTree tree) {
    _activeTrees[tree.id] = tree;
    _checkConflicts(tree);
  }

  /// Unregisters a tree.
  void unregisterTree(String treeId) {
    _activeTrees.remove(treeId);
    _conflicts.remove(treeId);
  }

  /// Called after a local change is added to a tree.
  ///
  /// Persists the change to storage and marks the tree for sync.
  Future<void> onLocalChange(
    String treeId,
    RawChange rawChange,
    Change change,
  ) async {
    // 1. Persist to storage (offline-first: storage is truth)
    await storage.changes.saveChange(StoredChange(
      treeId: treeId,
      id: rawChange.id,
      rawData: rawChange.rawData,
      orderId: change.orderId,
      previousIds: change.previousIds,
      isSnapshot: change.isSnapshot,
      snapshotId: change.snapshotId,
      timestamp: change.timestamp,
    ));

    // 2. Update heads in storage
    final tree = _activeTrees[treeId];
    if (tree != null) {
      await storage.changes.saveHeads(treeId, tree.heads);
    }

    // 3. Mark for sync
    _pendingSync.add(treeId);

    // 4. Trigger immediate sync attempt if connected
    if (syncClient.stateMachine.status == SyncStatus.idle) {
      unawaited(_syncTree(treeId));
    }
  }

  /// Called when remote changes arrive for a tree.
  ///
  /// Loads changes into the active tree and checks for conflicts.
  Future<void> onRemoteChanges(
    String treeId,
    List<StoredChange> changes,
  ) async {
    final tree = _activeTrees[treeId];
    if (tree == null) return;

    // Build RawChange list and add to tree
    final rawChanges = changes.map((c) => RawChange(
      rawData: c.rawData,
      id: c.id,
    )).toList();

    await tree.addRawChanges(RawChangesPayload(
      newHeads: [],
      rawChanges: rawChanges,
    ));

    // Persist the updated heads
    await storage.changes.saveHeads(treeId, tree.heads);

    // Check for conflicts
    _checkConflicts(tree);
  }

  /// Gets the current conflict info for a tree (null if no conflict).
  ConflictInfo? getConflict(String treeId) => _conflicts[treeId];

  /// Gets all current conflicts.
  List<ConflictInfo> get allConflicts => _conflicts.values.toList();

  /// Whether any tree has a hard conflict.
  bool get hasHardConflicts =>
      _conflicts.values.any((c) => c.severity == ConflictSeverity.hard);

  /// Attempts to sync all pending trees.
  Future<void> _syncPending() async {
    if (_pendingSync.isEmpty) return;

    final trees = List<String>.from(_pendingSync);
    for (final treeId in trees) {
      await _syncTree(treeId);
    }
  }

  /// Attempts to sync a single tree with peers.
  Future<void> _syncTree(String treeId) async {
    if (syncClient.stateMachine.status == SyncStatus.disconnected ||
        syncClient.stateMachine.status == SyncStatus.reconnecting) {
      return; // Can't sync right now
    }

    final tree = _activeTrees[treeId];
    if (tree == null) return;

    try {
      // Load recent changes to send
      final lastSeq = await storage.syncState.getLastSyncedSeq(
        'self', treeId,
      );
      final unsyncedChanges = await storage.changes.loadAfterSeq(
        treeId, lastSeq,
      );

      if (unsyncedChanges.isEmpty) {
        _pendingSync.remove(treeId);
        return;
      }

      // Prepare and broadcast head update
      final rawChanges = unsyncedChanges.map((c) =>
        RawChange(rawData: c.rawData, id: c.id),
      ).toList();

      final update = HeadUpdate(
        objectId: treeId,
        heads: tree.heads,
        changes: rawChanges,
        snapshotPath: tree.snapshotPath(),
      );

      await syncClient.broadcastHeadUpdate(update);

      // Update sync position
      if (unsyncedChanges.isNotEmpty) {
        await storage.syncState.setLastSyncedSeq(
          'self', treeId, unsyncedChanges.last.addSeq,
        );
      }

      _pendingSync.remove(treeId);
    } catch (_) {
      // Will retry on next sync cycle
    }
  }

  void _checkConflicts(ObjectTree tree) {
    final info = conflictDetector.checkTree(tree.tree);
    if (info.hasConflict) {
      _conflicts[tree.id] = info;
      _conflictController.add(info);
    } else {
      _conflicts.remove(tree.id);
    }
  }

  /// Cleans up resources.
  void dispose() {
    stop();
    _conflictController.close();
  }
}
