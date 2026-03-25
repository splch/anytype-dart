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

import 'package:anytype_dart/src/crdt/change_builder.dart' show RawChange;
import 'package:anytype_dart/src/storage/memory_storage.dart';
import 'package:anytype_dart/src/storage/storage.dart';
import 'package:anytype_dart/src/sync/sync_state.dart';
import 'package:anytype_dart/src/sync/sync_client.dart';

void main() {
  group('SyncStateMachine', () {
    late SyncStateMachine sm;

    setUp(() {
      sm = SyncStateMachine();
    });

    test('starts disconnected', () {
      expect(sm.status, SyncStatus.disconnected);
    });

    test('full connection flow', () {
      final transitions = <(SyncStatus, SyncStatus)>[];
      sm.onTransition = (old, next) => transitions.add((old, next));

      expect(sm.processEvent(SyncEvent.connect), isTrue);
      expect(sm.status, SyncStatus.connecting);

      expect(sm.processEvent(SyncEvent.connectionEstablished), isTrue);
      expect(sm.status, SyncStatus.handshake);

      expect(sm.processEvent(SyncEvent.handshakeComplete), isTrue);
      expect(sm.status, SyncStatus.syncing);

      expect(sm.processEvent(SyncEvent.syncComplete), isTrue);
      expect(sm.status, SyncStatus.idle);

      expect(transitions.length, 4);
    });

    test('idle to receiving and back', () {
      sm.forceState(SyncStatus.idle);

      expect(sm.processEvent(SyncEvent.incomingChanges), isTrue);
      expect(sm.status, SyncStatus.receiving);

      expect(sm.processEvent(SyncEvent.transferComplete), isTrue);
      expect(sm.status, SyncStatus.idle);
    });

    test('idle to sending and back', () {
      sm.forceState(SyncStatus.idle);

      expect(sm.processEvent(SyncEvent.outgoingChanges), isTrue);
      expect(sm.status, SyncStatus.sending);

      expect(sm.processEvent(SyncEvent.transferComplete), isTrue);
      expect(sm.status, SyncStatus.idle);
    });

    test('error triggers reconnecting', () {
      sm.forceState(SyncStatus.syncing);
      expect(sm.processEvent(SyncEvent.error), isTrue);
      expect(sm.status, SyncStatus.reconnecting);

      expect(sm.processEvent(SyncEvent.reconnectTimeout), isTrue);
      expect(sm.status, SyncStatus.connecting);
    });

    test('disconnect from any state', () {
      sm.forceState(SyncStatus.syncing);
      expect(sm.processEvent(SyncEvent.disconnected), isTrue);
      expect(sm.status, SyncStatus.disconnected);
    });

    test('invalid transition returns false', () {
      expect(sm.processEvent(SyncEvent.syncComplete), isFalse);
      expect(sm.status, SyncStatus.disconnected);
    });
  });

  group('SyncClient', () {
    late MemoryStorageService storage;
    late SyncClient client;

    setUp(() async {
      storage = MemoryStorageService();
      await storage.initialize();
      client = SyncClient(storage: storage);
    });

    test('handle head update stores changes', () async {
      await storage.changes.saveHeads('obj1', ['h1']);

      final update = HeadUpdate(
        objectId: 'obj1',
        heads: ['h2'],
        changes: [
          RawChange(rawData: Uint8List.fromList([1, 2, 3]), id: 'c1'),
        ],
      );

      final matched = await client.handleHeadUpdate('peer1', update);
      // Heads don't match (we have h1, peer has h2)
      expect(matched, isFalse);

      // But the change was stored
      expect(await storage.changes.hasChange('obj1', 'c1'), isTrue);
    });

    test('handle head update detects matching heads', () async {
      await storage.changes.saveHeads('obj1', ['h1']);

      final update = HeadUpdate(
        objectId: 'obj1',
        heads: ['h1'],
        changes: [],
      );

      final matched = await client.handleHeadUpdate('peer1', update);
      expect(matched, isTrue);
    });

    test('handle full sync response stores all changes', () async {
      final response = FullSyncResponse(
        objectId: 'obj1',
        heads: ['h3'],
        changes: [
          RawChange(rawData: Uint8List.fromList([1]), id: 'c1'),
          RawChange(rawData: Uint8List.fromList([2]), id: 'c2'),
          RawChange(rawData: Uint8List.fromList([3]), id: 'c3'),
        ],
      );

      await client.handleFullSyncResponse('peer1', response);

      expect(await storage.changes.hasChange('obj1', 'c1'), isTrue);
      expect(await storage.changes.hasChange('obj1', 'c2'), isTrue);
      expect(await storage.changes.hasChange('obj1', 'c3'), isTrue);

      final heads = await storage.changes.loadHeads('obj1');
      expect(heads, ['h3']);
    });

    test('handle full sync request returns all changes', () async {
      await storage.changes.saveChange(StoredChange(
        treeId: 'obj1', id: 'c1', rawData: Uint8List.fromList([1]),
      ));
      await storage.changes.saveChange(StoredChange(
        treeId: 'obj1', id: 'c2', rawData: Uint8List.fromList([2]),
      ));
      await storage.changes.saveHeads('obj1', ['c2']);

      final response = await client.handleFullSyncRequest(
        FullSyncRequest(objectId: 'obj1', heads: []),
      );

      expect(response.changes.length, 2);
      expect(response.heads, ['c2']);
    });

    test('prepare head update', () async {
      await storage.changes.saveHeads('obj1', ['h1', 'h2']);

      final update = await client.prepareHeadUpdate('obj1', [
        RawChange(rawData: Uint8List(1), id: 'c3'),
      ]);

      expect(update.objectId, 'obj1');
      expect(update.heads, ['h1', 'h2']);
      expect(update.changes.length, 1);
    });

    test('space subscription', () {
      client.subscribeSpace('space1');
      client.subscribeSpace('space2');
      client.unsubscribeSpace('space1');
      // Just verifying no errors; subscription state is internal
    });
  });
}
