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

/// Merkle DAG tree with change tracking, merge, and ordering.
///
/// Implements the core CRDT data structure from the any-sync protocol.
/// Changes form a DAG and are merged using topological sort with
/// lexicographic tie-breaking for deterministic ordering.
library;

import 'change.dart';
import 'lexid.dart';

/// Result of adding changes to the tree.
enum TreeAddMode {
  /// Tree was rebuilt from scratch (new snapshot or first addition).
  rebuild,

  /// Changes were appended incrementally.
  append,

  /// No new changes were added (all duplicates).
  nothing,
}

/// Result of an add operation on the tree.
class TreeAddResult {
  /// The heads before the operation.
  final List<String> oldHeads;

  /// The heads after the operation.
  final List<String> newHeads;

  /// Changes that were actually added (excludes duplicates).
  final List<Change> added;

  /// How the tree was modified.
  final TreeAddMode mode;

  const TreeAddResult({
    required this.oldHeads,
    required this.newHeads,
    required this.added,
    required this.mode,
  });
}

/// A Merkle DAG of changes with dependency tracking and deterministic merge.
///
/// Changes are tracked in two maps:
/// - [attached]: changes with all dependencies satisfied
/// - [unAttached]: changes waiting for dependencies
///
/// The [waitList] tracks which unattached changes depend on which
/// missing change IDs, enabling cascade attachment when dependencies arrive.
class Tree {
  /// Changes with all dependencies satisfied, keyed by ID.
  final Map<String, Change> attached = {};

  /// Changes waiting for dependencies, keyed by ID.
  final Map<String, Change> unAttached = {};

  /// Maps a missing change ID to the IDs of changes waiting for it.
  final Map<String, List<String>> waitList = {};

  /// The root change (first snapshot).
  Change? root;

  /// Current head IDs (DAG leaves), kept sorted.
  List<String> headIds = [];

  /// Temporary buffer for tracking all changes added during an add() call.
  final List<Change> _addedBuf = [];

  /// ID of the last head after iteration (for OrderId generation).
  String lastIteratedHeadId = '';

  /// The lexid generator for ordering.
  final LexId lexId;

  /// Changes that might serve as new roots during reduction.
  final List<Change> possibleRoots = [];

  Tree({LexId? lexId}) : lexId = lexId ?? defaultLexId;

  /// Number of attached changes.
  int get length => attached.length;

  /// The root change ID, or empty string if no root.
  String get rootId => root?.id ?? '';

  /// Whether the tree is empty.
  bool get isEmpty => root == null;

  /// Gets an attached change by ID.
  Change? getChange(String id) => attached[id];

  /// Whether a change ID exists in the attached set.
  bool hasChange(String id) => attached.containsKey(id);

  /// Whether all given IDs exist in the attached set.
  bool hasChanges(List<String> ids) => ids.every(attached.containsKey);

  /// Sets the root change and adds it to attached.
  void setRoot(Change change) {
    root = change;
    attached[change.id] = change;
    if (change.orderId.isEmpty) {
      change.orderId = lexId.first();
    }
    _updateHeadIds();
  }

  /// Adds a single pre-validated change that merges all current heads.
  ///
  /// Used for locally-created changes where the caller guarantees
  /// the change's previousIds match the current heads.
  void addMergedHead(Change change) {
    _attach(change);
    // Assign OrderId after the last iterated head
    if (lastIteratedHeadId.isNotEmpty) {
      final lastHead = attached[lastIteratedHeadId];
      if (lastHead != null) {
        change.orderId = lexId.next(lastHead.orderId);
      }
    } else if (change.orderId.isEmpty) {
      change.orderId = lexId.next(root?.orderId ?? '');
    }
    _updateHeadIds();
  }

