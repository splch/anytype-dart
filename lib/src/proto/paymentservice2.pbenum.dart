// This is a generated file - do not edit.
//
// Generated from paymentservice2.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MembershipV2_PaymentProvider extends $pb.ProtobufEnum {
  static const MembershipV2_PaymentProvider None =
      MembershipV2_PaymentProvider._(0, _omitEnumNames ? '' : 'None');
  static const MembershipV2_PaymentProvider Stripe =
      MembershipV2_PaymentProvider._(1, _omitEnumNames ? '' : 'Stripe');
  static const MembershipV2_PaymentProvider Crypto =
      MembershipV2_PaymentProvider._(2, _omitEnumNames ? '' : 'Crypto');
  static const MembershipV2_PaymentProvider BillingPortal =
      MembershipV2_PaymentProvider._(3, _omitEnumNames ? '' : 'BillingPortal');
  static const MembershipV2_PaymentProvider AppStore =
      MembershipV2_PaymentProvider._(4, _omitEnumNames ? '' : 'AppStore');
  static const MembershipV2_PaymentProvider GooglePlay =
      MembershipV2_PaymentProvider._(5, _omitEnumNames ? '' : 'GooglePlay');

  static const $core.List<MembershipV2_PaymentProvider> values =
      <MembershipV2_PaymentProvider>[
    None,
    Stripe,
    Crypto,
    BillingPortal,
    AppStore,
    GooglePlay,
  ];

  static final $core.List<MembershipV2_PaymentProvider?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static MembershipV2_PaymentProvider? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_PaymentProvider._(super.value, super.name);
}

class MembershipV2_Period extends $pb.ProtobufEnum {
  static const MembershipV2_Period Unlimited =
      MembershipV2_Period._(0, _omitEnumNames ? '' : 'Unlimited');
  static const MembershipV2_Period Monthly =
      MembershipV2_Period._(1, _omitEnumNames ? '' : 'Monthly');
  static const MembershipV2_Period Yearly =
      MembershipV2_Period._(2, _omitEnumNames ? '' : 'Yearly');
  static const MembershipV2_Period ThreeYears =
      MembershipV2_Period._(3, _omitEnumNames ? '' : 'ThreeYears');

  static const $core.List<MembershipV2_Period> values = <MembershipV2_Period>[
    Unlimited,
    Monthly,
    Yearly,
    ThreeYears,
  ];

  static final $core.List<MembershipV2_Period?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static MembershipV2_Period? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_Period._(super.value, super.name);
}

class MembershipV2_Platform extends $pb.ProtobufEnum {
  static const MembershipV2_Platform Unknown =
      MembershipV2_Platform._(0, _omitEnumNames ? '' : 'Unknown');
  static const MembershipV2_Platform Desktop =
      MembershipV2_Platform._(1, _omitEnumNames ? '' : 'Desktop');
  static const MembershipV2_Platform MobileIOS =
      MembershipV2_Platform._(2, _omitEnumNames ? '' : 'MobileIOS');
  static const MembershipV2_Platform MobileAndroid =
      MembershipV2_Platform._(3, _omitEnumNames ? '' : 'MobileAndroid');
  static const MembershipV2_Platform Web =
      MembershipV2_Platform._(4, _omitEnumNames ? '' : 'Web');

  static const $core.List<MembershipV2_Platform> values =
      <MembershipV2_Platform>[
    Unknown,
    Desktop,
    MobileIOS,
    MobileAndroid,
    Web,
  ];

  static final $core.List<MembershipV2_Platform?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static MembershipV2_Platform? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_Platform._(super.value, super.name);
}

class MembershipV2_ProductStatus_Status extends $pb.ProtobufEnum {
  static const MembershipV2_ProductStatus_Status StatusUnknown =
      MembershipV2_ProductStatus_Status._(
          0, _omitEnumNames ? '' : 'StatusUnknown');
  static const MembershipV2_ProductStatus_Status StatusPending =
      MembershipV2_ProductStatus_Status._(
          1, _omitEnumNames ? '' : 'StatusPending');
  static const MembershipV2_ProductStatus_Status StatusActive =
      MembershipV2_ProductStatus_Status._(
          2, _omitEnumNames ? '' : 'StatusActive');
  static const MembershipV2_ProductStatus_Status
      StatusPendingRequiresFinalization = MembershipV2_ProductStatus_Status._(
          3, _omitEnumNames ? '' : 'StatusPendingRequiresFinalization');

  static const $core.List<MembershipV2_ProductStatus_Status> values =
      <MembershipV2_ProductStatus_Status>[
    StatusUnknown,
    StatusPending,
    StatusActive,
    StatusPendingRequiresFinalization,
  ];

  static final $core.List<MembershipV2_ProductStatus_Status?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static MembershipV2_ProductStatus_Status? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_ProductStatus_Status._(super.value, super.name);
}

class MembershipV2_Invoice_Status extends $pb.ProtobufEnum {
  static const MembershipV2_Invoice_Status Unpaid =
      MembershipV2_Invoice_Status._(0, _omitEnumNames ? '' : 'Unpaid');
  static const MembershipV2_Invoice_Status Paid =
      MembershipV2_Invoice_Status._(1, _omitEnumNames ? '' : 'Paid');

  static const $core.List<MembershipV2_Invoice_Status> values =
      <MembershipV2_Invoice_Status>[
    Unpaid,
    Paid,
  ];

  static final $core.List<MembershipV2_Invoice_Status?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static MembershipV2_Invoice_Status? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_Invoice_Status._(super.value, super.name);
}

class MembershipV2_AnyNameIsValidResponse_Code extends $pb.ProtobufEnum {
  static const MembershipV2_AnyNameIsValidResponse_Code Valid =
      MembershipV2_AnyNameIsValidResponse_Code._(
          0, _omitEnumNames ? '' : 'Valid');
  static const MembershipV2_AnyNameIsValidResponse_Code NoDotAny =
      MembershipV2_AnyNameIsValidResponse_Code._(
          1, _omitEnumNames ? '' : 'NoDotAny');
  static const MembershipV2_AnyNameIsValidResponse_Code TooShort =
      MembershipV2_AnyNameIsValidResponse_Code._(
          2, _omitEnumNames ? '' : 'TooShort');
  static const MembershipV2_AnyNameIsValidResponse_Code TooLong =
      MembershipV2_AnyNameIsValidResponse_Code._(
          3, _omitEnumNames ? '' : 'TooLong');
  static const MembershipV2_AnyNameIsValidResponse_Code HasInvalidChars =
      MembershipV2_AnyNameIsValidResponse_Code._(
          4, _omitEnumNames ? '' : 'HasInvalidChars');
  static const MembershipV2_AnyNameIsValidResponse_Code AccountHasNoName =
      MembershipV2_AnyNameIsValidResponse_Code._(
          5, _omitEnumNames ? '' : 'AccountHasNoName');
  static const MembershipV2_AnyNameIsValidResponse_Code CanNotReserve =
      MembershipV2_AnyNameIsValidResponse_Code._(
          6, _omitEnumNames ? '' : 'CanNotReserve');

  static const $core.List<MembershipV2_AnyNameIsValidResponse_Code> values =
      <MembershipV2_AnyNameIsValidResponse_Code>[
    Valid,
    NoDotAny,
    TooShort,
    TooLong,
    HasInvalidChars,
    AccountHasNoName,
    CanNotReserve,
  ];

  static final $core.List<MembershipV2_AnyNameIsValidResponse_Code?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MembershipV2_AnyNameIsValidResponse_Code? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MembershipV2_AnyNameIsValidResponse_Code._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
