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

/// SQLite-backed persistent storage.
///
/// Uses the `sqlite3` package directly (no code generation required).
/// Schema supports indexed queries for fast object open, OrderId
/// range scans, and full-text search.
///
/// Database schema version: 1
library;

import 'dart:typed_data';

import 'package:sqlite3/sqlite3.dart';

import 'storage.dart';

const int _schemaVersion = 1;

const String _createSchema = '''
  CREATE TABLE IF NOT EXISTS object_snapshots (
    object_id TEXT PRIMARY KEY,
    data BLOB NOT NULL,
    updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
  );

  CREATE TABLE IF NOT EXISTS changes (
    tree_id TEXT NOT NULL,
    change_id TEXT NOT NULL,
    raw_data BLOB NOT NULL,
    order_id TEXT NOT NULL DEFAULT '',
    add_seq INTEGER PRIMARY KEY AUTOINCREMENT,
    previous_ids TEXT NOT NULL DEFAULT '[]',
    is_snapshot INTEGER NOT NULL DEFAULT 0,
    snapshot_id TEXT NOT NULL DEFAULT '',
    timestamp INTEGER NOT NULL DEFAULT 0,
    UNIQUE(tree_id, change_id)
  );

  CREATE INDEX IF NOT EXISTS idx_changes_tree ON changes(tree_id);
  CREATE INDEX IF NOT EXISTS idx_changes_order ON changes(tree_id, order_id);
  CREATE INDEX IF NOT EXISTS idx_changes_seq ON changes(tree_id, add_seq);

  CREATE TABLE IF NOT EXISTS tree_heads (
    tree_id TEXT PRIMARY KEY,
    head_ids TEXT NOT NULL DEFAULT '[]'
  );

  CREATE TABLE IF NOT EXISTS sync_state_order (
    peer_id TEXT NOT NULL,
    tree_id TEXT NOT NULL,
    order_id TEXT NOT NULL,
    PRIMARY KEY (peer_id, tree_id)
  );

  CREATE TABLE IF NOT EXISTS sync_state_seq (
    peer_id TEXT NOT NULL,
    tree_id TEXT NOT NULL,
    seq INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (peer_id, tree_id)
  );

  CREATE TABLE IF NOT EXISTS files (
    hash TEXT PRIMARY KEY,
    data BLOB NOT NULL,
    size INTEGER NOT NULL
  );

  CREATE TABLE IF NOT EXISTS object_index (
    object_id TEXT PRIMARY KEY,
    name TEXT NOT NULL DEFAULT '',
    type_id TEXT NOT NULL DEFAULT '',
    icon_emoji TEXT NOT NULL DEFAULT '',
    is_archived INTEGER NOT NULL DEFAULT 0,
    is_favorite INTEGER NOT NULL DEFAULT 0,
    block_count INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
  );

  CREATE INDEX IF NOT EXISTS idx_object_index_name ON object_index(name);
  CREATE INDEX IF NOT EXISTS idx_object_index_type ON object_index(type_id);
  CREATE INDEX IF NOT EXISTS idx_object_index_fav ON object_index(is_favorite);

  CREATE TABLE IF NOT EXISTS schema_version (
    version INTEGER NOT NULL
  );
''';

/// SQLite-backed object snapshot store.
class SqliteObjectStore implements ObjectStore {
  final Database _db;
  SqliteObjectStore(this._db);

  @override
  Future<void> saveSnapshot(String objectId, Uint8List data) async {
    _db.execute(
      'INSERT OR REPLACE INTO object_snapshots (object_id, data, updated_at) '
      'VALUES (?, ?, ?)',
      [objectId, data, DateTime.now().millisecondsSinceEpoch ~/ 1000],
    );
  }

  @override
  Future<Uint8List?> loadSnapshot(String objectId) async {
    final result = _db.select(
      'SELECT data FROM object_snapshots WHERE object_id = ?',
      [objectId],
    );
    if (result.isEmpty) return null;
    final blob = result.first['data'];
    if (blob is Uint8List) return blob;
    if (blob is List<int>) return Uint8List.fromList(blob);
    return null;
  }

  @override
  Future<void> deleteSnapshot(String objectId) async {
    _db.execute(
      'DELETE FROM object_snapshots WHERE object_id = ?',
      [objectId],
    );
    _db.execute(
      'DELETE FROM object_index WHERE object_id = ?',
      [objectId],
    );
  }

  @override
  Future<List<String>> listObjectIds() async {
    final result = _db.select('SELECT object_id FROM object_snapshots');
    return result.map((r) => r['object_id'] as String).toList();
  }
}

/// SQLite-backed change store with indexed queries.
class SqliteChangeStore implements ChangeStore {
  final Database _db;
  SqliteChangeStore(this._db);