  /// Adds changes from a peer, resolving dependencies.
  ///
  /// Returns the result indicating what was added and how.
  TreeAddResult add(List<Change> changes) {
    final oldHeads = List<String>.from(headIds);
    _addedBuf.clear();

    for (final change in changes) {
      // Skip duplicates
      if (attached.containsKey(change.id) ||
          unAttached.containsKey(change.id)) {
        continue;
      }

      // Sort previousIds for determinism (matches Go: tree.go line 232)
      if (change.previousIds.length > 1) {
        change.previousIds.sort();
      }

      final canAttach = _canAttach(change, addToWaitList: true);
      if (canAttach) {
        _attach(change);
      } else {
        unAttached[change.id] = change;
      }
    }

    final added = List<Change>.from(_addedBuf);

    if (added.isEmpty) {
      return TreeAddResult(
        oldHeads: oldHeads,
        newHeads: headIds,
        added: const [],
        mode: TreeAddMode.nothing,
      );
    }

    _updateHeadIds();

    final mode = oldHeads.isEmpty ? TreeAddMode.rebuild : TreeAddMode.append;
    return TreeAddResult(
      oldHeads: oldHeads,
      newHeads: List<String>.from(headIds),
      added: added,
      mode: mode,
    );
  }

  /// Checks if all dependencies of a change are attached.
  bool _canAttach(Change change, {required bool addToWaitList}) {
    for (final prevId in change.previousIds) {
      if (!attached.containsKey(prevId)) {
        if (addToWaitList) {
          waitList.putIfAbsent(prevId, () => []).add(change.id);
        }
        return false;
      }
    }
    // Also check that the snapshot base is attached
    if (change.snapshotId.isNotEmpty &&
        !attached.containsKey(change.snapshotId)) {
      return false;
    }
    return true;
  }

  /// Attaches a change and cascades to any waiting changes.
  void _attach(Change change) {
    attached[change.id] = change;
    unAttached.remove(change.id);
    _addedBuf.add(change);

    // Update snapshot counter if not explicitly set
    if (change.snapshotCounter == 0 && change.snapshotId.isNotEmpty) {
      final snapshot = attached[change.snapshotId];
      if (snapshot != null) {
        change.snapshotCounter = snapshot.snapshotCounter + 1;
      }
    }

    // Connect graph edges
    for (final prevId in change.previousIds) {
      final prev = attached[prevId];
      if (prev != null) {
        change.previous.add(prev);
        prev.addNext(change);
      }
    }

    // Cascade: check if any waiting changes can now be attached
    final waiting = waitList.remove(change.id);
    if (waiting != null) {
      for (final waitingId in waiting) {
        final waitingChange = unAttached[waitingId];
        if (waitingChange != null && _canAttach(waitingChange, addToWaitList: false)) {
          _attach(waitingChange);
        }
      }
    }
  }

  /// Recomputes head IDs and assigns OrderIds via topological sort.
  void _updateHeadIds() {
    if (root == null) return;

    // Topological sort
    final sorted = topologicalSort(root!);

    // Assign OrderIds, filling gaps
    _assignOrderIds(sorted);

    // Identify heads (leaves with no dependents)
    final newHeads = <String>[];
    for (final change in sorted) {
      if (change.next.isEmpty) {
        newHeads.add(change.id);
      }
    }
    newHeads.sort();
    headIds = newHeads;
    if (headIds.isNotEmpty) {
      lastIteratedHeadId = headIds.last;
    }
  }

  /// Assigns OrderIds to all changes in topologically sorted order.
  ///
  /// Preserves existing OrderIds and fills gaps using lexid.
  void _assignOrderIds(List<Change> sorted) {
    if (sorted.isEmpty) return;

    // Find changes with existing OrderIds (anchors)
    // Iterate backwards through sorted buffer
    var lastAnchorIdx = sorted.length - 1;

    // Root should always have an OrderId
    if (sorted.last.orderId.isEmpty) {
      sorted.last.orderId = lexId.first();
    }

    for (var idx = sorted.length - 1; idx >= 0; idx--) {
      if (sorted[idx].orderId.isNotEmpty) {
        // Fill gaps between this anchor and the previous one
        if (lastAnchorIdx - idx > 1) {
          _fillOrderIdGap(sorted, idx, lastAnchorIdx);
        }
        lastAnchorIdx = idx;
      }
    }

    // Fill remaining changes before the first anchor
    if (lastAnchorIdx > 0) {
      var prev = sorted[lastAnchorIdx].orderId;
      for (var i = lastAnchorIdx - 1; i >= 0; i--) {
        if (sorted[i].orderId.isEmpty) {
          sorted[i].orderId = lexId.next(prev);
          prev = sorted[i].orderId;
        }
      }
    }
  }

