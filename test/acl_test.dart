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

import 'package:test/test.dart';

import 'package:anytype_dart/src/acl/acl_state.dart';
import 'package:anytype_dart/src/acl/permissions.dart';

Uint8List _identity(int seed) => Uint8List.fromList(List.generate(32, (i) => seed + i));
String _identityHex(int seed) {
  final bytes = _identity(seed);
  const hexChars = '0123456789abcdef';
  final buf = StringBuffer();
  for (final b in bytes) {
    buf.write(hexChars[b >> 4]);
    buf.write(hexChars[b & 0x0F]);
  }
  return buf.toString();
}

void main() {
  group('Permission', () {
    test('owner can write', () {
      expect(Permission.owner.canWrite, isTrue);
    });

    test('admin can write', () {
      expect(Permission.admin.canWrite, isTrue);
    });

    test('writer can write', () {
      expect(Permission.writer.canWrite, isTrue);
    });

    test('reader cannot write', () {
      expect(Permission.reader.canWrite, isFalse);
    });

    test('guest cannot write', () {
      expect(Permission.guest.canWrite, isFalse);
    });

    test('none has no access', () {
      expect(Permission.none.canRead, isFalse);
      expect(Permission.none.canWrite, isFalse);
    });

    test('isAtLeast checks privilege level', () {
      expect(Permission.owner.isAtLeast(Permission.admin), isTrue);
      expect(Permission.admin.isAtLeast(Permission.writer), isTrue);
      expect(Permission.reader.isAtLeast(Permission.writer), isFalse);
    });

    test('fromValue', () {
      expect(Permission.fromValue(1), Permission.owner);
      expect(Permission.fromValue(3), Permission.writer);
      expect(Permission.fromValue(99), Permission.none);
    });
  });

  group('AclState', () {
    late AclState acl;

    setUp(() {
      acl = AclState();
    });

    test('apply root record', () {
      acl.applyRecord(AclRecord(
        id: 'root',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      expect(acl.rootId, 'root');
      expect(acl.ownerIdentity, _identityHex(1));
      expect(acl.permissionsFor(_identityHex(1)), Permission.owner);
    });

    test('invite and accept flow', () {
      // Owner creates space
      acl.applyRecord(AclRecord(
        id: 'r0',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      // Owner creates invite
      acl.applyRecord(AclRecord(
        id: 'r1',
        prevId: 'r0',
        identity: _identity(1),
        opType: AclOpType.invite,
        data: {
          'inviteKey': Uint8List(32),
          'isAnyoneCanJoin': false,
          'permissions': Permission.writer.value,
        },
      ));

      // User requests to join
      acl.applyRecord(AclRecord(
        id: 'r2',
        prevId: 'r1',
        identity: _identity(2),
        opType: AclOpType.requestJoin,
        data: {
          'identity': _identity(2),
          'inviteRecordId': 'r1',
        },
      ));

      // Owner accepts
      acl.applyRecord(AclRecord(
        id: 'r3',
        prevId: 'r2',
        identity: _identity(1),
        opType: AclOpType.requestAccept,
        data: {
          'requestRecordId': 'r2',
          'permissions': Permission.writer.value,
        },
      ));

      expect(acl.permissionsFor(_identityHex(2)), Permission.writer);
    });

    test('anyone-can-join invite', () {
      acl.applyRecord(AclRecord(
        id: 'r0',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      acl.applyRecord(AclRecord(
        id: 'r1',
        prevId: 'r0',
        identity: _identity(1),
        opType: AclOpType.invite,
        data: {
          'inviteKey': Uint8List(32),
          'isAnyoneCanJoin': true,
          'permissions': Permission.reader.value,
        },
      ));

      // User joins without approval
      acl.applyRecord(AclRecord(
        id: 'r2',
        prevId: 'r1',
        identity: _identity(2),
        opType: AclOpType.joinWithoutApprove,
        data: {
          'identity': _identity(2),
          'inviteRecordId': 'r1',
        },
      ));

      expect(acl.permissionsFor(_identityHex(2)), Permission.reader);
    });

    test('remove account', () {
      acl.applyRecord(AclRecord(
        id: 'r0',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      // Add user via direct accept
      acl.applyRecord(AclRecord(
        id: 'r1',
        prevId: 'r0',
        identity: _identity(2),
        opType: AclOpType.requestJoin,
        data: {'identity': _identity(2), 'inviteRecordId': ''},
      ));
      acl.applyRecord(AclRecord(
        id: 'r2',
        prevId: 'r1',
        identity: _identity(1),
        opType: AclOpType.requestAccept,
        data: {
          'requestRecordId': 'r1',
          'permissions': Permission.writer.value,
        },
      ));
      expect(acl.permissionsFor(_identityHex(2)), Permission.writer);

      // Remove the user
      acl.applyRecord(AclRecord(
        id: 'r3',
        prevId: 'r2',
        identity: _identity(1),
        opType: AclOpType.accountRemove,
        data: {'identities': [_identityHex(2)]},
      ));

      expect(acl.permissionsFor(_identityHex(2)), Permission.none);
    });

    test('ownership transfer', () {
      acl.applyRecord(AclRecord(
        id: 'r0',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      // Add new user as admin
      acl.applyRecord(AclRecord(
        id: 'r1',
        prevId: 'r0',
        identity: _identity(2),
        opType: AclOpType.requestJoin,
        data: {'identity': _identity(2), 'inviteRecordId': ''},
      ));
      acl.applyRecord(AclRecord(
        id: 'r2',
        prevId: 'r1',
        identity: _identity(1),
        opType: AclOpType.requestAccept,
        data: {
          'requestRecordId': 'r1',
          'permissions': Permission.admin.value,
        },
      ));

      // Transfer ownership
      acl.applyRecord(AclRecord(
        id: 'r3',
        prevId: 'r2',
        identity: _identity(1),
        opType: AclOpType.ownershipChange,
        data: {
          'newOwnerIdentity': _identityHex(2),
          'oldOwnerPermissions': Permission.admin.value,
        },
      ));

      expect(acl.permissionsFor(_identityHex(2)), Permission.owner);
      expect(acl.permissionsFor(_identityHex(1)), Permission.admin);
      expect(acl.ownerIdentity, _identityHex(2));
    });

    test('validateChange checks write permission', () {
      acl.applyRecord(AclRecord(
        id: 'r0',
        prevId: '',
        identity: _identity(1),
        opType: AclOpType.root,
      ));

      expect(
        acl.validateChange(
          identityHex: _identityHex(1),
          aclHeadId: 'r0',
          isDerived: false,
        ),
        isTrue,
      );

      expect(
        acl.validateChange(
          identityHex: _identityHex(99),
          aclHeadId: 'r0',
          isDerived: false,
        ),
        isFalse,
      );

      // Derived changes always pass
      expect(
        acl.validateChange(
          identityHex: _identityHex(99),
          aclHeadId: 'r0',
          isDerived: true,
        ),
        isTrue,
      );
    });

    test('isAfter tracks record ordering', () {
      acl.applyRecord(AclRecord(
        id: 'r0', prevId: '', identity: _identity(1), opType: AclOpType.root,
      ));
      acl.applyRecord(AclRecord(
        id: 'r1',
        prevId: 'r0',
        identity: _identity(1),
        opType: AclOpType.invite,
        data: {'inviteKey': Uint8List(32)},
      ));

      expect(acl.isAfter('r1', 'r0'), isTrue);
      expect(acl.isAfter('r0', 'r1'), isFalse);
    });
  });
}
