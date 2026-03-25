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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'paymentservice.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'paymentservice.pbenum.dart';

class GetSubscriptionRequest extends $pb.GeneratedMessage {
  factory GetSubscriptionRequest({
    $core.String? ownerAnyID,
  }) {
    final result = create();
    if (ownerAnyID != null) result.ownerAnyID = ownerAnyID;
    return result;
  }

  GetSubscriptionRequest._();

  factory GetSubscriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyID', protoName: 'ownerAnyID')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequest copyWith(
          void Function(GetSubscriptionRequest) updates) =>
      super.copyWith((message) => updates(message as GetSubscriptionRequest))
          as GetSubscriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequest create() => GetSubscriptionRequest._();
  @$core.override
  GetSubscriptionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionRequest>(create);
  static GetSubscriptionRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyID => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyID($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyID() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyID() => $_clearField(1);
}

class GetSubscriptionRequestSigned extends $pb.GeneratedMessage {
  factory GetSubscriptionRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  GetSubscriptionRequestSigned._();

  factory GetSubscriptionRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionRequestSigned copyWith(
          void Function(GetSubscriptionRequestSigned) updates) =>
      super.copyWith(
              (message) => updates(message as GetSubscriptionRequestSigned))
          as GetSubscriptionRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequestSigned create() =>
      GetSubscriptionRequestSigned._();
  @$core.override
  GetSubscriptionRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionRequestSigned>(create);
  static GetSubscriptionRequestSigned? _defaultInstance;

  /// GetSubscriptionRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class GetSubscriptionResponse extends $pb.GeneratedMessage {
  factory GetSubscriptionResponse({
    $core.int? tier,
    SubscriptionStatus? status,
    $fixnum.Int64? dateStarted,
    $fixnum.Int64? dateEnds,
    $core.bool? isAutoRenew,
    PaymentMethod? paymentMethod,
    $core.String? requestedAnyName,
    $core.String? userEmail,
    $core.bool? subscribeToNewsletter,
  }) {
    final result = create();
    if (tier != null) result.tier = tier;
    if (status != null) result.status = status;
    if (dateStarted != null) result.dateStarted = dateStarted;
    if (dateEnds != null) result.dateEnds = dateEnds;
    if (isAutoRenew != null) result.isAutoRenew = isAutoRenew;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    if (userEmail != null) result.userEmail = userEmail;
    if (subscribeToNewsletter != null)
      result.subscribeToNewsletter = subscribeToNewsletter;
    return result;
  }

  GetSubscriptionResponse._();

