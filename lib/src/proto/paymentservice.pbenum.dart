// This is a generated file - do not edit.
//
// Generated from paymentservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// TODO:
/// later we will have an interface to enumerate all available tiers
/// it's a bad idea to list them here, because interface will be changed often
class SubscriptionTier extends $pb.ProtobufEnum {
  static const SubscriptionTier TierUnknown =
      SubscriptionTier._(0, _omitEnumNames ? '' : 'TierUnknown');

  /// "free" tier
  static const SubscriptionTier TierExplorer =
      SubscriptionTier._(1, _omitEnumNames ? '' : 'TierExplorer');

  /// these can be used just for testing in debug mode
  /// it will still create an active subscription, but with NO features
  static const SubscriptionTier TierBuilder1WeekTEST =
      SubscriptionTier._(2, _omitEnumNames ? '' : 'TierBuilder1WeekTEST');
  static const SubscriptionTier TierCoCreator1WeekTEST =
      SubscriptionTier._(3, _omitEnumNames ? '' : 'TierCoCreator1WeekTEST');

  /// these are the real tiers:
  static const SubscriptionTier TierBuilder1Year =
      SubscriptionTier._(4, _omitEnumNames ? '' : 'TierBuilder1Year');
  static const SubscriptionTier TierCoCreator1Year =
      SubscriptionTier._(5, _omitEnumNames ? '' : 'TierCoCreator1Year');
  static const SubscriptionTier TierBuilderPlus =
      SubscriptionTier._(6, _omitEnumNames ? '' : 'TierBuilderPlus');
  static const SubscriptionTier TierAnytypeTeam =
      SubscriptionTier._(7, _omitEnumNames ? '' : 'TierAnytypeTeam');

  static const $core.List<SubscriptionTier> values = <SubscriptionTier>[
    TierUnknown,
    TierExplorer,
    TierBuilder1WeekTEST,
    TierCoCreator1WeekTEST,
    TierBuilder1Year,
    TierCoCreator1Year,
    TierBuilderPlus,
    TierAnytypeTeam,
  ];

  static final $core.List<SubscriptionTier?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static SubscriptionTier? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubscriptionTier._(super.value, super.name);
}

class SubscriptionStatus extends $pb.ProtobufEnum {
  static const SubscriptionStatus StatusUnknown =
      SubscriptionStatus._(0, _omitEnumNames ? '' : 'StatusUnknown');

  /// payment is still pending
  /// this will be the status until the payment is confirmed or N is elapsed and no payment is received
  /// in the last case the subscription will switch to Status_Unknown or Status_Active
  static const SubscriptionStatus StatusPending =
      SubscriptionStatus._(1, _omitEnumNames ? '' : 'StatusPending');
  static const SubscriptionStatus StatusActive =
      SubscriptionStatus._(2, _omitEnumNames ? '' : 'StatusActive');

  /// when buying from other side - some data is missing in the Subscription
  /// we need to provide additional data after the payment
  /// please call FinalizeSubscription to fill-in needed fields
  static const SubscriptionStatus StatusPendingRequiresFinalization =
      SubscriptionStatus._(
          3, _omitEnumNames ? '' : 'StatusPendingRequiresFinalization');

  static const $core.List<SubscriptionStatus> values = <SubscriptionStatus>[
    StatusUnknown,
    StatusPending,
    StatusActive,
    StatusPendingRequiresFinalization,
  ];

  static final $core.List<SubscriptionStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SubscriptionStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SubscriptionStatus._(super.value, super.name);
}

class PaymentMethod extends $pb.ProtobufEnum {
  static const PaymentMethod MethodCard =
      PaymentMethod._(0, _omitEnumNames ? '' : 'MethodCard');
  static const PaymentMethod MethodCrypto =
      PaymentMethod._(1, _omitEnumNames ? '' : 'MethodCrypto');
  static const PaymentMethod MethodApplePay =
      PaymentMethod._(2, _omitEnumNames ? '' : 'MethodApplePay');
  static const PaymentMethod MethodGooglePay =
      PaymentMethod._(3, _omitEnumNames ? '' : 'MethodGooglePay');
  static const PaymentMethod MethodAppleInapp =
      PaymentMethod._(4, _omitEnumNames ? '' : 'MethodAppleInapp');
  static const PaymentMethod MethodGoogleInapp =
      PaymentMethod._(5, _omitEnumNames ? '' : 'MethodGoogleInapp');
  static const PaymentMethod MethodNone =
      PaymentMethod._(6, _omitEnumNames ? '' : 'MethodNone');

  static const $core.List<PaymentMethod> values = <PaymentMethod>[
    MethodCard,
    MethodCrypto,
    MethodApplePay,
    MethodGooglePay,
    MethodAppleInapp,
    MethodGoogleInapp,
    MethodNone,
  ];

  static final $core.List<PaymentMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static PaymentMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PaymentMethod._(super.value, super.name);
}

