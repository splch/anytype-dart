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

/// Block operations that produce CRDT changes.
///
/// Each operation represents a user action on an object. Operations
/// are serialized into change payloads and added to the CRDT tree.
library;

import 'dart:convert';
import 'dart:typed_data';

import '../model/block.dart';

/// The type of a block operation.
enum OpType {
  addBlock,
  removeBlock,
  moveBlock,
  setText,
  setStyle,
  setMarks,
  setChecked,
  setRelation,
  removeRelation,
  setDetails,
  duplicateBlock,
  setFields,
}

/// A single operation on an object.
///
/// Operations are the unit of change — each produces one CRDT
/// change entry when applied through the editor.
sealed class BlockOp {
  OpType get type;

  Map<String, dynamic> toMap();

  Uint8List serialize() =>
      Uint8List.fromList(utf8.encode(json.encode(toMap())));

  static BlockOp deserialize(Uint8List data) {
    final map = json.decode(utf8.decode(data)) as Map<String, dynamic>;
    return fromMap(map);
  }

  static BlockOp fromMap(Map<String, dynamic> map) {
    final type = OpType.values[map['op'] as int];
    return switch (type) {
      OpType.addBlock => AddBlockOp.fromMap(map),
      OpType.removeBlock => RemoveBlockOp.fromMap(map),
      OpType.moveBlock => MoveBlockOp.fromMap(map),
      OpType.setText => SetTextOp.fromMap(map),
      OpType.setStyle => SetStyleOp.fromMap(map),
      OpType.setMarks => SetMarksOp.fromMap(map),
      OpType.setChecked => SetCheckedOp.fromMap(map),
      OpType.setRelation => SetRelationOp.fromMap(map),
      OpType.removeRelation => RemoveRelationOp.fromMap(map),
      OpType.setDetails => SetDetailsOp.fromMap(map),
      OpType.duplicateBlock => DuplicateBlockOp.fromMap(map),
      OpType.setFields => SetFieldsOp.fromMap(map),
    };
  }
}

/// Adds a new block to the object.
class AddBlockOp extends BlockOp {
  @override
  OpType get type => OpType.addBlock;

  final Block block;
  final String parentId;
  final String? afterId;

  AddBlockOp({required this.block, required this.parentId, this.afterId});

  @override
  Map<String, dynamic> toMap() => {
        'op': type.index,
        'block': block.toMap(),
        'parentId': parentId,
        if (afterId != null) 'afterId': afterId,
      };

  factory AddBlockOp.fromMap(Map<String, dynamic> map) => AddBlockOp(
        block: Block.fromMap(map['block'] as Map<String, dynamic>),
        parentId: map['parentId'] as String,
        afterId: map['afterId'] as String?,
      );
}

/// Removes a block from the object.
class RemoveBlockOp extends BlockOp {
  @override
  OpType get type => OpType.removeBlock;

  final String blockId;

  RemoveBlockOp({required this.blockId});

  @override
  Map<String, dynamic> toMap() => {'op': type.index, 'blockId': blockId};

  factory RemoveBlockOp.fromMap(Map<String, dynamic> map) =>
      RemoveBlockOp(blockId: map['blockId'] as String);
}

/// Moves a block to a new position.
class MoveBlockOp extends BlockOp {
  @override
  OpType get type => OpType.moveBlock;

  final String blockId;
  final String newParentId;
  final String? afterId;

  MoveBlockOp({required this.blockId, required this.newParentId, this.afterId});

  @override
  Map<String, dynamic> toMap() => {
        'op': type.index,
        'blockId': blockId,
        'newParentId': newParentId,
        if (afterId != null) 'afterId': afterId,
      };

  factory MoveBlockOp.fromMap(Map<String, dynamic> map) => MoveBlockOp(
        blockId: map['blockId'] as String,
        newParentId: map['newParentId'] as String,
        afterId: map['afterId'] as String?,
      );
}

/// Sets the text content of a text block.
class SetTextOp extends BlockOp {
  @override
  OpType get type => OpType.setText;

  final String blockId;
  final String text;

  SetTextOp({required this.blockId, required this.text});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'blockId': blockId, 'text': text};

  factory SetTextOp.fromMap(Map<String, dynamic> map) => SetTextOp(
        blockId: map['blockId'] as String,
        text: map['text'] as String,
      );
}

