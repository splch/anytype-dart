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

import 'package:anytype_dart/src/model/any_object.dart';
import 'package:anytype_dart/src/model/block.dart';
import 'package:anytype_dart/src/model/object_type.dart';
import 'package:anytype_dart/src/model/relation.dart';
import 'package:anytype_dart/src/model/space.dart';
import 'package:anytype_dart/src/editor/block_editor.dart';
import 'package:anytype_dart/src/editor/operation.dart';
import 'package:anytype_dart/src/crdt/object_tree.dart';
import 'package:anytype_dart/src/crypto/keys.dart';

void main() {
  group('Block', () {
    test('creates text block', () {
      final block = Block.text(text: 'Hello', style: TextStyle.paragraph);
      expect(block.type, BlockType.text);
      expect(block.textContent?.text, 'Hello');
      expect(block.id, isNotEmpty);
    });

    test('creates heading block', () {
      final block = Block.heading(2, text: 'Title');
      expect(block.textContent?.style, TextStyle.header2);
      expect(block.textContent?.text, 'Title');
    });

    test('creates divider block', () {
      final block = Block.divider();
      expect(block.type, BlockType.divider);
    });

    test('creates link block', () {
      final block = Block.link(targetObjectId: 'obj123');
      expect(block.type, BlockType.link);
      expect(block.linkContent?.targetObjectId, 'obj123');
    });

    test('creates file block', () {
      final block = Block.file(
        hash: 'abc',
        name: 'photo.jpg',
        fileType: FileType.image,
      );
      expect(block.type, BlockType.file);
      expect(block.fileContent?.hash, 'abc');
      expect(block.fileContent?.fileType, FileType.image);
    });

    test('serialization roundtrip', () {
      final block = Block.text(
        id: 'b1',
        text: 'Hello **world**',
        style: TextStyle.header1,
        marks: [Mark(type: MarkType.bold, from: 6, to: 15)],
      );

      final map = block.toMap();
      final restored = Block.fromMap(map);

      expect(restored.id, 'b1');
      expect(restored.textContent?.text, 'Hello **world**');
      expect(restored.textContent?.style, TextStyle.header1);
      expect(restored.textContent?.marks.length, 1);
      expect(restored.textContent?.marks.first.type, MarkType.bold);
    });
  });

  group('AnyObject', () {
    test('creates with root block', () {
      final obj = AnyObject(id: 'obj1');
      expect(obj.rootBlock, isNotNull);
      expect(obj.contentBlockIds, isEmpty);
    });

    test('add and remove blocks', () {
      final obj = AnyObject(id: 'obj1');
      final block = Block.text(id: 'b1', text: 'First paragraph');
      obj.addBlock(block, parentId: obj.rootBlockId);

      expect(obj.contentBlockIds, ['b1']);
      expect(obj.getBlock('b1')?.textContent?.text, 'First paragraph');

      obj.removeBlock('b1');
      expect(obj.contentBlockIds, isEmpty);
      expect(obj.getBlock('b1'), isNull);
    });

    test('insert after specific block', () {
      final obj = AnyObject(id: 'obj1');
      obj.addBlock(Block.text(id: 'b1', text: 'A'), parentId: obj.rootBlockId);
      obj.addBlock(Block.text(id: 'b3', text: 'C'), parentId: obj.rootBlockId);
      obj.addBlock(
        Block.text(id: 'b2', text: 'B'),
        parentId: obj.rootBlockId,
        afterId: 'b1',
      );

      expect(obj.contentBlockIds, ['b1', 'b2', 'b3']);
    });

    test('move block', () {
      final obj = AnyObject(id: 'obj1');
      obj.addBlock(
        Block.layout(id: 'layout1', style: LayoutStyle.row),
        parentId: obj.rootBlockId,
      );
      obj.addBlock(Block.text(id: 'b1', text: 'A'), parentId: obj.rootBlockId);

      obj.moveBlock('b1', newParentId: 'layout1');

      expect(obj.contentBlockIds, ['layout1']);
      expect(obj.getBlock('layout1')?.childIds, ['b1']);
    });

    test('relations', () {
      final obj = AnyObject(id: 'obj1');
      obj.setRelation('name', 'My Page');
      obj.setRelation('status', 'Done');

      expect(obj.name, 'My Page');
      expect(obj.getRelation('status'), 'Done');

      obj.removeRelation('status');
      expect(obj.getRelation('status'), isNull);
    });

    test('serialization roundtrip', () {
      final obj = AnyObject(id: 'obj1', typeId: 'ot-page');
      obj.addBlock(Block.text(id: 'b1', text: 'Hello'), parentId: obj.rootBlockId);
      obj.setRelation('name', 'Test');

      final map = obj.toMap();
      final restored = AnyObject.fromMap(map);

      expect(restored.id, 'obj1');
      expect(restored.typeId, 'ot-page');
      expect(restored.contentBlockIds, ['b1']);
      expect(restored.getBlock('b1')?.textContent?.text, 'Hello');
      expect(restored.name, 'Test');
    });
  });

  group('Space', () {
    test('manages objects and types', () {
      final space = Space(id: 'space1', name: 'My Space');
      space.addType(SystemTypes.page);
      space.addObject('obj1');
      space.addObject('obj2');

      expect(space.objectIds, containsAll(['obj1', 'obj2']));
      expect(space.getType('ot-page')?.name, 'Page');
    });
  });

  group('Operation serialization', () {
    test('AddBlockOp roundtrip', () {
      final op = AddBlockOp(
        block: Block.text(id: 'b1', text: 'Hi'),
        parentId: 'root',
        afterId: 'b0',
      );

      final data = op.serialize();
      final restored = BlockOp.deserialize(data) as AddBlockOp;

      expect(restored.block.id, 'b1');
      expect(restored.parentId, 'root');
      expect(restored.afterId, 'b0');
    });

    test('SetTextOp roundtrip', () {
      final op = SetTextOp(blockId: 'b1', text: 'Updated text');
      final data = op.serialize();
      final restored = BlockOp.deserialize(data) as SetTextOp;

      expect(restored.blockId, 'b1');
      expect(restored.text, 'Updated text');
    });

    test('SetRelationOp roundtrip', () {
      final op = SetRelationOp(key: 'status', value: 'Done');
      final data = op.serialize();
      final restored = BlockOp.deserialize(data) as SetRelationOp;

      expect(restored.key, 'status');
      expect(restored.value, 'Done');
    });
  });

  group('BlockEditor', () {
    late Ed25519SigningKey signingKey;

    setUp(() async {
      signingKey = await Ed25519SigningKey.fromSeed(
        Uint8List.fromList(hex.decode(
          '2b4be7f19ee27bbf30c667b642d5f4aa'
          '69fd169872f8fc3059c08ebae2eb19e7',
        )),
      );
    });

    Future<(BlockEditor, AnyObject)> _createEditor() async {
      final tree = ObjectTree(
        signingKey: signingKey,
        aclHeadId: 'acl0',
        spaceId: 'space1',
      );
      await tree.initialize(
        seed: Uint8List.fromList([1, 2, 3, 4]),
        changeType: 'document',
        timestamp: 1000,
      );

      final obj = AnyObject(id: tree.id);
      return (BlockEditor(object: obj, tree: tree), obj);
    }

    test('insert text block', () async {
      final (editor, obj) = await _createEditor();

      final blockId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'Hello world',
      );

      expect(obj.contentBlockIds, [blockId]);
      expect(obj.getBlock(blockId)?.textContent?.text, 'Hello world');
      expect(editor.tree.length, 2); // root + insert
    });

    test('insert and delete block', () async {
      final (editor, obj) = await _createEditor();

      final blockId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'Temporary',
      );
      expect(obj.contentBlockIds.length, 1);

      await editor.deleteBlock(blockId);
      expect(obj.contentBlockIds, isEmpty);
      expect(editor.tree.length, 3); // root + insert + delete
    });

    test('edit text', () async {
      final (editor, obj) = await _createEditor();

      final blockId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'Draft',
      );
      await editor.setText(blockId, 'Final version');

      expect(obj.getBlock(blockId)?.textContent?.text, 'Final version');
      expect(editor.tree.length, 3);
    });

    test('change block style', () async {
      final (editor, obj) = await _createEditor();

      final blockId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'My Title',
      );
      await editor.setStyle(blockId, TextStyle.header1);

      expect(
        obj.getBlock(blockId)?.textContent?.style,
        TextStyle.header1,
      );
    });

    test('set and remove relation', () async {
      final (editor, obj) = await _createEditor();

      await editor.setRelation('status', 'In Progress');
      expect(obj.getRelation('status'), 'In Progress');

      await editor.removeRelation('status');
      expect(obj.getRelation('status'), isNull);
    });

    test('set details', () async {
      final (editor, obj) = await _createEditor();

      await editor.setDetails({'name': 'My Page', 'iconEmoji': '\u{1F4DD}'});
      expect(obj.name, 'My Page');
      expect(obj.iconEmoji, '\u{1F4DD}');
    });

    test('move block between parents', () async {
      final (editor, obj) = await _createEditor();

      final layoutId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: '',
      );
      // Change it to a layout via raw block manipulation
      final textId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'Move me',
      );

      await editor.moveBlock(textId, newParentId: layoutId);

      expect(obj.getBlock(layoutId)?.childIds, [textId]);
    });

    test('multiple edits produce change chain', () async {
      final (editor, _) = await _createEditor();

      for (var i = 0; i < 5; i++) {
        await editor.insertText(
          parentId: editor.object.rootBlockId,
          text: 'Block $i',
        );
      }

      expect(editor.tree.length, 6); // root + 5 inserts
      expect(editor.tree.heads.length, 1); // single head
      expect(editor.object.contentBlockIds.length, 5);
    });

    test('toggle checkbox', () async {
      final (editor, obj) = await _createEditor();

      final blockId = await editor.insertText(
        parentId: obj.rootBlockId,
        text: 'Task',
        style: TextStyle.checkboxList,
      );
      expect(obj.getBlock(blockId)?.textContent?.checked, isNull);

      await editor.setChecked(blockId, true);
      expect(obj.getBlock(blockId)?.textContent?.checked, isTrue);
    });

    test('replay operations from CRDT tree', () async {
      final (editor, _) = await _createEditor();

      await editor.insertText(
        parentId: editor.object.rootBlockId,
        text: 'Replayed block',
      );
      await editor.setRelation('name', 'Test Object');

      // Build a new object by replaying changes
      final newObj = AnyObject(id: editor.object.id);
      final replayEditor = BlockEditor(object: newObj, tree: editor.tree);

      editor.tree.iterateFromRoot((change) {
        if (change.data != null && change.data!.isNotEmpty) {
          try {
            replayEditor.replay(change.data!);
          } catch (_) {
            // Root change payload is not an operation
          }
        }
        return true;
      });

      expect(newObj.name, 'Test Object');
    });
  });
}