  factory GetSubscriptionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionResponse',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'tier', fieldType: $pb.PbFieldType.OU3)
    ..aE<SubscriptionStatus>(2, _omitFieldNames ? '' : 'status',
        enumValues: SubscriptionStatus.values)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'dateStarted', $pb.PbFieldType.OU6,
        protoName: 'dateStarted', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'dateEnds', $pb.PbFieldType.OU6,
        protoName: 'dateEnds', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(5, _omitFieldNames ? '' : 'isAutoRenew', protoName: 'isAutoRenew')
    ..aE<PaymentMethod>(6, _omitFieldNames ? '' : 'paymentMethod',
        protoName: 'paymentMethod', enumValues: PaymentMethod.values)
    ..aOS(7, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..aOS(8, _omitFieldNames ? '' : 'userEmail', protoName: 'userEmail')
    ..aOB(9, _omitFieldNames ? '' : 'subscribeToNewsletter',
        protoName: 'subscribeToNewsletter')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionResponse copyWith(
          void Function(GetSubscriptionResponse) updates) =>
      super.copyWith((message) => updates(message as GetSubscriptionResponse))
          as GetSubscriptionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionResponse create() => GetSubscriptionResponse._();
  @$core.override
  GetSubscriptionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionResponse>(create);
  static GetSubscriptionResponse? _defaultInstance;

  /// was SubscriptionTier before, changed to uint32 to allow us to use dynamic tiers
  @$pb.TagNumber(1)
  $core.int get tier => $_getIZ(0);
  @$pb.TagNumber(1)
  set tier($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => $_clearField(1);

  @$pb.TagNumber(2)
  SubscriptionStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(SubscriptionStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get dateStarted => $_getI64(2);
  @$pb.TagNumber(3)
  set dateStarted($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDateStarted() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateStarted() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get dateEnds => $_getI64(3);
  @$pb.TagNumber(4)
  set dateEnds($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDateEnds() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateEnds() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isAutoRenew => $_getBF(4);
  @$pb.TagNumber(5)
  set isAutoRenew($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsAutoRenew() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsAutoRenew() => $_clearField(5);

  @$pb.TagNumber(6)
  PaymentMethod get paymentMethod => $_getN(5);
  @$pb.TagNumber(6)
  set paymentMethod(PaymentMethod value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPaymentMethod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentMethod() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get requestedAnyName => $_getSZ(6);
  @$pb.TagNumber(7)
  set requestedAnyName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRequestedAnyName() => $_has(6);
  @$pb.TagNumber(7)
  void clearRequestedAnyName() => $_clearField(7);

  /// if user verified her email OR provided it while buying a subscription, it will be here
  @$pb.TagNumber(8)
  $core.String get userEmail => $_getSZ(7);
  @$pb.TagNumber(8)
  set userEmail($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUserEmail() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserEmail() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get subscribeToNewsletter => $_getBF(8);
  @$pb.TagNumber(9)
  set subscribeToNewsletter($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSubscribeToNewsletter() => $_has(8);
  @$pb.TagNumber(9)
  void clearSubscribeToNewsletter() => $_clearField(9);
}

class BuySubscriptionRequest extends $pb.GeneratedMessage {
  factory BuySubscriptionRequest({
    $core.String? ownerAnyId,
    $core.String? ownerEthAddress,
    $core.int? requestedTier,
    PaymentMethod? paymentMethod,
    $core.String? requestedAnyName,
    $core.String? userEmail,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (requestedTier != null) result.requestedTier = requestedTier;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    if (userEmail != null) result.userEmail = userEmail;
    return result;
  }

  BuySubscriptionRequest._();

  factory BuySubscriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuySubscriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuySubscriptionRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aI(3, _omitFieldNames ? '' : 'requestedTier',
        protoName: 'requestedTier', fieldType: $pb.PbFieldType.OU3)
    ..aE<PaymentMethod>(4, _omitFieldNames ? '' : 'paymentMethod',
        protoName: 'paymentMethod', enumValues: PaymentMethod.values)
    ..aOS(5, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..aOS(6, _omitFieldNames ? '' : 'userEmail', protoName: 'userEmail')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionRequest copyWith(
          void Function(BuySubscriptionRequest) updates) =>
      super.copyWith((message) => updates(message as BuySubscriptionRequest))
          as BuySubscriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuySubscriptionRequest create() => BuySubscriptionRequest._();
  @$core.override
  BuySubscriptionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuySubscriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuySubscriptionRequest>(create);
  static BuySubscriptionRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// this is the owner's main EOA (Externally Owned Account) address
  /// not AccountAbstraction's SCW (Smart Contract Wallet) address!
  /// this is required to reserve a name for the owner (later that is done by user)
  /// in the following format: "0x7a250d5630b4cf539739df2c5dacb4c659f2488d"
  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);

  /// was SubscriptionTier before, changed to uint32 to allow us to use dynamic tiers
  @$pb.TagNumber(3)
  $core.int get requestedTier => $_getIZ(2);
  @$pb.TagNumber(3)
  set requestedTier($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestedTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedTier() => $_clearField(3);

  @$pb.TagNumber(4)
  PaymentMethod get paymentMethod => $_getN(3);
  @$pb.TagNumber(4)
  set paymentMethod(PaymentMethod value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentMethod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentMethod() => $_clearField(4);

  /// if empty - then no name requested
  /// if non-empty - PP node will register that name on behalf of the user
  @$pb.TagNumber(5)
  $core.String get requestedAnyName => $_getSZ(4);
  @$pb.TagNumber(5)
  set requestedAnyName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRequestedAnyName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequestedAnyName() => $_clearField(5);

  /// for some payment methods we need to know the user's email
  @$pb.TagNumber(6)
  $core.String get userEmail => $_getSZ(5);
  @$pb.TagNumber(6)
  set userEmail($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUserEmail() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserEmail() => $_clearField(6);
}

class BuySubscriptionRequestSigned extends $pb.GeneratedMessage {
  factory BuySubscriptionRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  BuySubscriptionRequestSigned._();

  factory BuySubscriptionRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuySubscriptionRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuySubscriptionRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionRequestSigned copyWith(
          void Function(BuySubscriptionRequestSigned) updates) =>
      super.copyWith(
              (message) => updates(message as BuySubscriptionRequestSigned))
          as BuySubscriptionRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuySubscriptionRequestSigned create() =>
      BuySubscriptionRequestSigned._();
  @$core.override
  BuySubscriptionRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuySubscriptionRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuySubscriptionRequestSigned>(create);
  static BuySubscriptionRequestSigned? _defaultInstance;

  /// BuySubscriptionRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class BuySubscriptionResponse extends $pb.GeneratedMessage {
  factory BuySubscriptionResponse({
    $core.String? paymentUrl,
    $core.String? billingID,
  }) {
    final result = create();
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    if (billingID != null) result.billingID = billingID;
    return result;
  }

  BuySubscriptionResponse._();

  factory BuySubscriptionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuySubscriptionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuySubscriptionResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentUrl', protoName: 'paymentUrl')
    ..aOS(2, _omitFieldNames ? '' : 'billingID', protoName: 'billingID')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuySubscriptionResponse copyWith(
          void Function(BuySubscriptionResponse) updates) =>
      super.copyWith((message) => updates(message as BuySubscriptionResponse))
          as BuySubscriptionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuySubscriptionResponse create() => BuySubscriptionResponse._();
  @$core.override
  BuySubscriptionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuySubscriptionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuySubscriptionResponse>(create);
  static BuySubscriptionResponse? _defaultInstance;

  /// will feature current billing ID
  /// stripe.com/?client_reference_id=1234
  @$pb.TagNumber(1)
  $core.String get paymentUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentUrl() => $_clearField(1);

  /// billingID is passed via mobile client to payment platform
  @$pb.TagNumber(2)
  $core.String get billingID => $_getSZ(1);
  @$pb.TagNumber(2)
  set billingID($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBillingID() => $_has(1);
  @$pb.TagNumber(2)
  void clearBillingID() => $_clearField(2);
}

class FinalizeSubscriptionRequest extends $pb.GeneratedMessage {
  factory FinalizeSubscriptionRequest({
    $core.String? ownerAnyId,
    $core.String? ownerEthAddress,
    $core.String? requestedAnyName,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    return result;
  }

  FinalizeSubscriptionRequest._();

  factory FinalizeSubscriptionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinalizeSubscriptionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinalizeSubscriptionRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(3, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionRequest copyWith(
          void Function(FinalizeSubscriptionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FinalizeSubscriptionRequest))
          as FinalizeSubscriptionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionRequest create() =>
      FinalizeSubscriptionRequest._();
  @$core.override
  FinalizeSubscriptionRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinalizeSubscriptionRequest>(create);
  static FinalizeSubscriptionRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// this is the owner's main EOA (Externally Owned Account) address
  /// not AccountAbstraction's SCW (Smart Contract Wallet) address!
  /// this is required to reserve a name for the owner (later that is done by user)
  /// in the following format: "0x7a250d5630b4cf539739df2c5dacb4c659f2488d"
  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);

  /// if empty - then no name requested
  @$pb.TagNumber(3)
  $core.String get requestedAnyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestedAnyName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestedAnyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedAnyName() => $_clearField(3);
}

class FinalizeSubscriptionResponse extends $pb.GeneratedMessage {
  factory FinalizeSubscriptionResponse() => create();

  FinalizeSubscriptionResponse._();

  factory FinalizeSubscriptionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinalizeSubscriptionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinalizeSubscriptionResponse',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionResponse copyWith(
          void Function(FinalizeSubscriptionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FinalizeSubscriptionResponse))
          as FinalizeSubscriptionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionResponse create() =>
      FinalizeSubscriptionResponse._();
  @$core.override
  FinalizeSubscriptionResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinalizeSubscriptionResponse>(create);
  static FinalizeSubscriptionResponse? _defaultInstance;
}

class FinalizeSubscriptionRequestSigned extends $pb.GeneratedMessage {
  factory FinalizeSubscriptionRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  FinalizeSubscriptionRequestSigned._();

  factory FinalizeSubscriptionRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FinalizeSubscriptionRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FinalizeSubscriptionRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FinalizeSubscriptionRequestSigned copyWith(
          void Function(FinalizeSubscriptionRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as FinalizeSubscriptionRequestSigned))
          as FinalizeSubscriptionRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionRequestSigned create() =>
      FinalizeSubscriptionRequestSigned._();
  @$core.override
  FinalizeSubscriptionRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FinalizeSubscriptionRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FinalizeSubscriptionRequestSigned>(
          create);
  static FinalizeSubscriptionRequestSigned? _defaultInstance;

  /// VerifyEmailRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class GetSubscriptionPortalLinkRequest extends $pb.GeneratedMessage {
  factory GetSubscriptionPortalLinkRequest({
    $core.String? ownerAnyId,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    return result;
  }

  GetSubscriptionPortalLinkRequest._();

  factory GetSubscriptionPortalLinkRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionPortalLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionPortalLinkRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkRequest copyWith(
          void Function(GetSubscriptionPortalLinkRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSubscriptionPortalLinkRequest))
          as GetSubscriptionPortalLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkRequest create() =>
      GetSubscriptionPortalLinkRequest._();
  @$core.override
  GetSubscriptionPortalLinkRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionPortalLinkRequest>(
          create);
  static GetSubscriptionPortalLinkRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);
}

class GetSubscriptionPortalLinkRequestSigned extends $pb.GeneratedMessage {
  factory GetSubscriptionPortalLinkRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  GetSubscriptionPortalLinkRequestSigned._();

  factory GetSubscriptionPortalLinkRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionPortalLinkRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionPortalLinkRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkRequestSigned copyWith(
          void Function(GetSubscriptionPortalLinkRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as GetSubscriptionPortalLinkRequestSigned))
          as GetSubscriptionPortalLinkRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkRequestSigned create() =>
      GetSubscriptionPortalLinkRequestSigned._();
  @$core.override
  GetSubscriptionPortalLinkRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkRequestSigned getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetSubscriptionPortalLinkRequestSigned>(create);
  static GetSubscriptionPortalLinkRequestSigned? _defaultInstance;

  /// GetSubscriptionPortalLinkRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class GetSubscriptionPortalLinkResponse extends $pb.GeneratedMessage {
  factory GetSubscriptionPortalLinkResponse({
    $core.String? portalUrl,
  }) {
    final result = create();
    if (portalUrl != null) result.portalUrl = portalUrl;
    return result;
  }

  GetSubscriptionPortalLinkResponse._();

  factory GetSubscriptionPortalLinkResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSubscriptionPortalLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSubscriptionPortalLinkResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'portalUrl', protoName: 'portalUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSubscriptionPortalLinkResponse copyWith(
          void Function(GetSubscriptionPortalLinkResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetSubscriptionPortalLinkResponse))
          as GetSubscriptionPortalLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkResponse create() =>
      GetSubscriptionPortalLinkResponse._();
  @$core.override
  GetSubscriptionPortalLinkResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetSubscriptionPortalLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSubscriptionPortalLinkResponse>(
          create);
  static GetSubscriptionPortalLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get portalUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set portalUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPortalUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortalUrl() => $_clearField(1);
}

class GetVerificationEmailRequest extends $pb.GeneratedMessage {
  factory GetVerificationEmailRequest({
    $core.String? ownerAnyId,
    $core.String? email,
    $core.bool? subscribeToNewsletter,
    $core.bool? insiderTipsAndTutorials,
    $core.bool? isOnboardingList,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (email != null) result.email = email;
    if (subscribeToNewsletter != null)
      result.subscribeToNewsletter = subscribeToNewsletter;
    if (insiderTipsAndTutorials != null)
      result.insiderTipsAndTutorials = insiderTipsAndTutorials;
    if (isOnboardingList != null) result.isOnboardingList = isOnboardingList;
    return result;
  }

  GetVerificationEmailRequest._();

  factory GetVerificationEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVerificationEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVerificationEmailRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOB(3, _omitFieldNames ? '' : 'subscribeToNewsletter',
        protoName: 'subscribeToNewsletter')
    ..aOB(4, _omitFieldNames ? '' : 'insiderTipsAndTutorials',
        protoName: 'insiderTipsAndTutorials')
    ..aOB(5, _omitFieldNames ? '' : 'isOnboardingList',
        protoName: 'isOnboardingList')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailRequest copyWith(
          void Function(GetVerificationEmailRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetVerificationEmailRequest))
          as GetVerificationEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailRequest create() =>
      GetVerificationEmailRequest._();
  @$core.override
  GetVerificationEmailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVerificationEmailRequest>(create);
  static GetVerificationEmailRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get subscribeToNewsletter => $_getBF(2);
  @$pb.TagNumber(3)
  set subscribeToNewsletter($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubscribeToNewsletter() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscribeToNewsletter() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get insiderTipsAndTutorials => $_getBF(3);
  @$pb.TagNumber(4)
  set insiderTipsAndTutorials($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInsiderTipsAndTutorials() => $_has(3);
  @$pb.TagNumber(4)
  void clearInsiderTipsAndTutorials() => $_clearField(4);

  /// if we are coming from the onboarding screen
  @$pb.TagNumber(5)
  $core.bool get isOnboardingList => $_getBF(4);
  @$pb.TagNumber(5)
  set isOnboardingList($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsOnboardingList() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsOnboardingList() => $_clearField(5);
}

class GetVerificationEmailResponse extends $pb.GeneratedMessage {
  factory GetVerificationEmailResponse() => create();

  GetVerificationEmailResponse._();

  factory GetVerificationEmailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVerificationEmailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVerificationEmailResponse',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailResponse copyWith(
          void Function(GetVerificationEmailResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetVerificationEmailResponse))
          as GetVerificationEmailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailResponse create() =>
      GetVerificationEmailResponse._();
  @$core.override
  GetVerificationEmailResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVerificationEmailResponse>(create);
  static GetVerificationEmailResponse? _defaultInstance;
}

class GetVerificationEmailRequestSigned extends $pb.GeneratedMessage {
  factory GetVerificationEmailRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  GetVerificationEmailRequestSigned._();

  factory GetVerificationEmailRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVerificationEmailRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVerificationEmailRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVerificationEmailRequestSigned copyWith(
          void Function(GetVerificationEmailRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as GetVerificationEmailRequestSigned))
          as GetVerificationEmailRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailRequestSigned create() =>
      GetVerificationEmailRequestSigned._();
  @$core.override
  GetVerificationEmailRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetVerificationEmailRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVerificationEmailRequestSigned>(
          create);
  static GetVerificationEmailRequestSigned? _defaultInstance;

  /// GetVerificationEmailRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class VerifyEmailRequest extends $pb.GeneratedMessage {
  factory VerifyEmailRequest({
    $core.String? ownerAnyId,
    $core.String? ownerEthAddress,
    $core.String? code,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (code != null) result.code = code;
    return result;
  }

  VerifyEmailRequest._();

  factory VerifyEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest copyWith(void Function(VerifyEmailRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailRequest))
          as VerifyEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest create() => VerifyEmailRequest._();
  @$core.override
  VerifyEmailRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailRequest>(create);
  static VerifyEmailRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// this is the owner's main EOA (Externally Owned Account) address
  /// not AccountAbstraction's SCW (Smart Contract Wallet) address!
  /// this is required to reserve a name for the owner (later that is done by user)
  /// in the following format: "0x7a250d5630b4cf539739df2c5dacb4c659f2488d"
  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);

  /// code received in the email
  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);
}

class VerifyEmailResponse extends $pb.GeneratedMessage {
  factory VerifyEmailResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  VerifyEmailResponse._();

  factory VerifyEmailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailResponse copyWith(void Function(VerifyEmailResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailResponse))
          as VerifyEmailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse create() => VerifyEmailResponse._();
  @$core.override
  VerifyEmailResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailResponse>(create);
  static VerifyEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class VerifyEmailRequestSigned extends $pb.GeneratedMessage {
  factory VerifyEmailRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  VerifyEmailRequestSigned._();

  factory VerifyEmailRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequestSigned copyWith(
          void Function(VerifyEmailRequestSigned) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailRequestSigned))
          as VerifyEmailRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequestSigned create() => VerifyEmailRequestSigned._();
  @$core.override
  VerifyEmailRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailRequestSigned>(create);
  static VerifyEmailRequestSigned? _defaultInstance;

  /// VerifyEmailRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class IsNameValidRequest extends $pb.GeneratedMessage {
  factory IsNameValidRequest({
    $core.int? requestedTier,
    $core.String? requestedAnyName,
  }) {
    final result = create();
    if (requestedTier != null) result.requestedTier = requestedTier;
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    return result;
  }

  IsNameValidRequest._();

  factory IsNameValidRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IsNameValidRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IsNameValidRequest',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'requestedTier',
        protoName: 'requestedTier', fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsNameValidRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsNameValidRequest copyWith(void Function(IsNameValidRequest) updates) =>
      super.copyWith((message) => updates(message as IsNameValidRequest))
          as IsNameValidRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IsNameValidRequest create() => IsNameValidRequest._();
  @$core.override
  IsNameValidRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IsNameValidRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IsNameValidRequest>(create);
  static IsNameValidRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get requestedTier => $_getIZ(0);
  @$pb.TagNumber(1)
  set requestedTier($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestedTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestedTier() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get requestedAnyName => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestedAnyName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequestedAnyName() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestedAnyName() => $_clearField(2);
}

class IsNameValidResponse extends $pb.GeneratedMessage {
  factory IsNameValidResponse({
    IsNameValidResponse_Code? code,
    $core.String? description,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (description != null) result.description = description;
    return result;
  }

  IsNameValidResponse._();

  factory IsNameValidResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IsNameValidResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IsNameValidResponse',
      createEmptyInstance: create)
    ..aE<IsNameValidResponse_Code>(1, _omitFieldNames ? '' : 'code',
        enumValues: IsNameValidResponse_Code.values)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsNameValidResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsNameValidResponse copyWith(void Function(IsNameValidResponse) updates) =>
      super.copyWith((message) => updates(message as IsNameValidResponse))
          as IsNameValidResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IsNameValidResponse create() => IsNameValidResponse._();
  @$core.override
  IsNameValidResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IsNameValidResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IsNameValidResponse>(create);
  static IsNameValidResponse? _defaultInstance;

  @$pb.TagNumber(1)
  IsNameValidResponse_Code get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(IsNameValidResponse_Code value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
}

class VerifyAppStoreReceiptRequest extends $pb.GeneratedMessage {
  factory VerifyAppStoreReceiptRequest({
    $core.String? ownerAnyId,
    $core.String? receipt,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (receipt != null) result.receipt = receipt;
    return result;
  }

  VerifyAppStoreReceiptRequest._();

  factory VerifyAppStoreReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyAppStoreReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyAppStoreReceiptRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'receipt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptRequest copyWith(
          void Function(VerifyAppStoreReceiptRequest) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyAppStoreReceiptRequest))
          as VerifyAppStoreReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptRequest create() =>
      VerifyAppStoreReceiptRequest._();
  @$core.override
  VerifyAppStoreReceiptRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyAppStoreReceiptRequest>(create);
  static VerifyAppStoreReceiptRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// receipt is a JWT-encoded information about subscription purchase
  @$pb.TagNumber(2)
  $core.String get receipt => $_getSZ(1);
  @$pb.TagNumber(2)
  set receipt($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceipt() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceipt() => $_clearField(2);
}

class VerifyAppStoreReceiptRequestSigned extends $pb.GeneratedMessage {
  factory VerifyAppStoreReceiptRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  VerifyAppStoreReceiptRequestSigned._();

  factory VerifyAppStoreReceiptRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyAppStoreReceiptRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyAppStoreReceiptRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptRequestSigned copyWith(
          void Function(VerifyAppStoreReceiptRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as VerifyAppStoreReceiptRequestSigned))
          as VerifyAppStoreReceiptRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptRequestSigned create() =>
      VerifyAppStoreReceiptRequestSigned._();
  @$core.override
  VerifyAppStoreReceiptRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyAppStoreReceiptRequestSigned>(
          create);
  static VerifyAppStoreReceiptRequestSigned? _defaultInstance;

  /// VerifyAppStoreReceiptRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class VerifyAppStoreReceiptResponse extends $pb.GeneratedMessage {
  factory VerifyAppStoreReceiptResponse() => create();

  VerifyAppStoreReceiptResponse._();

  factory VerifyAppStoreReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyAppStoreReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyAppStoreReceiptResponse',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyAppStoreReceiptResponse copyWith(
          void Function(VerifyAppStoreReceiptResponse) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyAppStoreReceiptResponse))
          as VerifyAppStoreReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptResponse create() =>
      VerifyAppStoreReceiptResponse._();
  @$core.override
  VerifyAppStoreReceiptResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyAppStoreReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyAppStoreReceiptResponse>(create);
  static VerifyAppStoreReceiptResponse? _defaultInstance;
}

class CodeGetInfoRequest extends $pb.GeneratedMessage {
  factory CodeGetInfoRequest({
    $core.String? ownerAnyId,
    $core.String? ownerEthAddress,
    $core.String? code,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (code != null) result.code = code;
    return result;
  }

  CodeGetInfoRequest._();

  factory CodeGetInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeGetInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeGetInfoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoRequest copyWith(void Function(CodeGetInfoRequest) updates) =>
      super.copyWith((message) => updates(message as CodeGetInfoRequest))
          as CodeGetInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeGetInfoRequest create() => CodeGetInfoRequest._();
  @$core.override
  CodeGetInfoRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeGetInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeGetInfoRequest>(create);
  static CodeGetInfoRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// this is the owner's main EOA (Externally Owned Account) address
  /// not AccountAbstraction's SCW (Smart Contract Wallet) address!
  /// this is required to reserve a name for the owner (later that is done by user)
  /// in the following format: "0x7a250d5630b4cf539739df2c5dacb4c659f2488d"
  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);

  /// code received in the email
  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);
}

class CodeGetInfoRequestSigned extends $pb.GeneratedMessage {
  factory CodeGetInfoRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  CodeGetInfoRequestSigned._();

  factory CodeGetInfoRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeGetInfoRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeGetInfoRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoRequestSigned copyWith(
          void Function(CodeGetInfoRequestSigned) updates) =>
      super.copyWith((message) => updates(message as CodeGetInfoRequestSigned))
          as CodeGetInfoRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeGetInfoRequestSigned create() => CodeGetInfoRequestSigned._();
  @$core.override
  CodeGetInfoRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeGetInfoRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeGetInfoRequestSigned>(create);
  static CodeGetInfoRequestSigned? _defaultInstance;

  /// CodeGetInfoRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class CodeGetInfoResponse extends $pb.GeneratedMessage {
  factory CodeGetInfoResponse({
    $core.int? tier,
  }) {
    final result = create();
    if (tier != null) result.tier = tier;
    return result;
  }

  CodeGetInfoResponse._();

  factory CodeGetInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeGetInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeGetInfoResponse',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'tier', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeGetInfoResponse copyWith(void Function(CodeGetInfoResponse) updates) =>
      super.copyWith((message) => updates(message as CodeGetInfoResponse))
          as CodeGetInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeGetInfoResponse create() => CodeGetInfoResponse._();
  @$core.override
  CodeGetInfoResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeGetInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeGetInfoResponse>(create);
  static CodeGetInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tier => $_getIZ(0);
  @$pb.TagNumber(1)
  set tier($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => $_clearField(1);
}

class CodeRedeemRequest extends $pb.GeneratedMessage {
  factory CodeRedeemRequest({
    $core.String? ownerAnyId,
    $core.String? ownerEthAddress,
    $core.String? requestedAnyName,
    $core.String? code,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    if (code != null) result.code = code;
    return result;
  }

  CodeRedeemRequest._();

  factory CodeRedeemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeRedeemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeRedeemRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(3, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..aOS(4, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemRequest copyWith(void Function(CodeRedeemRequest) updates) =>
      super.copyWith((message) => updates(message as CodeRedeemRequest))
          as CodeRedeemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeRedeemRequest create() => CodeRedeemRequest._();
  @$core.override
  CodeRedeemRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeRedeemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeRedeemRequest>(create);
  static CodeRedeemRequest? _defaultInstance;

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(1)
  $core.String get ownerAnyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAnyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAnyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAnyId() => $_clearField(1);

  /// this is the owner's main EOA (Externally Owned Account) address
  /// not AccountAbstraction's SCW (Smart Contract Wallet) address!
  /// this is required to reserve a name for the owner (later that is done by user)
  /// in the following format: "0x7a250d5630b4cf539739df2c5dacb4c659f2488d"
  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);

  /// if empty - then no name requested
  @$pb.TagNumber(3)
  $core.String get requestedAnyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestedAnyName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestedAnyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedAnyName() => $_clearField(3);

  /// code received in the email
  @$pb.TagNumber(4)
  $core.String get code => $_getSZ(3);
  @$pb.TagNumber(4)
  set code($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCode() => $_clearField(4);
}

class CodeRedeemRequestSigned extends $pb.GeneratedMessage {
  factory CodeRedeemRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  CodeRedeemRequestSigned._();

  factory CodeRedeemRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeRedeemRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeRedeemRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemRequestSigned copyWith(
          void Function(CodeRedeemRequestSigned) updates) =>
      super.copyWith((message) => updates(message as CodeRedeemRequestSigned))
          as CodeRedeemRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeRedeemRequestSigned create() => CodeRedeemRequestSigned._();
  @$core.override
  CodeRedeemRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeRedeemRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeRedeemRequestSigned>(create);
  static CodeRedeemRequestSigned? _defaultInstance;

  /// CodeRedeemRequest
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// this is payload signed with payload.ownerAnyID
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class CodeRedeemResponse extends $pb.GeneratedMessage {
  factory CodeRedeemResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  CodeRedeemResponse._();

  factory CodeRedeemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CodeRedeemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CodeRedeemResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CodeRedeemResponse copyWith(void Function(CodeRedeemResponse) updates) =>
      super.copyWith((message) => updates(message as CodeRedeemResponse))
          as CodeRedeemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CodeRedeemResponse create() => CodeRedeemResponse._();
  @$core.override
  CodeRedeemResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CodeRedeemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CodeRedeemResponse>(create);
  static CodeRedeemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
