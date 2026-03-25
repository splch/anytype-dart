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

/// Permission types for space ACL.
///
/// Matches the any-sync protocol's AclUserPermissions enum:
///   None(0) > Owner(1) > Admin(2) > Writer(3) > Reader(4) > Guest(5)
/// Lower numeric value = higher privilege.
library;

/// Permission level for a user in a space.
enum Permission {
  /// No access.
  none(0),

  /// Full control: manage all, transfer ownership.
  owner(1),

  /// Manage accounts, invite/remove, read, write.
  admin(2),

  /// Read and write objects.
  writer(3),

  /// Read only.
  reader(4),

  /// Read only, limited capabilities.
  guest(5);

  final int value;
  const Permission(this.value);

  /// Whether this permission allows writing.
  bool get canWrite => value >= owner.value && value <= writer.value;

  /// Whether this permission allows reading.
  bool get canRead => value >= owner.value && value <= guest.value;

  /// Whether this permission allows admin operations (invite, remove).
  bool get canAdmin => value >= owner.value && value <= admin.value;

  /// Whether this is the owner permission.
  bool get isOwner => this == owner;

  /// Whether this permission is at least as privileged as [other].
  bool isAtLeast(Permission other) => value <= other.value && value > 0;

  /// Parses from the protocol's integer value.
  static Permission fromValue(int value) {
    for (final p in Permission.values) {
      if (p.value == value) return p;
    }
    return Permission.none;
  }
}
