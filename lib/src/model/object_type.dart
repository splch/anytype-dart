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

/// Object types define the schema for a class of objects.
library;

/// Layout determines how an object's blocks are rendered.
enum ObjectLayout {
  basic,
  profile,
  todo,
  set_,
  collection,
  note,
  bookmark,
  file_,
  image,
  type,
  relation,
  dashboard,
  participant,
}

/// Definition of an object type.
///
/// Object types define which relations an object supports
/// and how it is displayed by default.
class ObjectTypeDef {
  /// Unique type ID.
  final String id;

  /// Human-readable name.
  final String name;

  /// Icon emoji.
  final String iconEmoji;

  /// Default layout for new objects of this type.
  final ObjectLayout defaultLayout;

  /// Relation keys that are recommended for this type.
  final List<String> recommendedRelationKeys;

  /// Whether this is a built-in system type.
  final bool isSystem;

  const ObjectTypeDef({
    required this.id,
    required this.name,
    this.iconEmoji = '',
    this.defaultLayout = ObjectLayout.basic,
    this.recommendedRelationKeys = const [],
    this.isSystem = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'iconEmoji': iconEmoji,
        'defaultLayout': defaultLayout.index,
        'recommendedRelationKeys': recommendedRelationKeys,
        'isSystem': isSystem,
      };

  factory ObjectTypeDef.fromMap(Map<String, dynamic> map) => ObjectTypeDef(
        id: map['id'] as String,
        name: map['name'] as String,
        iconEmoji: map['iconEmoji'] as String? ?? '',
        defaultLayout: ObjectLayout.values[map['defaultLayout'] as int? ?? 0],
        recommendedRelationKeys: (map['recommendedRelationKeys'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        isSystem: map['isSystem'] as bool? ?? false,
      );
}

/// Built-in system types.
class SystemTypes {
  static const page = ObjectTypeDef(
    id: 'ot-page',
    name: 'Page',
    iconEmoji: '\u{1F4C4}',
    defaultLayout: ObjectLayout.basic,
    isSystem: true,
  );

  static const note = ObjectTypeDef(
    id: 'ot-note',
    name: 'Note',
    iconEmoji: '\u{1F4DD}',
    defaultLayout: ObjectLayout.note,
    isSystem: true,
  );

  static const task = ObjectTypeDef(
    id: 'ot-task',
    name: 'Task',
    iconEmoji: '\u{2705}',
    defaultLayout: ObjectLayout.todo,
    recommendedRelationKeys: ['status', 'assignee', 'dueDate'],
    isSystem: true,
  );

  static const bookmark = ObjectTypeDef(
    id: 'ot-bookmark',
    name: 'Bookmark',
    iconEmoji: '\u{1F516}',
    defaultLayout: ObjectLayout.bookmark,
    isSystem: true,
  );

  static const collection = ObjectTypeDef(
    id: 'ot-collection',
    name: 'Collection',
    iconEmoji: '\u{1F4DA}',
    defaultLayout: ObjectLayout.collection,
    isSystem: true,
  );
}
