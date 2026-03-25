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

/// ACL (Access Control List) state machine.
///
/// Implements the any-sync ACL model where records form a chain
/// (not a tree) via the consensus protocol. Each record is dual-signed
/// by the creator and the consensus node.
///
/// The ACL state tracks:
///   - User permissions per identity
///   - Read keys (for encryption/decryption)
///   - Pending invites
///   - Record ordering for monotonicity validation
library;

import 'dart:typed_data';

import 'permissions.dart';

/// An invite to join a space.
class AclInvite {
  /// The ACL record ID that created this invite.
  final String recordId;

  /// The invite's ephemeral public key.
  final Uint8List inviteKey;

  /// Whether this is an anyone-can-join invite.
  final bool isAnyoneCanJoin;

  /// The permission level granted by this invite.
  final Permission permissions;

  const AclInvite({
    required this.recordId,
    required this.inviteKey,
    this.isAnyoneCanJoin = false,
    this.permissions = Permission.reader,
  });
}

/// A pending join request.
class AclJoinRequest {
  /// The ACL record ID of the request.
  final String recordId;

  /// The requester's identity public key.
  final Uint8List identity;

  /// The invite record this request references.
  final String inviteRecordId;

  const AclJoinRequest({
    required this.recordId,
    required this.identity,
    required this.inviteRecordId,
  });
}

/// Information about a user in the ACL.
class AclUser {
  /// The user's identity public key.
  final Uint8List identity;

  /// Current permission level.
  Permission permissions;

  /// The encrypted read key for this user (encrypted with their public key).
  Uint8List? encryptedReadKey;

  AclUser({
    required this.identity,
    required this.permissions,
    this.encryptedReadKey,
  });
}

/// A read key entry in the ACL state.
class ReadKeyEntry {
  /// The read key ID (ACL record ID where this key was established).
  final String id;

  /// The encrypted read key (encrypted per-user).
  final Map<String, Uint8List> encryptedKeys; // identity hex → encrypted key

  const ReadKeyEntry({required this.id, required this.encryptedKeys});
}

/// The type of an ACL operation.
enum AclOpType {
  root,
  invite,
  inviteRevoke,
  requestJoin,
  requestAccept,
  requestDecline,
  accountRemove,
  permissionChange,
  readKeyChange,
  ownershipChange,
  joinWithoutApprove,
  accountsAdd,
  requestCancel,
  requestRemove,
  inviteChange,
  permissionChanges,
  spaceOptionsChange,
}

/// A single ACL record in the chain.
class AclRecord {
  /// The record's ID (CID of the signed payload).
  final String id;

  /// The previous record's ID (forms a chain).
  final String prevId;

  /// The identity of the record creator.
  final Uint8List identity;

  /// The operation type.
  final AclOpType opType;

  /// The timestamp.
  final int timestamp;

  /// Operation-specific data.
  final Map<String, dynamic> data;

  /// The consensus node's signature (proof of ordering).
  final Uint8List? acceptorSignature;

  const AclRecord({
    required this.id,
    required this.prevId,
    required this.identity,
    required this.opType,
    this.timestamp = 0,
    this.data = const {},
    this.acceptorSignature,
  });
}

/// Materialized ACL state computed from the record chain.
///
/// Tracks user permissions, read keys, invites, and join requests.
/// Supports querying permissions at any point in the chain (by record ID).
class AclState {
  /// Users keyed by identity hex string.
  final Map<String, AclUser> _users = {};

  /// Invites keyed by record ID.
  final Map<String, AclInvite> _invites = {};

  /// Pending join requests keyed by record ID.
  final Map<String, AclJoinRequest> _requests = {};

  /// Read keys keyed by record ID.
  final Map<String, ReadKeyEntry> _readKeys = {};

  /// Ordered list of record IDs (for monotonicity checks).
  final List<String> _recordOrder = [];

  /// The ACL root record ID.
  String _rootId = '';

