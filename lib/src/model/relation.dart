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

/// Relations (typed properties) for Anytype objects.
///
/// Relations are key-value properties attached to objects.
/// Each relation has a format (text, number, date, etc.)
/// that determines how its value is stored and displayed.
library;

/// The data format of a relation value.
enum RelationFormat {
  shortText,
  longText,
  number,
  date,
  select,
  multiSelect,
  checkbox,
  url,
  email,
  phone,
  object,
  file,
  status,
  tag,
}

/// A select/multiSelect option.
class SelectOption {
  final String id;
  final String text;
  final String color;

  const SelectOption({
    required this.id,
    required this.text,
    this.color = '',
  });

  Map<String, dynamic> toMap() => {'id': id, 'text': text, 'color': color};

  factory SelectOption.fromMap(Map<String, dynamic> map) => SelectOption(
        id: map['id'] as String,
        text: map['text'] as String,
        color: map['color'] as String? ?? '',
      );
}

/// Definition of a relation (schema).
class RelationDef {
  /// Unique key identifying this relation across the space.
  final String key;

  /// Human-readable name.
  final String name;

  /// Data format.
  final RelationFormat format;

  /// For select/multiSelect: available options.
  final List<SelectOption> selectOptions;

  /// Whether this is a built-in system relation.
  final bool isSystem;

  /// For object relations: allowed object type IDs.
  final List<String> objectTypeIds;

  const RelationDef({
    required this.key,
    required this.name,
    required this.format,
    this.selectOptions = const [],
    this.isSystem = false,
    this.objectTypeIds = const [],
  });

  Map<String, dynamic> toMap() => {
        'key': key,
        'name': name,
        'format': format.index,
        'selectOptions': selectOptions.map((o) => o.toMap()).toList(),
        'isSystem': isSystem,
        'objectTypeIds': objectTypeIds,
      };

  factory RelationDef.fromMap(Map<String, dynamic> map) => RelationDef(
        key: map['key'] as String,
        name: map['name'] as String,
        format: RelationFormat.values[map['format'] as int],
        selectOptions: (map['selectOptions'] as List<dynamic>?)
                ?.map((o) => SelectOption.fromMap(o as Map<String, dynamic>))
                .toList() ??
            [],
        isSystem: map['isSystem'] as bool? ?? false,
        objectTypeIds: (map['objectTypeIds'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );
}

/// Built-in system relation keys.
class SystemRelations {
  static const String name = 'name';
  static const String description = 'description';
  static const String iconEmoji = 'iconEmoji';
  static const String iconImage = 'iconImage';
  static const String coverImage = 'coverImage';
  static const String coverType = 'coverType';
  static const String type = 'type';
  static const String layout = 'layout';
  static const String createdDate = 'createdDate';
  static const String lastModifiedDate = 'lastModifiedDate';
  static const String creator = 'creator';
  static const String lastModifiedBy = 'lastModifiedBy';
  static const String isArchived = 'isArchived';
  static const String isFavorite = 'isFavorite';
  static const String isDeleted = 'isDeleted';
}
