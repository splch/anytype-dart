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

import 'package:anytype_dart/src/storage/storage.dart';
import 'package:anytype_dart/src/storage/memory_storage.dart';

void main() {
  group('MemoryObjectStore', () {
    late MemoryObjectStore store;

    setUp(() {
      store = MemoryObjectStore();
    });

    test('save and load snapshot', () async {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      await store.saveSnapshot('obj1', data);

      final loaded = await store.loadSnapshot('obj1');
      expect(loaded, equals(data));
    });

    test('load missing returns null', () async {
      expect(await store.loadSnapshot('missing'), isNull);
    });

    test('delete snapshot', () async {
      await store.saveSnapshot('obj1', Uint8List.fromList([1]));
      await store.deleteSnapshot('obj1');
      expect(await store.loadSnapshot('obj1'), isNull);
    });

    test('list object IDs', () async {
      await store.saveSnapshot('a', Uint8List(1));
      await store.saveSnapshot('b', Uint8List(1));
      await store.saveSnapshot('c', Uint8List(1));

      final ids = await store.listObjectIds();
      expect(ids, containsAll(['a', 'b', 'c']));
    });
  });

  group('MemoryChangeStore', () {
    late MemoryChangeStore store;

    setUp(() {
      store = MemoryChangeStore();
    });

    test('save and load change', () async {
      final change = StoredChange(
        treeId: 'tree1',
        id: 'c1',
        rawData: Uint8List.fromList([10, 20]),
        orderId: '0001',
      );
      await store.saveChange(change);

      final loaded = await store.loadChange('tree1', 'c1');
      expect(loaded, isNotNull);
      expect(loaded!.id, 'c1');
      expect(loaded.rawData, equals(Uint8List.fromList([10, 20])));
    });

    test('assigns monotonic addSeq', () async {
      final seq1 = await store.saveChange(StoredChange(
        treeId: 'tree1',
        id: 'c1',
        rawData: Uint8List(1),
      ));
      final seq2 = await store.saveChange(StoredChange(
        treeId: 'tree1',
        id: 'c2',
        rawData: Uint8List(1),
      ));
      expect(seq2, greaterThan(seq1));
    });

    test('loadTree returns all changes sorted by addSeq', () async {
      for (var i = 0; i < 5; i++) {
        await store.saveChange(StoredChange(
          treeId: 'tree1',
          id: 'c$i',
          rawData: Uint8List(1),
        ));
      }

      final changes = await store.loadTree('tree1');
      expect(changes.length, 5);
      for (var i = 1; i < changes.length; i++) {
        expect(changes[i].addSeq, greaterThan(changes[i - 1].addSeq));
      }
    });

    test('loadAfterOrder filters by orderId', () async {
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1), orderId: '0001',
      ));
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c2', rawData: Uint8List(1), orderId: '0002',
      ));
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c3', rawData: Uint8List(1), orderId: '0003',
      ));

      final after = await store.loadAfterOrder('t1', '0001');
      expect(after.length, 2);
      expect(after.first.orderId, '0002');
    });

    test('loadAfterSeq filters by addSeq', () async {
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      final seq = await store.saveChange(StoredChange(
        treeId: 't1', id: 'c2', rawData: Uint8List(1),
      ));
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c3', rawData: Uint8List(1),
      ));

      final after = await store.loadAfterSeq('t1', seq);
      expect(after.length, 1);
      expect(after.first.id, 'c3');
    });

    test('save and load heads', () async {
      await store.saveHeads('t1', ['h1', 'h2']);
      final heads = await store.loadHeads('t1');
      expect(heads, ['h1', 'h2']);
    });

    test('hasChange', () async {
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      expect(await store.hasChange('t1', 'c1'), isTrue);
      expect(await store.hasChange('t1', 'c2'), isFalse);
    });

    test('deleteTree', () async {
      await store.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      await store.saveHeads('t1', ['c1']);
      await store.deleteTree('t1');

      expect(await store.loadTree('t1'), isEmpty);
      expect(await store.loadHeads('t1'), isEmpty);
    });
  });

  group('MemorySyncStateStore', () {
    late MemorySyncStateStore store;

    setUp(() {
      store = MemorySyncStateStore();
    });

    test('set and get order', () async {
      await store.setLastSyncedOrder('peer1', 'tree1', '0005');
      expect(await store.getLastSyncedOrder('peer1', 'tree1'), '0005');
    });

    test('set and get seq', () async {
      await store.setLastSyncedSeq('peer1', 'tree1', 42);
      expect(await store.getLastSyncedSeq('peer1', 'tree1'), 42);
    });

    test('missing returns null/0', () async {
      expect(await store.getLastSyncedOrder('x', 'y'), isNull);
      expect(await store.getLastSyncedSeq('x', 'y'), 0);
    });

    test('clearPeer', () async {
      await store.setLastSyncedOrder('peer1', 't1', 'a');
      await store.setLastSyncedOrder('peer1', 't2', 'b');
      await store.setLastSyncedOrder('peer2', 't1', 'c');

      await store.clearPeer('peer1');

      expect(await store.getLastSyncedOrder('peer1', 't1'), isNull);
      expect(await store.getLastSyncedOrder('peer1', 't2'), isNull);
      expect(await store.getLastSyncedOrder('peer2', 't1'), 'c');
    });
  });

  group('MemoryFileStore', () {
    late MemoryFileStore store;

    setUp(() {
      store = MemoryFileStore();
    });

    test('save and load file', () async {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      await store.saveFile('hash1', data);
      expect(await store.loadFile('hash1'), equals(data));
    });

    test('hasFile', () async {
      await store.saveFile('h1', Uint8List(1));
      expect(await store.hasFile('h1'), isTrue);
      expect(await store.hasFile('h2'), isFalse);
    });

    test('usageBytes', () async {
      await store.saveFile('h1', Uint8List(100));
      await store.saveFile('h2', Uint8List(200));
      expect(await store.usageBytes(), 300);
    });

    test('deleteFile', () async {
      await store.saveFile('h1', Uint8List(100));
      await store.deleteFile('h1');
      expect(await store.hasFile('h1'), isFalse);
      expect(await store.usageBytes(), 0);
    });
  });

  group('MemoryStorageService', () {
    test('all stores are accessible', () async {
      final service = MemoryStorageService();
      await service.initialize();

      expect(service.objects, isA<ObjectStore>());
      expect(service.changes, isA<ChangeStore>());
      expect(service.syncState, isA<SyncStateStore>());
      expect(service.files, isA<FileStore>());

      await service.close();
    });
  });
}
