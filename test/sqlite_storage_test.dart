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

import 'package:anytype_dart/src/storage/sqlite_storage.dart';
import 'package:anytype_dart/src/storage/storage.dart';

void main() {
  late SqliteStorageService service;

  setUp(() async {
    service = SqliteStorageService.inMemory();
    await service.initialize();
  });

  tearDown(() async {
    await service.close();
  });

  group('SqliteObjectStore', () {
    test('save and load snapshot', () async {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      await service.objects.saveSnapshot('obj1', data);
      final loaded = await service.objects.loadSnapshot('obj1');
      expect(loaded, equals(data));
    });

    test('load missing returns null', () async {
      expect(await service.objects.loadSnapshot('missing'), isNull);
    });

    test('overwrite snapshot', () async {
      await service.objects.saveSnapshot('obj1', Uint8List.fromList([1]));
      await service.objects.saveSnapshot('obj1', Uint8List.fromList([2]));
      final loaded = await service.objects.loadSnapshot('obj1');
      expect(loaded, equals(Uint8List.fromList([2])));
    });

    test('delete snapshot', () async {
      await service.objects.saveSnapshot('obj1', Uint8List(1));
      await service.objects.deleteSnapshot('obj1');
      expect(await service.objects.loadSnapshot('obj1'), isNull);
    });

    test('list object IDs', () async {
      await service.objects.saveSnapshot('a', Uint8List(1));
      await service.objects.saveSnapshot('b', Uint8List(1));
      final ids = await service.objects.listObjectIds();
      expect(ids, containsAll(['a', 'b']));
    });
  });

  group('SqliteChangeStore', () {
    test('save and load change', () async {
      final change = StoredChange(
        treeId: 't1',
        id: 'c1',
        rawData: Uint8List.fromList([10, 20]),
        orderId: '0001',
      );
      await service.changes.saveChange(change);
      final loaded = await service.changes.loadChange('t1', 'c1');
      expect(loaded, isNotNull);
      expect(loaded!.id, 'c1');
      expect(loaded.rawData, equals(Uint8List.fromList([10, 20])));
      expect(loaded.orderId, '0001');
    });

    test('loadTree sorted by addSeq', () async {
      for (var i = 0; i < 5; i++) {
        await service.changes.saveChange(StoredChange(
          treeId: 't1', id: 'c$i', rawData: Uint8List(1),
        ));
      }
      final changes = await service.changes.loadTree('t1');
      expect(changes.length, 5);
      for (var i = 1; i < changes.length; i++) {
        expect(changes[i].addSeq, greaterThan(changes[i - 1].addSeq));
      }
    });

    test('loadAfterOrder', () async {
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1), orderId: '0001',
      ));
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c2', rawData: Uint8List(1), orderId: '0002',
      ));
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c3', rawData: Uint8List(1), orderId: '0003',
      ));

      final after = await service.changes.loadAfterOrder('t1', '0001');
      expect(after.length, 2);
      expect(after.first.orderId, '0002');
    });

    test('loadAfterSeq', () async {
      final seq1 = await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c2', rawData: Uint8List(1),
      ));

      final after = await service.changes.loadAfterSeq('t1', seq1);
      expect(after.length, 1);
      expect(after.first.id, 'c2');
    });

    test('heads roundtrip', () async {
      await service.changes.saveHeads('t1', ['h1', 'h2']);
      expect(await service.changes.loadHeads('t1'), ['h1', 'h2']);
    });

    test('hasChange', () async {
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      expect(await service.changes.hasChange('t1', 'c1'), isTrue);
      expect(await service.changes.hasChange('t1', 'c2'), isFalse);
    });

    test('deleteTree', () async {
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List(1),
      ));
      await service.changes.saveHeads('t1', ['c1']);
      await service.changes.deleteTree('t1');
      expect(await service.changes.loadTree('t1'), isEmpty);
      expect(await service.changes.loadHeads('t1'), isEmpty);
    });

    test('duplicate change ignored', () async {
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List.fromList([1]),
      ));
      // Same tree+change ID → INSERT OR IGNORE
      await service.changes.saveChange(StoredChange(
        treeId: 't1', id: 'c1', rawData: Uint8List.fromList([2]),
      ));
      final loaded = await service.changes.loadChange('t1', 'c1');
      // Original data preserved
      expect(loaded!.rawData, equals(Uint8List.fromList([1])));
    });
  });

  group('SqliteSyncStateStore', () {
    test('order state', () async {
      await service.syncState.setLastSyncedOrder('p1', 't1', '005');
      expect(await service.syncState.getLastSyncedOrder('p1', 't1'), '005');
    });

    test('seq state', () async {
      await service.syncState.setLastSyncedSeq('p1', 't1', 42);
      expect(await service.syncState.getLastSyncedSeq('p1', 't1'), 42);
    });

    test('clearPeer', () async {
      await service.syncState.setLastSyncedOrder('p1', 't1', 'a');
      await service.syncState.setLastSyncedOrder('p2', 't1', 'b');
      await service.syncState.clearPeer('p1');
      expect(await service.syncState.getLastSyncedOrder('p1', 't1'), isNull);
      expect(await service.syncState.getLastSyncedOrder('p2', 't1'), 'b');
    });
  });

  group('SqliteFileStore', () {
    test('save and load', () async {
      await service.files.saveFile('h1', Uint8List.fromList([1, 2, 3]));
      expect(await service.files.loadFile('h1'), equals(Uint8List.fromList([1, 2, 3])));
    });

    test('usageBytes', () async {
      await service.files.saveFile('h1', Uint8List(100));
      await service.files.saveFile('h2', Uint8List(200));
      expect(await service.files.usageBytes(), 300);
    });
  });

  group('ObjectIndex', () {
    test('search by name', () {
      service.index.updateIndex(
        objectId: 'o1', name: 'Meeting Notes', typeId: 'ot-page',
      );
      service.index.updateIndex(
        objectId: 'o2', name: 'Shopping List', typeId: 'ot-note',
      );
      service.index.updateIndex(
        objectId: 'o3', name: 'Meeting Agenda', typeId: 'ot-page',
      );

      final results = service.index.search('meeting');
      expect(results.length, 2);
      expect(
        results.map((r) => r['objectId']),
        containsAll(['o1', 'o3']),
      );
    });

    test('listRecent excludes archived', () {
      service.index.updateIndex(objectId: 'o1', name: 'Active');
      service.index.updateIndex(
        objectId: 'o2', name: 'Archived', isArchived: true,
      );

      final recent = service.index.listRecent();
      expect(recent.length, 1);
      expect(recent.first['name'], 'Active');
    });
  });
}