  /// The owner's identity (hex).
  String _ownerIdentity = '';

  /// The current (latest) read key ID.
  String _currentReadKeyId = '';

  /// The root record ID.
  String get rootId => _rootId;

  /// The owner's identity hex.
  String get ownerIdentity => _ownerIdentity;

  /// The latest record ID.
  String get headId =>
      _recordOrder.isNotEmpty ? _recordOrder.last : _rootId;

  /// The current read key ID.
  String get currentReadKeyId => _currentReadKeyId;

  /// All users with permissions.
  Iterable<AclUser> get users => _users.values;

  /// Gets a user's permission level.
  Permission permissionsFor(String identityHex) {
    return _users[identityHex]?.permissions ?? Permission.none;
  }

  /// Per-user permission change history for historical lookups.
  final Map<String, List<_PermissionEntry>> _permissionHistory = {};

  /// Whether this is a one-to-one space (no further records allowed).
  bool _isOneToOne = false;

  /// Space options (e.g., deleteRestricted).
  final Map<String, dynamic> _spaceOptions = {};

  /// Whether this is a one-to-one space.
  bool get isOneToOne => _isOneToOne;

  /// Gets a user's permission level at a specific ACL record.
  ///
  /// Replays the permission history to find the closest permission
  /// at or before the given record (matches Go closestPermissions).
  Permission permissionsAtRecord(String atRecordId, String identityHex) {
    if (!_recordOrder.contains(atRecordId) && atRecordId != _rootId) {
      return Permission.none;
    }

    final history = _permissionHistory[identityHex];
    if (history == null || history.isEmpty) {
      return _users[identityHex]?.permissions ?? Permission.none;
    }

    // Find the target record's position in the chain
    final targetIdx = atRecordId == _rootId
        ? -1
        : _recordOrder.indexOf(atRecordId);

    // Walk backwards through history to find the permission at or before target
    Permission result = Permission.none;
    for (final entry in history) {
      final entryIdx = entry.recordId == _rootId
          ? -1
          : _recordOrder.indexOf(entry.recordId);
      if (entryIdx <= targetIdx) {
        result = entry.permission;
      } else {
        break;
      }
    }
    return result;
  }

  /// Whether [recordA] comes after [recordB] in the chain.
  bool isAfter(String recordA, String recordB) {
    final idxA = _recordOrder.indexOf(recordA);
    final idxB = _recordOrder.indexOf(recordB);
    if (idxA < 0 || idxB < 0) return false;
    return idxA > idxB;
  }

  /// Applies an ACL record to the state.
  ///
  /// Records must be applied in chain order. The record's prevId
  /// must match the current head (strict chain validation, matching
  /// Go validator.go ValidateAclRecordContents).
  ///
  /// Throws [StateError] if the record breaks the chain.
  void applyRecord(AclRecord record) {
    // Strict chain validation (matches Go: ch.PrevId != c.aclState.lastRecordId)
    if (record.opType != AclOpType.root) {
      final expectedPrev = headId;
      if (record.prevId != expectedPrev) {
        throw StateError(
          'ACL chain broken: record ${record.id} has prevId '
          '"${record.prevId}" but head is "$expectedPrev"',
        );
      }
      // Reject records on one-to-one spaces
      if (_isOneToOne) {
        throw StateError('Cannot add records to one-to-one space');
      }
    }

    switch (record.opType) {
      case AclOpType.root:
        _applyRoot(record);
      case AclOpType.invite:
        _applyInvite(record);
      case AclOpType.inviteRevoke:
        _invites.remove(record.data['inviteRecordId'] as String?);
      case AclOpType.requestJoin:
        _applyRequestJoin(record);
      case AclOpType.requestAccept:
        _applyRequestAccept(record);
      case AclOpType.requestDecline:
        _requests.remove(record.data['requestRecordId'] as String?);
      case AclOpType.accountRemove:
        _applyAccountRemove(record);
      case AclOpType.permissionChange:
        _applyPermissionChange(record);
      case AclOpType.permissionChanges:
        _applyPermissionChanges(record);
      case AclOpType.readKeyChange:
        _applyReadKeyChange(record);
      case AclOpType.ownershipChange:
        _applyOwnershipChange(record);
      case AclOpType.joinWithoutApprove:
        _applyJoinWithoutApprove(record);
      case AclOpType.accountsAdd:
        _applyAccountsAdd(record);
      case AclOpType.requestCancel:
        _requests.remove(record.data['requestRecordId'] as String?);
      case AclOpType.requestRemove:
        final identityHex = _hexEncode(record.identity);
        _users.remove(identityHex);
      case AclOpType.inviteChange:
        _applyInviteChange(record);
      case AclOpType.spaceOptionsChange:
        _applySpaceOptionsChange(record);
    }
    _recordOrder.add(record.id);
  }

