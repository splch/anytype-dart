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

/// Block editor engine.
///
/// Applies user operations to an [AnyObject], mutating the in-memory
/// state and producing serialized operation payloads suitable for
/// adding to the CRDT [ObjectTree].
library;

import 'dart:typed_data';

import 'package:uuid/uuid.dart';

import '../crdt/object_tree.dart';
import '../model/any_object.dart';
import '../model/block.dart';
import 'operation.dart';

const _uuid = Uuid();

/// Edits an [AnyObject] and produces CRDT changes.
///
/// The editor is the bridge between the UI layer and the CRDT engine.
/// Each method:
///   1. Validates the operation
///   2. Applies it to the in-memory [AnyObject]
///   3. Serializes the operation
///   4. Adds it as a change to the [ObjectTree]
class BlockEditor {
  final AnyObject object;
  final ObjectTree tree;

  BlockEditor({required this.object, required this.tree});

  /// Inserts a new text block.
  ///
  /// Returns the new block's ID.
  Future<String> insertText({
    required String parentId,
    String? afterId,
    String text = '',
    TextStyle style = TextStyle.paragraph,
  }) async {
    final block = Block.text(text: text, style: style);
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Inserts a heading block.
  Future<String> insertHeading({
    required String parentId,
    String? afterId,
    required int level,
    String text = '',
  }) async {
    final block = Block.heading(level, text: text);
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Inserts a divider block.
  Future<String> insertDivider({
    required String parentId,
    String? afterId,
  }) async {
    final block = Block.divider();
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Inserts a link-to-object block.
  Future<String> insertLink({
    required String parentId,
    String? afterId,
    required String targetObjectId,
  }) async {
    final block = Block.link(targetObjectId: targetObjectId);
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Inserts a file/image block.
  Future<String> insertFile({
    required String parentId,
    String? afterId,
    String hash = '',
    String name = '',
    FileType fileType = FileType.file,
  }) async {
    final block = Block.file(hash: hash, name: name, fileType: fileType);
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Inserts a bookmark block.
  Future<String> insertBookmark({
    required String parentId,
    String? afterId,
    required String url,
  }) async {
    final block = Block.bookmark(url: url);
    await _applyAndCommit(
      AddBlockOp(block: block, parentId: parentId, afterId: afterId),
    );
    return block.id;
  }

  /// Deletes a block and all its children.
  Future<void> deleteBlock(String blockId) async {
    await _applyAndCommit(RemoveBlockOp(blockId: blockId));
  }

  /// Moves a block to a new position.
  Future<void> moveBlock(
    String blockId, {
    required String newParentId,
    String? afterId,
  }) async {
    await _applyAndCommit(
      MoveBlockOp(
        blockId: blockId,
        newParentId: newParentId,
        afterId: afterId,
      ),
    );
  }

  /// Sets the text of a text block.
  Future<void> setText(String blockId, String text) async {
    await _applyAndCommit(SetTextOp(blockId: blockId, text: text));
  }

  /// Changes the style of a text block.
  Future<void> setStyle(String blockId, TextStyle style) async {
    await _applyAndCommit(SetStyleOp(blockId: blockId, style: style));
  }

  /// Sets marks (formatting) on a text block.
  Future<void> setMarks(String blockId, List<Mark> marks) async {
    await _applyAndCommit(SetMarksOp(blockId: blockId, marks: marks));
  }

  /// Toggles a checkbox.
  Future<void> setChecked(String blockId, bool checked) async {
    await _applyAndCommit(SetCheckedOp(blockId: blockId, checked: checked));
  }

  /// Sets a relation value on the object.
  Future<void> setRelation(String key, dynamic value) async {
    await _applyAndCommit(SetRelationOp(key: key, value: value));
  }

  /// Removes a relation from the object.
  Future<void> removeRelation(String key) async {
    await _applyAndCommit(RemoveRelationOp(key: key));
  }

  /// Sets object details (name, icon, etc.).
  Future<void> setDetails(Map<String, dynamic> details) async {
    await _applyAndCommit(SetDetailsOp(details: details));
  }

  /// Duplicates a block, inserting the copy after the original.
  Future<String> duplicateBlock(String blockId) async {
    final newId = _uuid.v4();
    await _applyAndCommit(
      DuplicateBlockOp(sourceBlockId: blockId, newBlockId: newId),
    );
    return newId;
  }

  // --- Internal ---

  /// Applies an operation to the object and commits as a CRDT change.
  Future<void> _applyAndCommit(BlockOp op) async {
    _apply(op);
    final payload = op.serialize();
    await tree.addContent(SignableContent(
      data: payload,
      timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      dataType: 'block',
    ));
  }

  /// Applies an operation to the in-memory object (no CRDT commit).
  void _apply(BlockOp op) {
    switch (op) {
      case AddBlockOp():
        object.addBlock(op.block, parentId: op.parentId, afterId: op.afterId);

      case RemoveBlockOp():
        object.removeBlock(op.blockId);

      case MoveBlockOp():
        object.moveBlock(
          op.blockId,
          newParentId: op.newParentId,
          afterId: op.afterId,
        );

      case SetTextOp():
        final block = object.getBlock(op.blockId);
        if (block?.textContent != null) {
          block!.textContent!.text = op.text;
        }

      case SetStyleOp():
        final block = object.getBlock(op.blockId);
        if (block?.textContent != null) {
          block!.textContent!.style = op.style;
        }

      case SetMarksOp():
        final block = object.getBlock(op.blockId);
        if (block?.textContent != null) {
          block!.textContent!.marks = op.marks;
        }

      case SetCheckedOp():
        final block = object.getBlock(op.blockId);
        if (block?.textContent != null) {
          block!.textContent!.checked = op.checked;
        }

      case SetRelationOp():
        object.setRelation(op.key, op.value);

      case RemoveRelationOp():
        object.removeRelation(op.key);

      case SetDetailsOp():
        for (final entry in op.details.entries) {
          object.setRelation(entry.key, entry.value);
        }

      case DuplicateBlockOp():
        final source = object.getBlock(op.sourceBlockId);
        if (source == null) return;
        final parentId = object.parentOf(op.sourceBlockId);
        if (parentId == null) return;

        final copy = Block(
          id: op.newBlockId,
          type: source.type,
          textContent: source.textContent,
          fileContent: source.fileContent,
          bookmarkContent: source.bookmarkContent,
          linkContent: source.linkContent,
          layoutStyle: source.layoutStyle,
          relationKey: source.relationKey,
          backgroundColor: source.backgroundColor,
          align: source.align,
        );
        object.addBlock(copy, parentId: parentId, afterId: op.sourceBlockId);

      case SetFieldsOp():
        final block = object.getBlock(op.blockId);
        if (block == null) return;
        for (final entry in op.fields.entries) {
          switch (entry.key) {
            case 'backgroundColor':
              block.backgroundColor = entry.value as String?;
            case 'align':
              block.align = entry.value as String?;
            case 'verticalAlign':
              block.verticalAlign = entry.value as String?;
          }
        }
    }
  }

  /// Replays an operation from a CRDT change payload (for building
  /// state from the change tree).
  void replay(Uint8List payload) {
    final op = BlockOp.deserialize(payload);
    _apply(op);
  }
}
