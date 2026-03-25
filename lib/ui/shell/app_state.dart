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

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../src/crypto/keys.dart';
import '../../src/editor/block_editor.dart';
import '../../src/crdt/object_tree.dart';
import '../../src/model/any_object.dart';
import '../../src/model/block.dart';
import '../../src/model/object_type.dart';
import '../../src/model/space.dart';
import '../../src/storage/memory_storage.dart';
import '../../src/storage/storage.dart';

/// Top-level application state exposed via Provider.
class AppState extends ChangeNotifier {
  final StorageService storage;
  Ed25519SigningKey? _signingKey;

  Space? _currentSpace;
  final Map<String, AnyObject> _objects = {};
  final Map<String, ObjectTree> _trees = {};
  String? _selectedObjectId;
  bool _initialized = false;

  AppState({StorageService? storage})
      : storage = storage ?? MemoryStorageService();

  bool get initialized => _initialized;
  Space? get currentSpace => _currentSpace;
  Ed25519SigningKey? get signingKey => _signingKey;

  List<AnyObject> get objects => _objects.values.toList();
  AnyObject? get selectedObject =>
      _selectedObjectId != null ? _objects[_selectedObjectId] : null;
  String? get selectedObjectId => _selectedObjectId;

  /// Initializes the app with a signing key and default space.
  Future<void> initialize(Ed25519SigningKey key) async {
    _signingKey = key;
    await storage.initialize();

    _currentSpace = Space(
      id: 'default',
      name: 'My Space',
      isPersonal: true,
    );
    _currentSpace!.addType(SystemTypes.page);
    _currentSpace!.addType(SystemTypes.note);
    _currentSpace!.addType(SystemTypes.task);

    _initialized = true;
    notifyListeners();
  }

  /// Creates a new object of the given type.
  Future<AnyObject> createObject({
    String name = 'Untitled',
    String typeId = 'ot-page',
  }) async {
    final tree = ObjectTree(
      signingKey: _signingKey!,
      aclHeadId: 'acl0',
      spaceId: _currentSpace?.id ?? 'default',
    );

    await tree.initialize(
      seed: Uint8List.fromList(
        List.generate(16, (i) => DateTime.now().microsecond + i),
      ),
      changeType: typeId,
      timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    final obj = AnyObject(id: tree.id, typeId: typeId);
    obj.name = name;

    // Add a default empty paragraph
    obj.addBlock(
      Block.text(text: ''),
      parentId: obj.rootBlockId,
    );

    _objects[obj.id] = obj;
    _trees[obj.id] = tree;
    _currentSpace?.addObject(obj.id);

    // Save snapshot
    await storage.objects.saveSnapshot(
      obj.id,
      Uint8List.fromList(utf8.encode(json.encode(obj.toMap()))),
    );

    notifyListeners();
    return obj;
  }

  /// Selects an object for editing.
  void selectObject(String? objectId) {
    _selectedObjectId = objectId;
    notifyListeners();
  }

  /// Gets a BlockEditor for the selected object.
  BlockEditor? editorForObject(String objectId) {
    final obj = _objects[objectId];
    final tree = _trees[objectId];
    if (obj == null || tree == null) return null;
    return BlockEditor(object: obj, tree: tree);
  }

  /// Deletes an object.
  Future<void> deleteObject(String objectId) async {
    _objects.remove(objectId);
    _trees.remove(objectId);
    _currentSpace?.removeObject(objectId);
    await storage.objects.deleteSnapshot(objectId);
    if (_selectedObjectId == objectId) {
      _selectedObjectId = null;
    }
    notifyListeners();
  }

  /// Saves the current state of an object.
  Future<void> saveObject(String objectId) async {
    final obj = _objects[objectId];
    if (obj == null) return;
    await storage.objects.saveSnapshot(
      objectId,
      Uint8List.fromList(utf8.encode(json.encode(obj.toMap()))),
    );
  }
}
