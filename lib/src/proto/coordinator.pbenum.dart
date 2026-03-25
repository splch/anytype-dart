// This is a generated file - do not edit.
//
// Generated from coordinator.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorCodes extends $pb.ProtobufEnum {
  static const ErrorCodes Unexpected =
      ErrorCodes._(0, _omitEnumNames ? '' : 'Unexpected');
  static const ErrorCodes SpaceDeleted =
      ErrorCodes._(1, _omitEnumNames ? '' : 'SpaceDeleted');
  static const ErrorCodes SpaceDeletionPending =
      ErrorCodes._(2, _omitEnumNames ? '' : 'SpaceDeletionPending');
  static const ErrorCodes SpaceCreated =
      ErrorCodes._(3, _omitEnumNames ? '' : 'SpaceCreated');
  static const ErrorCodes SpaceNotExists =
      ErrorCodes._(4, _omitEnumNames ? '' : 'SpaceNotExists');
  static const ErrorCodes SpaceLimitReached =
      ErrorCodes._(5, _omitEnumNames ? '' : 'SpaceLimitReached');
  static const ErrorCodes AccountDeleted =
      ErrorCodes._(6, _omitEnumNames ? '' : 'AccountDeleted');
  static const ErrorCodes Forbidden =
      ErrorCodes._(7, _omitEnumNames ? '' : 'Forbidden');
  static const ErrorCodes AclHeadIsMissing =
      ErrorCodes._(8, _omitEnumNames ? '' : 'AclHeadIsMissing');
  static const ErrorCodes AclNonEmpty =
      ErrorCodes._(9, _omitEnumNames ? '' : 'AclNonEmpty');
  static const ErrorCodes SpaceNotShareable =
      ErrorCodes._(10, _omitEnumNames ? '' : 'SpaceNotShareable');
  static const ErrorCodes InboxMessageVerifyFailed =
      ErrorCodes._(11, _omitEnumNames ? '' : 'InboxMessageVerifyFailed');
  static const ErrorCodes SubscribePeerAlreadySubscribed =
      ErrorCodes._(12, _omitEnumNames ? '' : 'SubscribePeerAlreadySubscribed');
  static const ErrorCodes ErrorOffset =
      ErrorCodes._(300, _omitEnumNames ? '' : 'ErrorOffset');

  static const $core.List<ErrorCodes> values = <ErrorCodes>[
    Unexpected,
    SpaceDeleted,
    SpaceDeletionPending,
    SpaceCreated,
    SpaceNotExists,
    SpaceLimitReached,
    AccountDeleted,
    Forbidden,
    AclHeadIsMissing,
    AclNonEmpty,
    SpaceNotShareable,
    InboxMessageVerifyFailed,
    SubscribePeerAlreadySubscribed,
    ErrorOffset,
  ];

  static final $core.Map<$core.int, ErrorCodes> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ErrorCodes? valueOf($core.int value) => _byValue[value];

  const ErrorCodes._(super.value, super.name);
}

class SpaceStatus extends $pb.ProtobufEnum {
  static const SpaceStatus SpaceStatusCreated =
      SpaceStatus._(0, _omitEnumNames ? '' : 'SpaceStatusCreated');
  static const SpaceStatus SpaceStatusPendingDeletion =
      SpaceStatus._(1, _omitEnumNames ? '' : 'SpaceStatusPendingDeletion');
  static const SpaceStatus SpaceStatusDeletionStarted =
      SpaceStatus._(2, _omitEnumNames ? '' : 'SpaceStatusDeletionStarted');
  static const SpaceStatus SpaceStatusDeleted =
      SpaceStatus._(3, _omitEnumNames ? '' : 'SpaceStatusDeleted');
  static const SpaceStatus SpaceStatusNotExists =
      SpaceStatus._(4, _omitEnumNames ? '' : 'SpaceStatusNotExists');