  /// Validates that a change is authorized by the ACL.
  ///
  /// Checks that the identity has write permission at the change's
  /// ACL head, and that the ACL head is monotonically increasing.
  bool validateChange({
    required String identityHex,
    required String aclHeadId,
    required bool isDerived,
  }) {
    if (isDerived) return true;
    final perm = permissionsAtRecord(aclHeadId, identityHex);
    return perm.canWrite;
  }

  void _applyRoot(AclRecord record) {
    _rootId = record.id;
    final identityHex = _hexEncode(record.identity);
    _ownerIdentity = identityHex;
    _users[identityHex] = AclUser(
      identity: record.identity,
      permissions: Permission.owner,
      encryptedReadKey: record.data['encryptedReadKey'] as Uint8List?,
    );
    _permissionHistory.putIfAbsent(identityHex, () => []).add(
      _PermissionEntry(recordId: record.id, permission: Permission.owner),
    );
    _currentReadKeyId = record.id;
  }

  void _applyInvite(AclRecord record) {
    _invites[record.id] = AclInvite(
      recordId: record.id,
      inviteKey: record.data['inviteKey'] as Uint8List? ?? Uint8List(0),
      isAnyoneCanJoin: record.data['isAnyoneCanJoin'] as bool? ?? false,
      permissions: Permission.fromValue(
        record.data['permissions'] as int? ?? Permission.reader.value,
      ),
    );
  }

  void _applyRequestJoin(AclRecord record) {
    _requests[record.id] = AclJoinRequest(
      recordId: record.id,
      identity: record.data['identity'] as Uint8List? ?? Uint8List(0),
      inviteRecordId: record.data['inviteRecordId'] as String? ?? '',
    );
  }

  void _applyRequestAccept(AclRecord record) {
    final requestId = record.data['requestRecordId'] as String?;
    final request = _requests.remove(requestId);
    if (request == null) return;

    final identityHex = _hexEncode(request.identity);
    _users[identityHex] = AclUser(
      identity: request.identity,
      permissions: Permission.fromValue(
        record.data['permissions'] as int? ?? Permission.reader.value,
      ),
      encryptedReadKey: record.data['encryptedReadKey'] as Uint8List?,
    );
  }

  void _applyAccountRemove(AclRecord record) {
    final identities = record.data['identities'] as List<String>? ?? [];
    for (final hex in identities) {
      _users.remove(hex);
    }
  }

  void _applyPermissionChange(AclRecord record) {
    final identityHex = record.data['identityHex'] as String?;
    final newPerm = record.data['permissions'] as int?;
    if (identityHex != null && newPerm != null) {
      final perm = Permission.fromValue(newPerm);
      _users[identityHex]?.permissions = perm;
      _permissionHistory.putIfAbsent(identityHex, () => []).add(
        _PermissionEntry(recordId: record.id, permission: perm),
      );
    }
  }