/// Changes the style of a text block (e.g., paragraph → heading).
class SetStyleOp extends BlockOp {
  @override
  OpType get type => OpType.setStyle;

  final String blockId;
  final TextStyle style;

  SetStyleOp({required this.blockId, required this.style});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'blockId': blockId, 'style': style.index};

  factory SetStyleOp.fromMap(Map<String, dynamic> map) => SetStyleOp(
        blockId: map['blockId'] as String,
        style: TextStyle.values[map['style'] as int],
      );
}

/// Sets marks (formatting) on a text block.
class SetMarksOp extends BlockOp {
  @override
  OpType get type => OpType.setMarks;

  final String blockId;
  final List<Mark> marks;

  SetMarksOp({required this.blockId, required this.marks});

  @override
  Map<String, dynamic> toMap() => {
        'op': type.index,
        'blockId': blockId,
        'marks': marks.map((m) => m.toMap()).toList(),
      };

  factory SetMarksOp.fromMap(Map<String, dynamic> map) => SetMarksOp(
        blockId: map['blockId'] as String,
        marks: (map['marks'] as List<dynamic>)
            .map((m) => Mark.fromMap(m as Map<String, dynamic>))
            .toList(),
      );
}

/// Sets the checked state of a checkbox block.
class SetCheckedOp extends BlockOp {
  @override
  OpType get type => OpType.setChecked;

  final String blockId;
  final bool checked;

  SetCheckedOp({required this.blockId, required this.checked});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'blockId': blockId, 'checked': checked};

  factory SetCheckedOp.fromMap(Map<String, dynamic> map) => SetCheckedOp(
        blockId: map['blockId'] as String,
        checked: map['checked'] as bool,
      );
}

/// Sets a relation value on the object.
class SetRelationOp extends BlockOp {
  @override
  OpType get type => OpType.setRelation;

  final String key;
  final dynamic value;

  SetRelationOp({required this.key, required this.value});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'key': key, 'value': value};

  factory SetRelationOp.fromMap(Map<String, dynamic> map) => SetRelationOp(
        key: map['key'] as String,
        value: map['value'],
      );
}

/// Removes a relation from the object.
class RemoveRelationOp extends BlockOp {
  @override
  OpType get type => OpType.removeRelation;

  final String key;

  RemoveRelationOp({required this.key});

  @override
  Map<String, dynamic> toMap() => {'op': type.index, 'key': key};

  factory RemoveRelationOp.fromMap(Map<String, dynamic> map) =>
      RemoveRelationOp(key: map['key'] as String);
}

/// Sets object-level details (name, icon, cover, etc.).
class SetDetailsOp extends BlockOp {
  @override
  OpType get type => OpType.setDetails;

  final Map<String, dynamic> details;

  SetDetailsOp({required this.details});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'details': details};

  factory SetDetailsOp.fromMap(Map<String, dynamic> map) =>
      SetDetailsOp(details: Map<String, dynamic>.from(map['details'] as Map));
}

/// Duplicates a block.
class DuplicateBlockOp extends BlockOp {
  @override
  OpType get type => OpType.duplicateBlock;

  final String sourceBlockId;
  final String newBlockId;

  DuplicateBlockOp({required this.sourceBlockId, required this.newBlockId});

  @override
  Map<String, dynamic> toMap() => {
        'op': type.index,
        'sourceBlockId': sourceBlockId,
        'newBlockId': newBlockId,
      };

  factory DuplicateBlockOp.fromMap(Map<String, dynamic> map) =>
      DuplicateBlockOp(
        sourceBlockId: map['sourceBlockId'] as String,
        newBlockId: map['newBlockId'] as String,
      );
}

/// Sets arbitrary fields on a block.
class SetFieldsOp extends BlockOp {
  @override
  OpType get type => OpType.setFields;

  final String blockId;
  final Map<String, dynamic> fields;

  SetFieldsOp({required this.blockId, required this.fields});

  @override
  Map<String, dynamic> toMap() =>
      {'op': type.index, 'blockId': blockId, 'fields': fields};

  factory SetFieldsOp.fromMap(Map<String, dynamic> map) => SetFieldsOp(
        blockId: map['blockId'] as String,
        fields: Map<String, dynamic>.from(map['fields'] as Map),
      );
}
