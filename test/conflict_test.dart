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

import 'dart:typed_data';

import 'package:test/test.dart';

import 'package:anytype_dart/src/crdt/change.dart';
import 'package:anytype_dart/src/crdt/tree.dart';
import 'package:anytype_dart/src/sync/conflict.dart';

Change _makeChange(String id, List<String> prevIds, {
  String snapshotId = 'root',
  Uint8List? identity,
}) {
  return Change(
    id: id,
    previousIds: prevIds,
    snapshotId: snapshotId,
    identity: identity,
  );
}

void main() {
  group('ConflictDetector', () {
    late ConflictDetector detector;

    setUp(() {
      detector = ConflictDetector();
    });

    test('no conflict with single head', () {
      final tree = Tree();
      tree.setRoot(
        _makeChange('root', [], snapshotId: 'root', identity: Uint8List(32)),
      );
      tree.addMergedHead(
        _makeChange('c1', ['root'], identity: Uint8List(32)),
      );

      final info = detector.checkTree(tree);
      expect(info.hasConflict, isFalse);
      expect(info.severity, ConflictSeverity.none);
    });

    test('soft conflict: same identity, multiple heads', () {
      final tree = Tree();
      final identity = Uint8List.fromList(List.generate(32, (i) => 1));
      tree.setRoot(_makeChange('root', [], snapshotId: 'root'));
      tree.add([
        _makeChange('a', ['root'], identity: identity),
        _makeChange('b', ['root'], identity: identity),
      ]);

      final info = detector.checkTree(tree);
      expect(info.hasConflict, isTrue);
      expect(info.severity, ConflictSeverity.soft);
      expect(info.heads.length, 2);
    });

    test('hard conflict: different identities, multiple heads', () {
      final tree = Tree();
      final id1 = Uint8List.fromList(List.generate(32, (i) => 1));
      final id2 = Uint8List.fromList(List.generate(32, (i) => 2));
      tree.setRoot(_makeChange('root', [], snapshotId: 'root'));
      tree.add([
        _makeChange('a', ['root'], identity: id1),
        _makeChange('b', ['root'], identity: id2),
      ]);

      final info = detector.checkTree(tree);
      expect(info.hasConflict, isTrue);
      expect(info.severity, ConflictSeverity.hard);
      expect(info.involvedIdentities.length, 2);
    });

    test('checkAll returns only conflicting trees', () {
      final tree1 = Tree();
      tree1.setRoot(_makeChange('r1', [], snapshotId: 'r1'));
      tree1.addMergedHead(_makeChange('c1', ['r1']));

      final tree2 = Tree();
      tree2.setRoot(_makeChange('r2', [], snapshotId: 'r2'));
      tree2.add([
        _makeChange('a2', ['r2'], snapshotId: 'r2'),
        _makeChange('b2', ['r2'], snapshotId: 'r2'),
      ]);

      final conflicts = detector.checkAll([tree1, tree2]);
      expect(conflicts.length, 1);
      expect(conflicts.first.treeId, 'r2');
    });

    test('conflict resolves after merge', () {
      final tree = Tree();
      tree.setRoot(_makeChange('root', [], snapshotId: 'root'));
      tree.add([
        _makeChange('a', ['root']),
        _makeChange('b', ['root']),
      ]);
      expect(detector.checkTree(tree).hasConflict, isTrue);

      // Merge the two heads
      tree.addMergedHead(_makeChange('m', ['a', 'b']));
      expect(detector.checkTree(tree).hasConflict, isFalse);
    });
  });
}
