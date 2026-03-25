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

/// Space — a collection of objects sharing ACL and encryption scope.
library;

import 'object_type.dart';
import 'relation.dart';

/// A Space in the Anytype network.
///
/// Spaces are the top-level organizational unit. Each space:
///   - Has its own ACL (access control list)
///   - Has its own encryption key scope
///   - Contains objects, types, and relations
///   - Can be shared with other users
class Space {
  /// Unique space ID.
  final String id;

  /// Space name.
  String name;

  /// Space icon emoji.
  String iconEmoji;

  /// Object IDs in this space.
  final Set<String> objectIds;

  /// Object type definitions available in this space.
  final Map<String, ObjectTypeDef> types;

  /// Relation definitions available in this space.
  final Map<String, RelationDef> relationDefs;

  /// The dashboard/home object ID.
  String? dashboardId;

  /// Whether this is the personal (default) space.
  final bool isPersonal;

  Space({
    required this.id,
    this.name = '',
    this.iconEmoji = '',
    Set<String>? objectIds,
    Map<String, ObjectTypeDef>? types,
    Map<String, RelationDef>? relationDefs,
    this.dashboardId,
    this.isPersonal = false,
  })  : objectIds = objectIds ?? {},
        types = types ?? {},
        relationDefs = relationDefs ?? {};

  /// Adds an object ID to this space.
  void addObject(String objectId) => objectIds.add(objectId);

  /// Removes an object ID from this space.
  void removeObject(String objectId) => objectIds.remove(objectId);

  /// Registers a type definition.
  void addType(ObjectTypeDef type) => types[type.id] = type;

  /// Registers a relation definition.
  void addRelation(RelationDef relation) =>
      relationDefs[relation.key] = relation;

  /// Gets a type definition by ID.
  ObjectTypeDef? getType(String typeId) => types[typeId];

  /// Gets a relation definition by key.
  RelationDef? getRelation(String key) => relationDefs[key];
}
