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

/// Top-level Anytype object container.
///
/// An AnyObject holds a block tree (content), relations (properties),
/// and metadata. It is the materialized state produced by applying
/// all changes in the object's CRDT tree.
library;

import 'block.dart';
import 'object_type.dart';

/// An Anytype object — the fundamental data unit.
///
/// Objects are composed of:
///   - A **root block** containing the block tree (content)
///   - **Relations**: typed key-value properties
///   - **Type**: determines schema and default layout
///   - **Details**: system metadata (name, icon, cover, etc.)
class AnyObject {
  /// Unique object ID (matches the CRDT tree ID).
  final String id;

  /// The object type ID.
  String typeId;

  /// Layout override (or derived from type).
  ObjectLayout layout;

  /// Root block ID. The root block's children are the top-level content blocks.
  final String rootBlockId;

  /// All blocks in this object, keyed by ID.
  final Map<String, Block> blocks;

  /// Relation values, keyed by relation key.
  final Map<String, dynamic> relations;

  AnyObject({
    required this.id,
    this.typeId = '',
    this.layout = ObjectLayout.basic,
    String? rootBlockId,
    Map<String, Block>? blocks,
    Map<String, dynamic>? relations,
  })  : rootBlockId = rootBlockId ?? id,
        blocks = blocks ?? {},
        relations = relations ?? {} {
    // Ensure root block exists
    if (!this.blocks.containsKey(this.rootBlockId)) {
      this.blocks[this.rootBlockId] = Block(
        id: this.rootBlockId,
        type: BlockType.layout,
        layoutStyle: LayoutStyle.div,
      );
    }
  }

  /// The root block.
  Block get rootBlock => blocks[rootBlockId]!;

  /// The ordered list of top-level content block IDs.
  List<String> get contentBlockIds => rootBlock.childIds;

  /// The object name (from relations).
  String get name => (relations['name'] as String?) ?? '';
  set name(String value) => relations['name'] = value;

  /// The icon emoji.
  String get iconEmoji => (relations['iconEmoji'] as String?) ?? '';
  set iconEmoji(String value) => relations['iconEmoji'] = value;

  /// Whether the object is archived.
  bool get isArchived => (relations['isArchived'] as bool?) ?? false;

  /// Whether the object is a favorite.
  bool get isFavorite => (relations['isFavorite'] as bool?) ?? false;

  // --- Block operations ---

  /// Gets a block by ID, or null if not found.
  Block? getBlock(String blockId) => blocks[blockId];

  /// Adds a block to the object and appends it to a parent's children.
  void addBlock(Block block, {required String parentId, String? afterId}) {
    blocks[block.id] = block;
    final parent = blocks[parentId];
    if (parent == null) return;

    if (afterId == null) {
      parent.childIds.add(block.id);
    } else {
      final idx = parent.childIds.indexOf(afterId);
      if (idx >= 0) {
        parent.childIds.insert(idx + 1, block.id);
      } else {
        parent.childIds.add(block.id);
      }
    }
  }

  /// Removes a block and its reference from its parent.
  Block? removeBlock(String blockId) {
    final block = blocks.remove(blockId);
    if (block == null) return null;

    // Remove from parent's children
    for (final parent in blocks.values) {
      if (parent.childIds.remove(blockId)) break;
    }

    // Recursively remove children
    for (final childId in block.childIds) {
      removeBlock(childId);
    }

    return block;
  }

  /// Moves a block to a new parent at a specific position.
  void moveBlock(String blockId, {required String newParentId, String? afterId}) {
    // Remove from old parent
    for (final parent in blocks.values) {
      parent.childIds.remove(blockId);
    }

    // Add to new parent
    final newParent = blocks[newParentId];
    if (newParent == null) return;

    if (afterId == null) {
      newParent.childIds.add(blockId);
    } else {
      final idx = newParent.childIds.indexOf(afterId);
      if (idx >= 0) {
        newParent.childIds.insert(idx + 1, blockId);
      } else {
        newParent.childIds.add(blockId);
      }
    }
  }

  /// Returns the parent block ID for a given block, or null if root.
  String? parentOf(String blockId) {
    for (final block in blocks.values) {
      if (block.childIds.contains(blockId)) return block.id;
    }
    return null;
  }

  /// Sets a relation value.
  void setRelation(String key, dynamic value) {
    relations[key] = value;
  }

  /// Gets a relation value.
  dynamic getRelation(String key) => relations[key];

  /// Removes a relation value.
  void removeRelation(String key) {
    relations.remove(key);
  }

  /// Serializes the full object state to a map.
  Map<String, dynamic> toMap() => {
        'id': id,
        'typeId': typeId,
        'layout': layout.index,
        'rootBlockId': rootBlockId,
        'blocks': {
          for (final entry in blocks.entries) entry.key: entry.value.toMap()
        },
        'relations': relations,
      };

  /// Deserializes an object from a map.
  factory AnyObject.fromMap(Map<String, dynamic> map) {
    final blocks = <String, Block>{};
    if (map['blocks'] != null) {
      for (final entry in (map['blocks'] as Map<String, dynamic>).entries) {
        blocks[entry.key] =
            Block.fromMap(entry.value as Map<String, dynamic>);
      }
    }
    return AnyObject(
      id: map['id'] as String,
      typeId: map['typeId'] as String? ?? '',
      layout: ObjectLayout.values[map['layout'] as int? ?? 0],
      rootBlockId: map['rootBlockId'] as String?,
      blocks: blocks,
      relations: Map<String, dynamic>.from(
        map['relations'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
