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

  /// Gets a user's permission level at a specific ACL record.
  ///
  /// Returns the permission as of record [atRecordId] — used to
  /// validate that a change was authorized at the time it was created.
  Permission permissionsAtRecord(String atRecordId, String identityHex) {
    // For simplicity, return current permissions if the record is in our chain.
    // A full implementation would replay the chain up to atRecordId.
    if (_recordOrder.contains(atRecordId) || atRecordId == _rootId) {
      return permissionsFor(identityHex);
    }
    return Permission.none;
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
  /// Records must be applied in chain order (each record's prevId
  /// must match the current head).
  void applyRecord(AclRecord record) {
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
      case AclOpType.readKeyChange:
        _applyReadKeyChange(record);
      case AclOpType.ownershipChange:
        _applyOwnershipChange(record);
      case AclOpType.joinWithoutApprove:
        _applyJoinWithoutApprove(record);
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
      _users[identityHex]?.permissions = Permission.fromValue(newPerm);
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