  void _applyPermissionChanges(AclRecord record) {
    final changes = record.data['changes'] as List<Map<String, dynamic>>? ?? [];
    for (final change in changes) {
      final identityHex = change['identityHex'] as String?;
      final newPerm = change['permissions'] as int?;
      if (identityHex != null && newPerm != null) {
        final perm = Permission.fromValue(newPerm);
        _users[identityHex]?.permissions = perm;
        _permissionHistory.putIfAbsent(identityHex, () => []).add(
          _PermissionEntry(recordId: record.id, permission: perm),
        );
      }
    }
  }

  void _applyReadKeyChange(AclRecord record) {
    _currentReadKeyId = record.id;
    final keys = record.data['accountKeys'] as Map<String, Uint8List>?;
    if (keys != null) {
      _readKeys[record.id] = ReadKeyEntry(id: record.id, encryptedKeys: keys);
    }
  }

  void _applyOwnershipChange(AclRecord record) {
    final newOwnerHex = record.data['newOwnerIdentity'] as String?;
    if (newOwnerHex == null) return;

    // Demote old owner
    final oldPerm = record.data['oldOwnerPermissions'] as int?;
    _users[_ownerIdentity]?.permissions =
        Permission.fromValue(oldPerm ?? Permission.admin.value);

    // Promote new owner
    _users[newOwnerHex]?.permissions = Permission.owner;
    _ownerIdentity = newOwnerHex;
  }

  void _applyJoinWithoutApprove(AclRecord record) {
    final identity = record.data['identity'] as Uint8List?;
    if (identity == null) return;
    final identityHex = _hexEncode(identity);
    final invite =
        _invites[record.data['inviteRecordId'] as String?];
    _users[identityHex] = AclUser(
      identity: identity,
      permissions: invite?.permissions ?? Permission.reader,
      encryptedReadKey: record.data['encryptedReadKey'] as Uint8List?,
    );
  }

  void _applyAccountsAdd(AclRecord record) {
    final accounts =
        record.data['accounts'] as List<Map<String, dynamic>>? ?? [];
    for (final account in accounts) {
      final identity = account['identity'] as Uint8List?;
      if (identity == null) continue;
      final identityHex = _hexEncode(identity);
      final perm = Permission.fromValue(
        account['permissions'] as int? ?? Permission.reader.value,
      );
      _users[identityHex] = AclUser(
        identity: identity,
        permissions: perm,
        encryptedReadKey: account['encryptedReadKey'] as Uint8List?,
      );
      _permissionHistory.putIfAbsent(identityHex, () => []).add(
        _PermissionEntry(recordId: record.id, permission: perm),
      );
    }
  }

  void _applyInviteChange(AclRecord record) {
    final inviteRecordId = record.data['inviteRecordId'] as String?;
    if (inviteRecordId == null) return;
    final existing = _invites[inviteRecordId];
    if (existing == null) return;
    _invites[inviteRecordId] = AclInvite(
      recordId: inviteRecordId,
      inviteKey: existing.inviteKey,
      isAnyoneCanJoin: existing.isAnyoneCanJoin,
      permissions: Permission.fromValue(
        record.data['permissions'] as int? ?? existing.permissions.value,
      ),
    );
  }

  void _applySpaceOptionsChange(AclRecord record) {
    final options = record.data['options'] as Map<String, dynamic>? ?? {};
    _spaceOptions.addAll(options);
    if (options.containsKey('isOneToOne')) {
      _isOneToOne = options['isOneToOne'] as bool? ?? false;
    }
  }
}

/// Internal: tracks a permission change at a specific record.
class _PermissionEntry {
  final String recordId;
  final Permission permission;
  const _PermissionEntry({required this.recordId, required this.permission});
}

String _hexEncode(Uint8List bytes) {
  const hexChars = '0123456789abcdef';
  final buf = StringBuffer();
  for (final b in bytes) {
    buf.write(hexChars[b >> 4]);
    buf.write(hexChars[b & 0x0F]);
  }
  return buf.toString();
}