  static const $core.List<SpaceStatus> values = <SpaceStatus>[
    SpaceStatusCreated,
    SpaceStatusPendingDeletion,
    SpaceStatusDeletionStarted,
    SpaceStatusDeleted,
    SpaceStatusNotExists,
  ];

  static final $core.List<SpaceStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static SpaceStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SpaceStatus._(super.value, super.name);
}

class SpacePermissions extends $pb.ProtobufEnum {
  static const SpacePermissions SpacePermissionsUnknown =
      SpacePermissions._(0, _omitEnumNames ? '' : 'SpacePermissionsUnknown');
  static const SpacePermissions SpacePermissionsOwner =
      SpacePermissions._(1, _omitEnumNames ? '' : 'SpacePermissionsOwner');

  static const $core.List<SpacePermissions> values = <SpacePermissions>[
    SpacePermissionsUnknown,
    SpacePermissionsOwner,
  ];

  static final $core.List<SpacePermissions?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SpacePermissions? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SpacePermissions._(super.value, super.name);
}

/// NodeType determines the type of API that a node supports
class NodeType extends $pb.ProtobufEnum {
  /// TreeAPI supports space/tree sync api
  static const NodeType TreeAPI =
      NodeType._(0, _omitEnumNames ? '' : 'TreeAPI');

  /// FileAPI support file api
  static const NodeType FileAPI =
      NodeType._(1, _omitEnumNames ? '' : 'FileAPI');

  /// CoordinatorAPI supports coordinator api
  static const NodeType CoordinatorAPI =
      NodeType._(2, _omitEnumNames ? '' : 'CoordinatorAPI');

  /// ConsensusAPI supports consensus api
  static const NodeType ConsensusAPI =
      NodeType._(3, _omitEnumNames ? '' : 'ConsensusAPI');

  /// NamingNodeAPI supports naming node api
  /// (see any-ns-node repository)
  static const NodeType NamingNodeAPI =
      NodeType._(4, _omitEnumNames ? '' : 'NamingNodeAPI');

  /// PaymentProcessingAPI supports payment processing api
  /// (see any-pp-node repository)
  static const NodeType PaymentProcessingAPI =
      NodeType._(5, _omitEnumNames ? '' : 'PaymentProcessingAPI');

  static const $core.List<NodeType> values = <NodeType>[
    TreeAPI,
    FileAPI,
    CoordinatorAPI,
    ConsensusAPI,
    NamingNodeAPI,
    PaymentProcessingAPI,
  ];

  static final $core.List<NodeType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static NodeType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const NodeType._(super.value, super.name);
}

/// DeletionChangeType determines the type of deletion payload
class DeletionPayloadType extends $pb.ProtobufEnum {
  static const DeletionPayloadType Tree =
      DeletionPayloadType._(0, _omitEnumNames ? '' : 'Tree');
  static const DeletionPayloadType Confirm =
      DeletionPayloadType._(1, _omitEnumNames ? '' : 'Confirm');
  static const DeletionPayloadType Account =
      DeletionPayloadType._(2, _omitEnumNames ? '' : 'Account');

  static const $core.List<DeletionPayloadType> values = <DeletionPayloadType>[
    Tree,
    Confirm,
    Account,
  ];

  static final $core.List<DeletionPayloadType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static DeletionPayloadType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeletionPayloadType._(super.value, super.name);
}

class DeletionLogRecordStatus extends $pb.ProtobufEnum {
  /// Ok means space should operate in a normal
  static const DeletionLogRecordStatus Ok =
      DeletionLogRecordStatus._(0, _omitEnumNames ? '' : 'Ok');

  /// RemovePrepare means space prepared to remove, sync should be disabled
  static const DeletionLogRecordStatus RemovePrepare =
      DeletionLogRecordStatus._(1, _omitEnumNames ? '' : 'RemovePrepare');

  /// Remove means space should be removed
  static const DeletionLogRecordStatus Remove =
      DeletionLogRecordStatus._(2, _omitEnumNames ? '' : 'Remove');