  /// Fills OrderId gaps between two anchors using nextBefore.
  void _fillOrderIdGap(List<Change> sorted, int fromIdx, int toIdx) {
    var prev = sorted[toIdx].orderId;
    final before = sorted[fromIdx].orderId;
    for (var i = toIdx - 1; i > fromIdx; i--) {
      if (sorted[i].orderId.isEmpty) {
        sorted[i].orderId = lexId.nextBefore(prev, before);
        prev = sorted[i].orderId;
      }
    }
  }

  /// Reduces the tree by finding the common snapshot among all heads
  /// and removing everything before it.
  ///
  /// Returns true if reduction occurred.
  bool reduce() {
    if (root == null || headIds.isEmpty) return false;

    final firstHead = attached[headIds.first];
    if (firstHead == null) return false;

    // Case 1: Single head that is a snapshot → make it root
    if (firstHead.isSnapshot && headIds.length == 1) {
      _makeRoot(firstHead);
      return true;
    }

    // Case 2: Multiple heads — find common snapshot ancestor
    if (possibleRoots.isEmpty) return false;

    // Build snapshot path from first head to root
    final path = <Change>[];
    var current = attached[firstHead.snapshotId];
    while (current != null && current.id != root!.id) {
      current.visited = true;
      path.add(current);
      current = attached[current.snapshotId];
    }
    if (root != null) {
      root!.visited = true;
      path.add(root!);
    }

    // Find the deepest snapshot that all heads share
    var maxIdx = 0;
    for (var i = 1; i < headIds.length; i++) {
      final head = attached[headIds[i]];
      if (head == null) continue;

      var snapshot = attached[head.snapshotId];
      while (snapshot != null && !snapshot.visited) {
        snapshot = attached[snapshot.snapshotId];
      }
      if (snapshot != null) {
        final idx = path.indexWhere((c) => c.id == snapshot!.id);
        if (idx > maxIdx) maxIdx = idx;
      }
    }

    // Reset visited flags
    for (final c in path) {
      c.visited = false;
    }

    if (maxIdx < path.length) {
      _makeRoot(path[maxIdx]);
      return true;
    }

    return false;
  }

  /// Makes [newRoot] the tree root, removing all ancestors.
  void _makeRoot(Change newRoot) {
    if (newRoot.id == root?.id) return;

    // Collect all changes before the new root
    final toRemove = <String>{};
    final stack = List<Change>.from(newRoot.previous);
    while (stack.isNotEmpty) {
      final c = stack.removeLast();
      if (toRemove.add(c.id)) {
        stack.addAll(c.previous);
      }
    }

    // Remove old changes
    for (final id in toRemove) {
      attached.remove(id);
    }

    // Clear previous references from new root
    newRoot.previous.clear();
    root = newRoot;

    // Clear unattached since they may reference removed changes
    unAttached.clear();
    waitList.clear();
    possibleRoots.clear();
  }
}

/// Performs a topological sort of the DAG starting from [root].
///
/// Returns changes in order from heads (most recent) to root.
/// Uses iterative DFS with a two-pass visit pattern.
List<Change> topologicalSort(Change root) {
  final result = <Change>[];
  final stack = <Change>[root];

  // Reset traversal flags
  _resetFlags(root);

  while (stack.isNotEmpty) {
    final change = stack.removeLast();

    if (change.branchesFinished) {
      // Second visit: all dependents processed
      result.add(change);
      change.branchesFinished = false;
      continue;
    }

    if (change.visited) continue;

    // First visit: mark and schedule second visit
    change.visited = true;
    change.branchesFinished = true;
    stack.add(change); // Push again for post-order processing

    // Push all dependents
    for (final next in change.next) {
      if (!next.visited) {
        stack.add(next);
      }
    }
  }

  // Reset visited flags for future traversals
  for (final c in result) {
    c.visited = false;
  }

  return result;
}

/// Resets traversal flags on all reachable changes.
void _resetFlags(Change root) {
  final stack = <Change>[root];
  final visited = <String>{};

  while (stack.isNotEmpty) {
    final c = stack.removeLast();
    if (visited.add(c.id)) {
      c.resetTraversalFlags();
      stack.addAll(c.next);
    }
  }
}
