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

/// Change node in the Merkle DAG.
///
/// Each change represents an operation (or snapshot) in the CRDT tree.
/// Changes form a Directed Acyclic Graph where edges represent
/// causal dependencies.
library;

import 'dart:typed_data';

/// A single change in the Merkle DAG.
///
/// Changes are content-addressed: the [id] is a CID computed from
/// the serialized and signed change data.
class Change {
  // --- Graph structure ---

  /// Content-addressable identifier (CID of signed payload).
  final String id;

  /// IDs of parent changes in the DAG (causal dependencies).
  final List<String> previousIds;

  /// Forward pointers to changes that depend on this one.
  /// Populated during tree attachment, sorted by ID for determinism.
  final List<Change> next = [];

  /// Backward pointers to parent changes.
  /// Populated during tree attachment.
  final List<Change> previous = [];

  // --- Snapshot management ---

  /// ID of the snapshot this change is based on.
  String snapshotId;

  /// Depth in the snapshot tree (0 for first snapshot, increments).
  int snapshotCounter;

  /// Whether this change contains a complete state snapshot.
  final bool isSnapshot;

  // --- Content ---

  /// The change payload (decrypted). Application-defined format.
  final Uint8List? data;

  /// Semantic type of the change data (application-defined).
  final String dataType;

  /// Deserialized model (lazily populated by application layer).
  Object? model;

  // --- Ordering ---

  /// Lexicographic ordering ID assigned during tree merge.
  /// Provides total ordering that respects topological dependencies.
  String orderId;

  /// Space-global monotonic sequence number from storage.
  /// Used for incremental sync.
  int addSeq;

  /// Unix timestamp of change creation.
  final int timestamp;

  // --- Cryptographic identity ---

  /// Ed25519 signature over the serialized payload.
  final Uint8List? signature;

  /// Raw public key bytes of the change creator.
  final Uint8List? identity;

  /// ACL record ID that was current when this change was created.
  final String aclHeadId;

  /// Symmetric encryption key ID (if data is encrypted).
  final String readKeyId;

  // --- Flags ---

  /// Whether this is a derived tree change (no signature required).
  final bool isDerived;

  /// For derived trees, reference to parent object.
  final String parentId;

  // --- Iteration helpers (mutable, used during tree operations) ---

  /// Marks this change as visited during traversal.
  bool visited = false;

  /// Marks that all branches from this change have been processed.
  bool branchesFinished = false;

  Change({
    required this.id,
    required this.previousIds,
    this.snapshotId = '',
    this.snapshotCounter = 0,
    this.isSnapshot = false,
    this.data,
    this.dataType = '',
    this.orderId = '',
    this.addSeq = 0,
    this.timestamp = 0,
    this.signature,
    this.identity,
    this.aclHeadId = '',
    this.readKeyId = '',
    this.isDerived = false,
    this.parentId = '',
  });

  /// Inserts [child] into [next] maintaining sorted order by ID.
  void addNext(Change child) {
    if (next.isEmpty || next.last.id.compareTo(child.id) <= 0) {
      next.add(child);
    } else {
      // Binary search for insertion point
      var lo = 0;
      var hi = next.length;
      while (lo < hi) {
        final mid = (lo + hi) ~/ 2;
        if (next[mid].id.compareTo(child.id) <= 0) {
          lo = mid + 1;
        } else {
          hi = mid;
        }
      }
      next.insert(lo, child);
    }
  }

  /// Whether this change has no dependents (is a DAG leaf / tree head).
  bool get isHead => next.isEmpty;

  /// Resets traversal flags for reuse.
  void resetTraversalFlags() {
    visited = false;
    branchesFinished = false;
  }

  @override
  String toString() => 'Change($id)';
}