  /// OwnershipChange
  static const DeletionLogRecordStatus OwnershipChange =
      DeletionLogRecordStatus._(3, _omitEnumNames ? '' : 'OwnershipChange');

  static const $core.List<DeletionLogRecordStatus> values =
      <DeletionLogRecordStatus>[
    Ok,
    RemovePrepare,
    Remove,
    OwnershipChange,
  ];

  static final $core.List<DeletionLogRecordStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static DeletionLogRecordStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeletionLogRecordStatus._(super.value, super.name);
}

class AclEventLogRecordType extends $pb.ProtobufEnum {
  static const AclEventLogRecordType RecordTypeSpaceReceipt =
      AclEventLogRecordType._(
          0, _omitEnumNames ? '' : 'RecordTypeSpaceReceipt');
  static const AclEventLogRecordType RecordTypeSpaceShared =
      AclEventLogRecordType._(1, _omitEnumNames ? '' : 'RecordTypeSpaceShared');
  static const AclEventLogRecordType RecordTypeSpaceUnshared =
      AclEventLogRecordType._(
          2, _omitEnumNames ? '' : 'RecordTypeSpaceUnshared');
  static const AclEventLogRecordType RecordTypeSpaceAclAddRecord =
      AclEventLogRecordType._(
          3, _omitEnumNames ? '' : 'RecordTypeSpaceAclAddRecord');

  static const $core.List<AclEventLogRecordType> values =
      <AclEventLogRecordType>[
    RecordTypeSpaceReceipt,
    RecordTypeSpaceShared,
    RecordTypeSpaceUnshared,
    RecordTypeSpaceAclAddRecord,
  ];

  static final $core.List<AclEventLogRecordType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static AclEventLogRecordType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AclEventLogRecordType._(super.value, super.name);
}

/// Inbox Message
class InboxPacketType extends $pb.ProtobufEnum {
  static const InboxPacketType Default =
      InboxPacketType._(0, _omitEnumNames ? '' : 'Default');

  static const $core.List<InboxPacketType> values = <InboxPacketType>[
    Default,
  ];

  static final $core.List<InboxPacketType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static InboxPacketType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InboxPacketType._(super.value, super.name);
}

class InboxKeyType extends $pb.ProtobufEnum {
  static const InboxKeyType ed25519 =
      InboxKeyType._(0, _omitEnumNames ? '' : 'ed25519');

  static const $core.List<InboxKeyType> values = <InboxKeyType>[
    ed25519,
  ];

  static final $core.List<InboxKeyType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static InboxKeyType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InboxKeyType._(super.value, super.name);
}

class InboxPayloadType extends $pb.ProtobufEnum {
  static const InboxPayloadType InboxPayloadOneToOneInvite =
      InboxPayloadType._(0, _omitEnumNames ? '' : 'InboxPayloadOneToOneInvite');

  static const $core.List<InboxPayloadType> values = <InboxPayloadType>[
    InboxPayloadOneToOneInvite,
  ];

  static final $core.List<InboxPayloadType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static InboxPayloadType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InboxPayloadType._(super.value, super.name);
}

/// Enum for event types
class NotifyEventType extends $pb.ProtobufEnum {
  static const NotifyEventType UnspecifiedEvent =
      NotifyEventType._(0, _omitEnumNames ? '' : 'UnspecifiedEvent');
  static const NotifyEventType InboxNewMessageEvent =
      NotifyEventType._(1, _omitEnumNames ? '' : 'InboxNewMessageEvent');
  static const NotifyEventType NetworkConfigChangedEvent =
      NotifyEventType._(2, _omitEnumNames ? '' : 'NetworkConfigChangedEvent');

  static const $core.List<NotifyEventType> values = <NotifyEventType>[
    UnspecifiedEvent,
    InboxNewMessageEvent,
    NetworkConfigChangedEvent,
  ];

  static final $core.List<NotifyEventType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static NotifyEventType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const NotifyEventType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
