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

/// High-level CRDT object tree API.
///
/// Wraps the low-level [Tree] with change building, signing,
/// snapshot management, and iteration support.
library;

import 'dart:typed_data';

import '../crypto/aes_gcm.dart';
import '../crypto/keys.dart';
import 'change.dart';
import 'change_builder.dart';
import 'tree.dart';

/// Content to add to an object tree.
class SignableContent {
  /// The raw change payload (application-defined).
  final Uint8List data;

  /// Whether this is a complete state snapshot.
  final bool isSnapshot;

  /// Semantic data type tag.
  final String dataType;

  /// Creation timestamp (Unix seconds).
  final int timestamp;

  const SignableContent({
    required this.data,
    this.isSnapshot = false,
    this.dataType = '',
    required this.timestamp,
  });
}

/// Payload of raw changes from a peer.
class RawChangesPayload {
  /// The claimed new head IDs.
  final List<String> newHeads;

  /// The raw serialized changes.
  final List<RawChange> rawChanges;

  /// Snapshot path for context.
  final List<String> snapshotPath;

  const RawChangesPayload({
    required this.newHeads,
    required this.rawChanges,
    this.snapshotPath = const [],
  });
}

/// Result of adding content or raw changes.
class AddResult {
  final List<String> oldHeads;
  final List<String> newHeads;
  final List<Change> added;
  final TreeAddMode mode;

  const AddResult({
    required this.oldHeads,
    required this.newHeads,
    required this.added,
    required this.mode,
  });
}

/// A CRDT object tree backed by a Merkle DAG of signed changes.
///
/// Provides the primary API for:
/// - Adding local changes (signed with the user's key)
/// - Adding remote changes from peers (verified)
/// - Iterating changes in deterministic order
/// - Computing snapshot paths for sync
class ObjectTree {
  final Tree _tree;

  /// The signing key for this user.
  final Ed25519SigningKey _signingKey;

  /// The current ACL head ID.
  String _aclHeadId;

  /// Optional encryption key for change payloads.
  final AesKey? _readKey;

  /// The read key ID (empty if unencrypted).
  final String _readKeyId;

  /// The space this tree belongs to.
  final String spaceId;

  ObjectTree({
    required Ed25519SigningKey signingKey,
    required String aclHeadId,
    AesKey? readKey,
    String readKeyId = '',
    required this.spaceId,
    Tree? tree,
  })  : _signingKey = signingKey,
        _aclHeadId = aclHeadId,
        _readKey = readKey,
        _readKeyId = readKeyId,
        _tree = tree ?? Tree();

  /// The underlying tree.
  Tree get tree => _tree;

  /// The tree ID (root change ID).
  String get id => _tree.rootId;

  /// Current head IDs.
  List<String> get heads => List.unmodifiable(_tree.headIds);

  /// The root change.
  Change? get root => _tree.root;

  /// Number of changes in the tree.
  int get length => _tree.length;

  /// Whether the tree has been initialized.
  bool get isInitialized => _tree.root != null;

  /// Updates the ACL head ID.
  set aclHeadId(String value) => _aclHeadId = value;

  /// Initializes the tree with a root change.
  ///
  /// Must be called before adding content.
  Future<AddResult> initialize({
    required Uint8List seed,
    required String changeType,
    Uint8List? changePayload,
    required int timestamp,
  }) async {
    if (isInitialized) {
      throw StateError('Tree is already initialized');
    }

    final (raw, change) = await ChangeBuilder.buildRoot(
      RootChangeContent(
        aclHeadId: _aclHeadId,
        signingKey: _signingKey,
        spaceId: spaceId,
        seed: seed,
        changeType: changeType,
        changePayload: changePayload,
        timestamp: timestamp,
      ),
    );

    // Set as root
    change.snapshotId = change.id;
    _tree.setRoot(change);

    return AddResult(
      oldHeads: const [],
      newHeads: [change.id],
      added: [change],
      mode: TreeAddMode.rebuild,
    );
  }

  /// Adds content as a new change, signed with the user's key.
  ///
  /// The change's previousIds are set to the current tree heads,
  /// creating a merge point if there were multiple heads.
  Future<AddResult> addContent(SignableContent content) async {
    if (!isInitialized) {
      throw StateError('Tree must be initialized before adding content');
    }

    final (raw, change) = await ChangeBuilder.build(
      ChangeContent(
        treeHeadIds: _tree.headIds,
        aclHeadId: _aclHeadId,
        snapshotBaseId: _tree.rootId,
        readKeyId: _readKeyId,
        isSnapshot: content.isSnapshot,
        signingKey: _signingKey,
        readKey: _readKey,
        content: content.data,
        timestamp: content.timestamp,
        dataType: content.dataType,
      ),
    );

    change.snapshotId = _tree.rootId;

    final oldHeads = List<String>.from(_tree.headIds);

    if (content.isSnapshot) {
      change.snapshotCounter = (_tree.root?.snapshotCounter ?? 0) + 1;
    }

    _tree.addMergedHead(change);

    return AddResult(
      oldHeads: oldHeads,
      newHeads: List<String>.from(_tree.headIds),
      added: [change],
      mode: content.isSnapshot ? TreeAddMode.rebuild : TreeAddMode.append,
    );
  }

  /// Adds raw changes from a peer.
  ///
  /// Changes are verified (CID + signature) and then added to the tree.
  /// Dependencies are tracked automatically — changes with missing
  /// parents are queued until their dependencies arrive.
  Future<AddResult> addRawChanges(RawChangesPayload payload) async {
    final changes = <Change>[];
    for (final raw in payload.rawChanges) {
      final change = await ChangeBuilder.unmarshal(
        raw,
        verify: true,
        readKey: _readKey,
      );
      changes.add(change);
    }

    final result = _tree.add(changes);

    return AddResult(
      oldHeads: result.oldHeads,
      newHeads: result.newHeads,
      added: result.added,
      mode: result.mode,
    );
  }

  /// Computes the snapshot path from the current root back through
  /// all snapshots to the origin.
  List<String> snapshotPath() {
    final path = <String>[];
    var currentId = _tree.rootId;

    while (currentId.isNotEmpty) {
      path.add(currentId);
      final change = _tree.getChange(currentId);
      if (change == null) break;
      final nextId = change.snapshotId;
      if (nextId == currentId) break; // Self-referencing root
      currentId = nextId;
    }

    return path;
  }

  /// Iterates all changes from root in deterministic order.
  ///
  /// The [visitor] is called for each change. If it returns false,
  /// iteration stops.
  void iterateFromRoot(bool Function(Change) visitor) {
    if (_tree.root == null) return;
    final sorted = topologicalSort(_tree.root!);
    // Iterate from root (end of sorted list) to heads (start)
    for (var i = sorted.length - 1; i >= 0; i--) {
      if (!visitor(sorted[i])) break;
    }
  }

  /// Iterates changes starting from a given change ID.
  void iterateFrom(String id, bool Function(Change) visitor) {
    final start = _tree.getChange(id);
    if (start == null) return;
    final sorted = topologicalSort(start);
    for (var i = sorted.length - 1; i >= 0; i--) {
      if (!visitor(sorted[i])) break;
    }
  }

  /// Gets a specific change by ID.
  Change? getChange(String id) => _tree.getChange(id);

  /// Whether the tree contains changes with the given IDs.
  bool hasChanges(List<String> ids) => _tree.hasChanges(ids);

  /// Attempts to reduce the tree by removing old history.
  bool reduce() => _tree.reduce();
}
