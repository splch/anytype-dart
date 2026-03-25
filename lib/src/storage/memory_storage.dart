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

/// In-memory storage implementation for testing and development.
///
/// Provides the same interface as the eventual SQLite storage,
/// but stores everything in memory. Data is lost when the process exits.
library;

import 'dart:typed_data';

import 'storage.dart';

/// In-memory object snapshot store.
class MemoryObjectStore implements ObjectStore {
  final Map<String, Uint8List> _snapshots = {};

  @override
  Future<void> saveSnapshot(String objectId, Uint8List data) async {
    _snapshots[objectId] = Uint8List.fromList(data);
  }

  @override
  Future<Uint8List?> loadSnapshot(String objectId) async {
    return _snapshots[objectId];
  }

  @override
  Future<void> deleteSnapshot(String objectId) async {
    _snapshots.remove(objectId);
  }

  @override
  Future<List<String>> listObjectIds() async {
    return _snapshots.keys.toList();
  }
}

/// In-memory change store.
class MemoryChangeStore implements ChangeStore {
  /// Changes keyed by treeId → changeId → StoredChange.
  final Map<String, Map<String, StoredChange>> _changes = {};

  /// Heads keyed by treeId.
  final Map<String, List<String>> _heads = {};

  /// Global monotonic sequence counter.
  int _seqCounter = 0;

  @override
  Future<int> saveChange(StoredChange change) async {
    final seq = ++_seqCounter;
    final stored = StoredChange(
      treeId: change.treeId,
      id: change.id,
      rawData: change.rawData,
      orderId: change.orderId,
      addSeq: seq,
      previousIds: change.previousIds,
      isSnapshot: change.isSnapshot,
      snapshotId: change.snapshotId,
      timestamp: change.timestamp,
    );
    _changes.putIfAbsent(change.treeId, () => {})[change.id] = stored;
    return seq;
  }

  @override
  Future<void> saveChanges(List<StoredChange> changes) async {
    for (final change in changes) {
      await saveChange(change);
    }
  }

  @override
  Future<StoredChange?> loadChange(String treeId, String changeId) async {
    return _changes[treeId]?[changeId];
  }

  @override
  Future<List<StoredChange>> loadTree(String treeId) async {
    final tree = _changes[treeId];
    if (tree == null) return const [];
    final list = tree.values.toList();
    list.sort((a, b) => a.addSeq.compareTo(b.addSeq));
    return list;
  }

  @override
  Future<List<StoredChange>> loadAfterOrder(
    String treeId,
    String afterOrderId,
  ) async {
    final tree = _changes[treeId];
    if (tree == null) return const [];
    final list = tree.values
        .where((c) => c.orderId.compareTo(afterOrderId) > 0)
        .toList();
    list.sort((a, b) => a.orderId.compareTo(b.orderId));
    return list;
  }

  @override
  Future<List<StoredChange>> loadAfterSeq(String treeId, int afterSeq) async {
    final tree = _changes[treeId];
    if (tree == null) return const [];
    final list = tree.values.where((c) => c.addSeq > afterSeq).toList();
    list.sort((a, b) => a.addSeq.compareTo(b.addSeq));
    return list;
  }

  @override
  Future<void> saveHeads(String treeId, List<String> headIds) async {
    _heads[treeId] = List.from(headIds);
  }

  @override
  Future<List<String>> loadHeads(String treeId) async {
    return _heads[treeId] ?? const [];
  }

  @override
  Future<bool> hasChange(String treeId, String changeId) async {
    return _changes[treeId]?.containsKey(changeId) ?? false;
  }

  @override
  Future<void> deleteTree(String treeId) async {
    _changes.remove(treeId);
    _heads.remove(treeId);
  }
}

/// In-memory sync state store.
class MemorySyncStateStore implements SyncStateStore {
  /// Keys: "$peerId:$treeId" → orderId.
  final Map<String, String> _orderState = {};

  /// Keys: "$peerId:$treeId" → seq.
  final Map<String, int> _seqState = {};

  String _key(String peerId, String treeId) => '$peerId:$treeId';

  @override
  Future<void> setLastSyncedOrder(
    String peerId,
    String treeId,
    String orderId,
  ) async {
    _orderState[_key(peerId, treeId)] = orderId;
  }

  @override
  Future<String?> getLastSyncedOrder(String peerId, String treeId) async {
    return _orderState[_key(peerId, treeId)];
  }

  @override
  Future<void> setLastSyncedSeq(String peerId, String treeId, int seq) async {
    _seqState[_key(peerId, treeId)] = seq;
  }

  @override
  Future<int> getLastSyncedSeq(String peerId, String treeId) async {
    return _seqState[_key(peerId, treeId)] ?? 0;
  }

  @override
  Future<void> clearPeer(String peerId) async {
    _orderState.removeWhere((k, _) => k.startsWith('$peerId:'));
    _seqState.removeWhere((k, _) => k.startsWith('$peerId:'));
  }
}

/// In-memory file store.
class MemoryFileStore implements FileStore {
  final Map<String, Uint8List> _files = {};

  @override
  Future<void> saveFile(String hash, Uint8List data) async {
    _files[hash] = Uint8List.fromList(data);
  }

  @override
  Future<Uint8List?> loadFile(String hash) async {
    return _files[hash];
  }

  @override
  Future<bool> hasFile(String hash) async {
    return _files.containsKey(hash);
  }

  @override
  Future<void> deleteFile(String hash) async {
    _files.remove(hash);
  }

  @override
  Future<int> usageBytes() async {
    var total = 0;
    for (final data in _files.values) {
      total += data.length;
    }
    return total;
  }
}

/// Complete in-memory storage service.
class MemoryStorageService implements StorageService {
  final MemoryObjectStore _objects = MemoryObjectStore();
  final MemoryChangeStore _changes = MemoryChangeStore();
  final MemorySyncStateStore _syncState = MemorySyncStateStore();
  final MemoryFileStore _files = MemoryFileStore();

  @override
  ObjectStore get objects => _objects;

  @override
  ChangeStore get changes => _changes;

  @override
  SyncStateStore get syncState => _syncState;

  @override
  FileStore get files => _files;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> close() async {}
}
