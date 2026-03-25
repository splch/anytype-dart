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

/// Conflict detection for divergent CRDT tree heads.
///
/// When an object's tree has multiple heads, it means concurrent edits
/// occurred that haven't been merged yet. The conflict detector
/// identifies these cases and provides information for UI indicators.
library;

import '../crdt/change.dart';
import '../crdt/tree.dart';

/// Severity of a detected conflict.
enum ConflictSeverity {
  /// No conflict — single head.
  none,

  /// Soft conflict — multiple heads from the same identity.
  /// Auto-mergeable; UI shows a subtle indicator.
  soft,

  /// Hard conflict — multiple heads from different identities.
  /// Requires user attention; UI shows a warning.
  hard,
}

/// A detected conflict on an object.
class ConflictInfo {
  /// The object/tree ID.
  final String treeId;

  /// Current head IDs (more than one means conflict).
  final List<String> heads;

  /// Severity of the conflict.
  final ConflictSeverity severity;

  /// Identities involved in the divergent edits.
  final Set<String> involvedIdentities;

  /// When the conflict was first detected.
  final DateTime detectedAt;

  const ConflictInfo({
    required this.treeId,
    required this.heads,
    required this.severity,
    this.involvedIdentities = const {},
    required this.detectedAt,
  });

  bool get hasConflict => heads.length > 1;
}

/// Detects conflicts across object trees.
class ConflictDetector {
  /// Checks a single tree for conflicts.
  ConflictInfo checkTree(Tree tree) {
    final heads = tree.headIds;

    if (heads.length <= 1) {
      return ConflictInfo(
        treeId: tree.rootId,
        heads: heads,
        severity: ConflictSeverity.none,
        detectedAt: DateTime.now(),
      );
    }

    // Determine severity by checking if heads come from different identities
    final identities = <String>{};
    for (final headId in heads) {
      final change = tree.getChange(headId);
      if (change?.identity != null) {
        identities.add(_bytesToHex(change!.identity!));
      }
    }

    final severity = identities.length > 1
        ? ConflictSeverity.hard
        : ConflictSeverity.soft;

    return ConflictInfo(
      treeId: tree.rootId,
      heads: heads,
      severity: severity,
      involvedIdentities: identities,
      detectedAt: DateTime.now(),
    );
  }

  /// Checks multiple trees and returns only those with conflicts.
  List<ConflictInfo> checkAll(Iterable<Tree> trees) {
    return trees
        .map(checkTree)
        .where((c) => c.hasConflict)
        .toList();
  }
}

String _bytesToHex(List<int> bytes) {
  const hexChars = '0123456789abcdef';
  final buf = StringBuffer();
  for (final b in bytes) {
    buf.write(hexChars[b >> 4]);
    buf.write(hexChars[b & 0x0F]);
  }
  return buf.toString();
}