  @override
  Future<int> saveChange(StoredChange change) async {
    _db.execute(
      'INSERT OR IGNORE INTO changes '
      '(tree_id, change_id, raw_data, order_id, previous_ids, '
      'is_snapshot, snapshot_id, timestamp) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        change.treeId,
        change.id,
        change.rawData,
        change.orderId,
        change.previousIds.join(','),
        change.isSnapshot ? 1 : 0,
        change.snapshotId,
        change.timestamp,
      ],
    );
    return _db.lastInsertRowId;
  }

  @override
  Future<void> saveChanges(List<StoredChange> changes) async {
    _db.execute('BEGIN TRANSACTION');
    try {
      for (final change in changes) {
        await saveChange(change);
      }
      _db.execute('COMMIT');
    } catch (e) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  @override
  Future<StoredChange?> loadChange(String treeId, String changeId) async {
    final result = _db.select(
      'SELECT * FROM changes WHERE tree_id = ? AND change_id = ?',
      [treeId, changeId],
    );
    if (result.isEmpty) return null;
    return _rowToChange(result.first);
  }

  @override
  Future<List<StoredChange>> loadTree(String treeId) async {
    final result = _db.select(
      'SELECT * FROM changes WHERE tree_id = ? ORDER BY add_seq',
      [treeId],
    );
    return result.map(_rowToChange).toList();
  }

  @override
  Future<List<StoredChange>> loadAfterOrder(
    String treeId,
    String afterOrderId,
  ) async {
    final result = _db.select(
      'SELECT * FROM changes WHERE tree_id = ? AND order_id > ? '
      'ORDER BY order_id',
      [treeId, afterOrderId],
    );
    return result.map(_rowToChange).toList();
  }

  @override
  Future<List<StoredChange>> loadAfterSeq(String treeId, int afterSeq) async {
    final result = _db.select(
      'SELECT * FROM changes WHERE tree_id = ? AND add_seq > ? '
      'ORDER BY add_seq',
      [treeId, afterSeq],
    );
    return result.map(_rowToChange).toList();
  }

  @override
  Future<void> saveHeads(String treeId, List<String> headIds) async {
    _db.execute(
      'INSERT OR REPLACE INTO tree_heads (tree_id, head_ids) VALUES (?, ?)',
      [treeId, headIds.join(',')],
    );
  }

  @override
  Future<List<String>> loadHeads(String treeId) async {
    final result = _db.select(
      'SELECT head_ids FROM tree_heads WHERE tree_id = ?',
      [treeId],
    );
    if (result.isEmpty) return const [];
    final ids = result.first['head_ids'] as String;
    if (ids.isEmpty) return const [];
    return ids.split(',');
  }

  @override
  Future<bool> hasChange(String treeId, String changeId) async {
    final result = _db.select(
      'SELECT 1 FROM changes WHERE tree_id = ? AND change_id = ? LIMIT 1',
      [treeId, changeId],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> deleteTree(String treeId) async {
    _db.execute('DELETE FROM changes WHERE tree_id = ?', [treeId]);
    _db.execute('DELETE FROM tree_heads WHERE tree_id = ?', [treeId]);
  }

  StoredChange _rowToChange(Row row) {
    final prevStr = row['previous_ids'] as String;
    return StoredChange(
      treeId: row['tree_id'] as String,
      id: row['change_id'] as String,
      rawData: Uint8List.fromList(row['raw_data'] as List<int>),
      orderId: row['order_id'] as String,
      addSeq: row['add_seq'] as int,
      previousIds: prevStr.isEmpty ? const [] : prevStr.split(','),
      isSnapshot: (row['is_snapshot'] as int) != 0,
      snapshotId: row['snapshot_id'] as String,
      timestamp: row['timestamp'] as int,
    );
  }
}

/// SQLite-backed sync state store.
class SqliteSyncStateStore implements SyncStateStore {
  final Database _db;
  SqliteSyncStateStore(this._db);

  @override
  Future<void> setLastSyncedOrder(
    String peerId, String treeId, String orderId,
  ) async {
    _db.execute(
      'INSERT OR REPLACE INTO sync_state_order (peer_id, tree_id, order_id) '
      'VALUES (?, ?, ?)',
      [peerId, treeId, orderId],
    );
  }

  @override
  Future<String?> getLastSyncedOrder(String peerId, String treeId) async {
    final result = _db.select(
      'SELECT order_id FROM sync_state_order '
      'WHERE peer_id = ? AND tree_id = ?',
      [peerId, treeId],
    );
    if (result.isEmpty) return null;
    return result.first['order_id'] as String;
  }

  @override
  Future<void> setLastSyncedSeq(
    String peerId, String treeId, int seq,
  ) async {
    _db.execute(
      'INSERT OR REPLACE INTO sync_state_seq (peer_id, tree_id, seq) '
      'VALUES (?, ?, ?)',
      [peerId, treeId, seq],
    );
  }

  @override
  Future<int> getLastSyncedSeq(String peerId, String treeId) async {
    final result = _db.select(
      'SELECT seq FROM sync_state_seq WHERE peer_id = ? AND tree_id = ?',
      [peerId, treeId],
    );
    if (result.isEmpty) return 0;
    return result.first['seq'] as int;
  }

  @override
  Future<void> clearPeer(String peerId) async {
    _db.execute(
      'DELETE FROM sync_state_order WHERE peer_id = ?', [peerId],
    );
    _db.execute(
      'DELETE FROM sync_state_seq WHERE peer_id = ?', [peerId],
    );
  }
}

/// SQLite-backed file store.
class SqliteFileStore implements FileStore {
  final Database _db;
  SqliteFileStore(this._db);

  @override
  Future<void> saveFile(String hash, Uint8List data) async {
    _db.execute(
      'INSERT OR REPLACE INTO files (hash, data, size) VALUES (?, ?, ?)',
      [hash, data, data.length],
    );
  }

  @override
  Future<Uint8List?> loadFile(String hash) async {
    final result = _db.select(
      'SELECT data FROM files WHERE hash = ?', [hash],
    );
    if (result.isEmpty) return null;
    final blob = result.first['data'];
    if (blob is Uint8List) return blob;
    if (blob is List<int>) return Uint8List.fromList(blob);
    return null;
  }

  @override
  Future<bool> hasFile(String hash) async {
    final result = _db.select(
      'SELECT 1 FROM files WHERE hash = ? LIMIT 1', [hash],
    );
    return result.isNotEmpty;
  }

  @override
  Future<void> deleteFile(String hash) async {
    _db.execute('DELETE FROM files WHERE hash = ?', [hash]);
  }

  @override
  Future<int> usageBytes() async {
    final result = _db.select('SELECT COALESCE(SUM(size), 0) as total FROM files');
    return result.first['total'] as int;
  }
}

/// Object index for fast lookups without loading full snapshots.
class ObjectIndex {
  final Database _db;
  ObjectIndex(this._db);

  /// Updates the index entry for an object.
  void updateIndex({
    required String objectId,
    required String name,
    String typeId = '',
    String iconEmoji = '',
    bool isArchived = false,
    bool isFavorite = false,
    int blockCount = 0,
  }) {
    _db.execute(
      'INSERT OR REPLACE INTO object_index '
      '(object_id, name, type_id, icon_emoji, is_archived, is_favorite, '
      'block_count, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        objectId, name, typeId, iconEmoji,
        isArchived ? 1 : 0, isFavorite ? 1 : 0,
        blockCount,
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ],
    );
  }

  /// Searches the index by name (case-insensitive prefix/contains).
  List<Map<String, dynamic>> search(String query) {
    final result = _db.select(
      'SELECT * FROM object_index WHERE name LIKE ? '
      'ORDER BY updated_at DESC LIMIT 100',
      ['%$query%'],
    );
    return result.map((r) => {
      'objectId': r['object_id'] as String,
      'name': r['name'] as String,
      'typeId': r['type_id'] as String,
      'iconEmoji': r['icon_emoji'] as String,
      'isArchived': (r['is_archived'] as int) != 0,
      'isFavorite': (r['is_favorite'] as int) != 0,
      'blockCount': r['block_count'] as int,
    }).toList();
  }

  /// Lists all non-archived objects sorted by last update.
  List<Map<String, dynamic>> listRecent({int limit = 50}) {
    final result = _db.select(
      'SELECT * FROM object_index WHERE is_archived = 0 '
      'ORDER BY updated_at DESC LIMIT ?',
      [limit],
    );
    return result.map((r) => {
      'objectId': r['object_id'] as String,
      'name': r['name'] as String,
      'typeId': r['type_id'] as String,
      'iconEmoji': r['icon_emoji'] as String,
      'isFavorite': (r['is_favorite'] as int) != 0,
      'blockCount': r['block_count'] as int,
    }).toList();
  }
}

/// Complete SQLite-backed storage service.
class SqliteStorageService implements StorageService {
  final String dbPath;
  late Database _db;
  late SqliteObjectStore _objects;
  late SqliteChangeStore _changes;
  late SqliteSyncStateStore _syncState;
  late SqliteFileStore _files;
  late ObjectIndex _index;

  SqliteStorageService({required this.dbPath});

  /// In-memory variant for testing.
  SqliteStorageService.inMemory() : dbPath = ':memory:';

  @override
  ObjectStore get objects => _objects;
  @override
  ChangeStore get changes => _changes;
  @override
  SyncStateStore get syncState => _syncState;
  @override
  FileStore get files => _files;

  /// The object index for fast lookups.
  ObjectIndex get index => _index;

  @override
  Future<void> initialize() async {
    _db = dbPath == ':memory:'
        ? sqlite3.openInMemory()
        : sqlite3.open(dbPath);

    // Enable WAL mode for better concurrent read/write
    _db.execute('PRAGMA journal_mode=WAL');
    _db.execute('PRAGMA foreign_keys=ON');

    // Create schema
    _db.execute(_createSchema);

    // Check/set version
    final vResult = _db.select('SELECT version FROM schema_version LIMIT 1');
    if (vResult.isEmpty) {
      _db.execute(
        'INSERT INTO schema_version (version) VALUES (?)',
        [_schemaVersion],
      );
    }

    _objects = SqliteObjectStore(_db);
    _changes = SqliteChangeStore(_db);
    _syncState = SqliteSyncStateStore(_db);
    _files = SqliteFileStore(_db);
    _index = ObjectIndex(_db);
  }

  @override
  Future<void> close() async {
    _db.dispose();
  }
}
