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

import 'package:convert/convert.dart';
import 'package:test/test.dart';

import 'package:anytype_dart/src/crdt/change.dart';
import 'package:anytype_dart/src/crdt/change_builder.dart';
import 'package:anytype_dart/src/crdt/object_tree.dart';
import 'package:anytype_dart/src/crdt/tree.dart';
import 'package:anytype_dart/src/crypto/keys.dart';

/// Creates a simple test change with the given ID and parents.
Change _makeChange(String id, List<String> previousIds, {
  String snapshotId = 'root',
  bool isSnapshot = false,
}) {
  return Change(
    id: id,
    previousIds: previousIds,
    snapshotId: snapshotId,
    isSnapshot: isSnapshot,
  );
}

void main() {
  group('Tree', () {
    group('basic operations', () {
      test('starts empty', () {
        final tree = Tree();
        expect(tree.isEmpty, isTrue);
        expect(tree.length, 0);
      });

      test('setRoot initializes tree', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        expect(tree.isEmpty, isFalse);
        expect(tree.length, 1);
        expect(tree.rootId, 'root');
        expect(tree.headIds, ['root']);
      });

      test('addMergedHead adds to tree', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        final c1 = _makeChange('c1', ['root']);
        tree.addMergedHead(c1);

        expect(tree.length, 2);
        expect(tree.headIds, ['c1']);
        expect(tree.hasChange('c1'), isTrue);
      });
    });

    group('linear chain', () {
      test('builds a linear chain of changes', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        final changes = <Change>[];
        for (var i = 1; i <= 5; i++) {
          final prev = i == 1 ? 'root' : 'c${i - 1}';
          final c = _makeChange('c$i', [prev]);
          tree.addMergedHead(c);
          changes.add(c);
        }

        expect(tree.length, 6); // root + 5 changes
        expect(tree.headIds, ['c5']);
      });

      test('ordering is preserved in linear chain', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        for (var i = 1; i <= 5; i++) {
          final prev = i == 1 ? 'root' : 'c${i - 1}';
          tree.addMergedHead(_makeChange('c$i', [prev]));
        }

        // Verify OrderIds are decreasing (topo sort is head→root)
        final sorted = topologicalSort(root);
        for (var i = 1; i < sorted.length; i++) {
          expect(
            sorted[i].orderId.compareTo(sorted[i - 1].orderId),
            lessThanOrEqualTo(0),
            reason:
                '${sorted[i].id}(${sorted[i].orderId}) <= '
                '${sorted[i - 1].id}(${sorted[i - 1].orderId})',
          );
        }
      });
    });

    group('concurrent edits (forking)', () {
      test('creates multiple heads on fork', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        // Two concurrent changes from root
        final result = tree.add([
          _makeChange('a1', ['root']),
          _makeChange('b1', ['root']),
        ]);

        expect(result.added.length, 2);
        expect(tree.headIds.length, 2);
        expect(tree.headIds, containsAll(['a1', 'b1']));
      });

      test('merge resolves to single head', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        // Fork
        tree.add([
          _makeChange('a1', ['root']),
          _makeChange('b1', ['root']),
        ]);

        // Merge: change that references both heads
        final merge = _makeChange('m1', ['a1', 'b1']);
        tree.addMergedHead(merge);

        expect(tree.headIds, ['m1']);
        expect(tree.length, 4); // root + a1 + b1 + m1
      });
    });

    group('dependency resolution', () {
      test('queues changes with missing dependencies', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        // Add c2 before c1 (c2 depends on c1)
        final result1 = tree.add([_makeChange('c2', ['c1'])]);
        expect(result1.added.length, 0);
        expect(tree.unAttached.length, 1);

        // Now add c1
        final result2 = tree.add([_makeChange('c1', ['root'])]);
        expect(result2.added.length, 2); // c1 + cascaded c2
        expect(tree.unAttached.length, 0);
        expect(tree.headIds, ['c2']);
      });

      test('handles deep dependency chains', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        // Add in reverse order: c5 → c4 → c3 → c2 → c1 → root
        tree.add([_makeChange('c5', ['c4'])]);
        tree.add([_makeChange('c4', ['c3'])]);
        tree.add([_makeChange('c3', ['c2'])]);
        tree.add([_makeChange('c2', ['c1'])]);
        expect(tree.unAttached.length, 4);

        // Adding c1 should cascade all
        tree.add([_makeChange('c1', ['root'])]);
        expect(tree.unAttached.length, 0);
        expect(tree.length, 6);
        expect(tree.headIds, ['c5']);
      });

      test('skips duplicate changes', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        tree.add([_makeChange('c1', ['root'])]);
        final result = tree.add([_makeChange('c1', ['root'])]);
        expect(result.mode, TreeAddMode.nothing);
        expect(tree.length, 2);
      });
    });

    group('topological sort', () {
      test('respects causal order', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        tree.addMergedHead(_makeChange('c1', ['root']));
        tree.addMergedHead(_makeChange('c2', ['c1']));
        tree.addMergedHead(_makeChange('c3', ['c2']));

        final sorted = topologicalSort(root);
        final ids = sorted.map((c) => c.id).toList();

        // Root should come after all others in topo sort (reversed)
        // sorted goes from heads to root
        expect(ids.first, 'c3');
        expect(ids.last, 'root');
      });

      test('deterministic for concurrent changes', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        tree.add([
          _makeChange('a1', ['root']),
          _makeChange('b1', ['root']),
        ]);

        final sorted1 = topologicalSort(root);
        final sorted2 = topologicalSort(root);

        expect(
          sorted1.map((c) => c.id).toList(),
          sorted2.map((c) => c.id).toList(),
        );
      });
    });

    group('OrderId assignment', () {
      test('all changes get OrderIds', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        tree.add([
          _makeChange('a1', ['root']),
          _makeChange('b1', ['root']),
        ]);

        for (final entry in tree.attached.entries) {
          expect(entry.value.orderId, isNotEmpty,
              reason: '${entry.key} should have an OrderId');
        }
      });

      test('OrderIds are lexicographically ordered', () {
        final tree = Tree();
        final root = _makeChange('root', [], snapshotId: 'root', isSnapshot: true);
        tree.setRoot(root);

        tree.addMergedHead(_makeChange('c1', ['root']));
        tree.addMergedHead(_makeChange('c2', ['c1']));
        tree.addMergedHead(_makeChange('c3', ['c2']));

        expect(
          root.orderId.compareTo(tree.getChange('c1')!.orderId),
          lessThan(0),
        );
        expect(
          tree.getChange('c1')!.orderId
              .compareTo(tree.getChange('c2')!.orderId),
          lessThan(0),
        );
        expect(
          tree.getChange('c2')!.orderId
              .compareTo(tree.getChange('c3')!.orderId),
          lessThan(0),
        );
      });
    });
  });

  group('ObjectTree', () {
    late Ed25519SigningKey signingKey;

    setUp(() async {
      signingKey = await Ed25519SigningKey.fromSeed(
        Uint8List.fromList(
          hex.decode(
            '2b4be7f19ee27bbf30c667b642d5f4aa'
            '69fd169872f8fc3059c08ebae2eb19e7',
          ),
        ),
      );
    });

    test('initialize creates root', () async {
      final ot = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );

      final result = await ot.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      expect(ot.isInitialized, isTrue);
      expect(result.added.length, 1);
      expect(result.mode, TreeAddMode.rebuild);
      expect(ot.heads.length, 1);
    });

    test('addContent creates signed change', () async {
      final ot = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );

      await ot.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      final result = await ot.addContent(SignableContent(
        data: Uint8List.fromList([10, 20, 30]),
        timestamp: 1001,
        dataType: 'block',
      ));

      expect(result.added.length, 1);
      expect(result.mode, TreeAddMode.append);
      expect(ot.length, 2);
      expect(ot.heads.length, 1);
    });

    test('multiple changes build a chain', () async {
      final ot = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );

      await ot.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      for (var i = 0; i < 5; i++) {
        await ot.addContent(SignableContent(
          data: Uint8List.fromList([i]),
          timestamp: 1001 + i,
        ));
      }

      expect(ot.length, 6); // root + 5
      expect(ot.heads.length, 1);
    });

    test('iterateFromRoot visits all changes', () async {
      final ot = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );

      await ot.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      for (var i = 0; i < 3; i++) {
        await ot.addContent(SignableContent(
          data: Uint8List.fromList([i]),
          timestamp: 1001 + i,
        ));
      }

      final visited = <String>[];
      ot.iterateFromRoot((change) {
        visited.add(change.id);
        return true;
      });

      expect(visited.length, 4); // root + 3
    });

    test('snapshotPath returns path', () async {
      final ot = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );

      await ot.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      final path = ot.snapshotPath();
      expect(path.length, 1);
      expect(path.first, ot.id);
    });
  });

  group('ChangeBuilder', () {
    late Ed25519SigningKey signingKey;

    setUp(() async {
      signingKey = await Ed25519SigningKey.fromSeed(
        Uint8List.fromList(
          hex.decode(
            '2b4be7f19ee27bbf30c667b642d5f4aa'
            '69fd169872f8fc3059c08ebae2eb19e7',
          ),
        ),
      );
    });

    test('build and verify roundtrip', () async {
      final (raw, change) = await ChangeBuilder.build(ChangeContent(
        treeHeadIds: ['head1'],
        aclHeadId: 'acl0',
        snapshotBaseId: 'snap0',
        signingKey: signingKey,
        content: Uint8List.fromList([1, 2, 3]),
        timestamp: 1000,
      ));

      expect(raw.id, isNotEmpty);
      expect(change.id, raw.id);

      final valid = await ChangeBuilder.verify(raw);
      expect(valid, isTrue);
    });

    test('build root and verify', () async {
      final (raw, change) = await ChangeBuilder.buildRoot(RootChangeContent(
        aclHeadId: 'acl0',
        signingKey: signingKey,
        spaceId: 'space1',
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      ));

      expect(raw.id, isNotEmpty);
      expect(change.isSnapshot, isTrue);

      final valid = await ChangeBuilder.verify(raw);
      expect(valid, isTrue);
    });

    test('unmarshal recovers change fields', () async {
      final (raw, _) = await ChangeBuilder.build(ChangeContent(
        treeHeadIds: ['head1', 'head2'],
        aclHeadId: 'acl0',
        snapshotBaseId: 'snap0',
        signingKey: signingKey,
        content: Uint8List.fromList([10, 20, 30]),
        timestamp: 42000,
        dataType: 'test',
      ));

      final restored = await ChangeBuilder.unmarshal(raw);
      expect(restored.id, raw.id);
      expect(restored.previousIds, ['head1', 'head2']);
      expect(restored.aclHeadId, 'acl0');
      expect(restored.snapshotId, 'snap0');
      expect(restored.timestamp, 42000);
      expect(restored.dataType, 'test');
      expect(restored.data, Uint8List.fromList([10, 20, 30]));
    });

    test('tampered change fails verification', () async {
      final (raw, _) = await ChangeBuilder.build(ChangeContent(
        treeHeadIds: ['head1'],
        aclHeadId: 'acl0',
        snapshotBaseId: 'snap0',
        signingKey: signingKey,
        content: Uint8List.fromList([1, 2, 3]),
        timestamp: 1000,
      ));

      // Tamper with the raw data
      final tampered = Uint8List.fromList(raw.rawData);
      tampered[10] ^= 0xFF;
      final tamperedRaw = RawChange(rawData: tampered, id: raw.id);

      final valid = await ChangeBuilder.verify(tamperedRaw);
      expect(valid, isFalse);
    });
  });
}