class ErrorCodes extends $pb.ProtobufEnum {
  static const ErrorCodes Unexpected =
      ErrorCodes._(0, _omitEnumNames ? '' : 'Unexpected');
  static const ErrorCodes EthAddressEmpty =
      ErrorCodes._(1, _omitEnumNames ? '' : 'EthAddressEmpty');
  static const ErrorCodes InvalidSignature =
      ErrorCodes._(2, _omitEnumNames ? '' : 'InvalidSignature');
  static const ErrorCodes TierWrong =
      ErrorCodes._(3, _omitEnumNames ? '' : 'TierWrong');
  static const ErrorCodes TierNotFound =
      ErrorCodes._(4, _omitEnumNames ? '' : 'TierNotFound');
  static const ErrorCodes TierInactive =
      ErrorCodes._(5, _omitEnumNames ? '' : 'TierInactive');
  static const ErrorCodes PaymentMethodWrong =
      ErrorCodes._(6, _omitEnumNames ? '' : 'PaymentMethodWrong');
  static const ErrorCodes BadAnyName =
      ErrorCodes._(7, _omitEnumNames ? '' : 'BadAnyName');
  static const ErrorCodes Unknown =
      ErrorCodes._(8, _omitEnumNames ? '' : 'Unknown');
  static const ErrorCodes SubsAlreadyActive =
      ErrorCodes._(9, _omitEnumNames ? '' : 'SubsAlreadyActive');
  static const ErrorCodes SubsNotFound =
      ErrorCodes._(10, _omitEnumNames ? '' : 'SubsNotFound');
  static const ErrorCodes SubsWrongState =
      ErrorCodes._(11, _omitEnumNames ? '' : 'SubsWrongState');
  static const ErrorCodes EmailWrongFormat =
      ErrorCodes._(12, _omitEnumNames ? '' : 'EmailWrongFormat');
  static const ErrorCodes EmailAlreadyVerified =
      ErrorCodes._(13, _omitEnumNames ? '' : 'EmailAlreadyVerified');
  static const ErrorCodes EmailAlreadySent =
      ErrorCodes._(14, _omitEnumNames ? '' : 'EmailAlreadySent');
  static const ErrorCodes EmailFailedToSend =
      ErrorCodes._(15, _omitEnumNames ? '' : 'EmailFailedToSend');
  static const ErrorCodes EmailExpired =
      ErrorCodes._(16, _omitEnumNames ? '' : 'EmailExpired');
  static const ErrorCodes EmailWrongCode =
      ErrorCodes._(17, _omitEnumNames ? '' : 'EmailWrongCode');
  static const ErrorCodes AppleInvalidReceipt =
      ErrorCodes._(18, _omitEnumNames ? '' : 'AppleInvalidReceipt');
  static const ErrorCodes ApplePurchaseRegistration =
      ErrorCodes._(19, _omitEnumNames ? '' : 'ApplePurchaseRegistration');
  static const ErrorCodes AppleSubscriptionRenew =
      ErrorCodes._(20, _omitEnumNames ? '' : 'AppleSubscriptionRenew');
  static const ErrorCodes CodeNotFound =
      ErrorCodes._(21, _omitEnumNames ? '' : 'CodeNotFound');
  static const ErrorCodes CodeAlreadyUsed =
      ErrorCodes._(22, _omitEnumNames ? '' : 'CodeAlreadyUsed');
  static const ErrorCodes ErrorOffset =
      ErrorCodes._(600, _omitEnumNames ? '' : 'ErrorOffset');

  static const $core.List<ErrorCodes> values = <ErrorCodes>[
    Unexpected,
    EthAddressEmpty,
    InvalidSignature,
    TierWrong,
    TierNotFound,
    TierInactive,
    PaymentMethodWrong,
    BadAnyName,
    Unknown,
    SubsAlreadyActive,
    SubsNotFound,
    SubsWrongState,
    EmailWrongFormat,
    EmailAlreadyVerified,
    EmailAlreadySent,
    EmailFailedToSend,
    EmailExpired,
    EmailWrongCode,
    AppleInvalidReceipt,
    ApplePurchaseRegistration,
    AppleSubscriptionRenew,
    CodeNotFound,
    CodeAlreadyUsed,
    ErrorOffset,
  ];

  static final $core.Map<$core.int, ErrorCodes> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ErrorCodes? valueOf($core.int value) => _byValue[value];

  const ErrorCodes._(super.value, super.name);
}

class IsNameValidResponse_Code extends $pb.ProtobufEnum {
  static const IsNameValidResponse_Code Valid =
      IsNameValidResponse_Code._(0, _omitEnumNames ? '' : 'Valid');
  static const IsNameValidResponse_Code NoDotAny =
      IsNameValidResponse_Code._(1, _omitEnumNames ? '' : 'NoDotAny');
  static const IsNameValidResponse_Code TooShort =
      IsNameValidResponse_Code._(2, _omitEnumNames ? '' : 'TooShort');
  static const IsNameValidResponse_Code TooLong =
      IsNameValidResponse_Code._(3, _omitEnumNames ? '' : 'TooLong');
  static const IsNameValidResponse_Code HasInvalidChars =
      IsNameValidResponse_Code._(4, _omitEnumNames ? '' : 'HasInvalidChars');
  static const IsNameValidResponse_Code TierFeatureNoName =
      IsNameValidResponse_Code._(5, _omitEnumNames ? '' : 'TierFeatureNoName');
  static const IsNameValidResponse_Code CanNotReserve =
      IsNameValidResponse_Code._(6, _omitEnumNames ? '' : 'CanNotReserve');

  static const $core.List<IsNameValidResponse_Code> values =
      <IsNameValidResponse_Code>[
    Valid,
    NoDotAny,
    TooShort,
    TooLong,
    HasInvalidChars,
    TierFeatureNoName,
    CanNotReserve,
  ];

  static final $core.List<IsNameValidResponse_Code?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static IsNameValidResponse_Code? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IsNameValidResponse_Code._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
