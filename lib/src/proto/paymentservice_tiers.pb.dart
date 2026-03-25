// This is a generated file - do not edit.
//
// Generated from paymentservice_tiers.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'paymentservice_tiers.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'paymentservice_tiers.pbenum.dart';

class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? description,
  }) {
    final result = create();
    if (description != null) result.description = description;
    return result;
  }

  Feature._();

  factory Feature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Feature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Feature',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Feature copyWith(void Function(Feature) updates) =>
      super.copyWith((message) => updates(message as Feature)) as Feature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  @$core.override
  Feature createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);
}

class GetTiersRequest extends $pb.GeneratedMessage {
  factory GetTiersRequest({
    $core.String? ownerAnyId,
    $core.String? locale,
    $core.String? version,
  }) {
    final result = create();
    if (ownerAnyId != null) result.ownerAnyId = ownerAnyId;
    if (locale != null) result.locale = locale;
    if (version != null) result.version = version;
    return result;
  }

  GetTiersRequest._();

  factory GetTiersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTiersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTiersRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAnyId', protoName: 'ownerAnyId')
    ..aOS(2, _omitFieldNames ? '' : 'locale')
    ..aOS(3, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersRequest copyWith(void Function(GetTiersRequest) updates) =>
      super.copyWith((message) => updates(message as GetTiersRequest))
          as GetTiersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTiersRequest create() => GetTiersRequest._();
  @$core.override
  GetTiersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTiersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTiersRequest>(create);
  static GetTiersRequest? _defaultInstance;

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
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get version => $_getSZ(2);
  @$pb.TagNumber(3)
  set version($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);
}

class GetTiersRequestSigned extends $pb.GeneratedMessage {
  factory GetTiersRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  GetTiersRequestSigned._();

  factory GetTiersRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTiersRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTiersRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersRequestSigned copyWith(
          void Function(GetTiersRequestSigned) updates) =>
      super.copyWith((message) => updates(message as GetTiersRequestSigned))
          as GetTiersRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTiersRequestSigned create() => GetTiersRequestSigned._();
  @$core.override
  GetTiersRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTiersRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTiersRequestSigned>(create);
  static GetTiersRequestSigned? _defaultInstance;

  /// GetTiersRequest struct
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

class TierData extends $pb.GeneratedMessage {
  factory TierData({
    $core.int? id,
    $core.String? name,
    $core.String? description,
    $core.bool? isActive,
    $core.bool? isTest,
    $core.bool? isHiddenTier,
    PeriodType? periodType,
    $core.int? periodValue,
    $core.int? priceStripeUsdCents,
    $core.int? anyNamesCountIncluded,
    $core.int? anyNameMinLength,
    $core.Iterable<Feature>? features,
    $core.String? colorStr,
    $core.String? stripeProductId,
    $core.String? stripeManageUrl,
    $core.String? iosProductId,
    $core.String? iosManageUrl,
    $core.String? androidProductId,
    $core.String? androidManageUrl,
    $core.String? offer,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (isActive != null) result.isActive = isActive;
    if (isTest != null) result.isTest = isTest;
    if (isHiddenTier != null) result.isHiddenTier = isHiddenTier;
    if (periodType != null) result.periodType = periodType;
    if (periodValue != null) result.periodValue = periodValue;
    if (priceStripeUsdCents != null)
      result.priceStripeUsdCents = priceStripeUsdCents;
    if (anyNamesCountIncluded != null)
      result.anyNamesCountIncluded = anyNamesCountIncluded;
    if (anyNameMinLength != null) result.anyNameMinLength = anyNameMinLength;
    if (features != null) result.features.addAll(features);
    if (colorStr != null) result.colorStr = colorStr;
    if (stripeProductId != null) result.stripeProductId = stripeProductId;
    if (stripeManageUrl != null) result.stripeManageUrl = stripeManageUrl;
    if (iosProductId != null) result.iosProductId = iosProductId;
    if (iosManageUrl != null) result.iosManageUrl = iosManageUrl;
    if (androidProductId != null) result.androidProductId = androidProductId;
    if (androidManageUrl != null) result.androidManageUrl = androidManageUrl;
    if (offer != null) result.offer = offer;
    return result;
  }

  TierData._();

  factory TierData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TierData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TierData',
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id', fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOB(4, _omitFieldNames ? '' : 'isActive', protoName: 'isActive')
    ..aOB(5, _omitFieldNames ? '' : 'isTest', protoName: 'isTest')
    ..aOB(6, _omitFieldNames ? '' : 'isHiddenTier', protoName: 'isHiddenTier')
    ..aE<PeriodType>(7, _omitFieldNames ? '' : 'periodType',
        protoName: 'periodType', enumValues: PeriodType.values)
    ..aI(8, _omitFieldNames ? '' : 'periodValue',
        protoName: 'periodValue', fieldType: $pb.PbFieldType.OU3)
    ..aI(9, _omitFieldNames ? '' : 'priceStripeUsdCents',
        protoName: 'priceStripeUsdCents', fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'anyNamesCountIncluded',
        protoName: 'anyNamesCountIncluded', fieldType: $pb.PbFieldType.OU3)
    ..aI(11, _omitFieldNames ? '' : 'anyNameMinLength',
        protoName: 'anyNameMinLength', fieldType: $pb.PbFieldType.OU3)
    ..pPM<Feature>(12, _omitFieldNames ? '' : 'features',
        subBuilder: Feature.create)
    ..aOS(13, _omitFieldNames ? '' : 'colorStr', protoName: 'colorStr')
    ..aOS(14, _omitFieldNames ? '' : 'stripeProductId',
        protoName: 'stripeProductId')
    ..aOS(15, _omitFieldNames ? '' : 'stripeManageUrl',
        protoName: 'stripeManageUrl')
    ..aOS(16, _omitFieldNames ? '' : 'iosProductId', protoName: 'iosProductId')
    ..aOS(17, _omitFieldNames ? '' : 'iosManageUrl', protoName: 'iosManageUrl')
    ..aOS(18, _omitFieldNames ? '' : 'androidProductId',
        protoName: 'androidProductId')
    ..aOS(19, _omitFieldNames ? '' : 'androidManageUrl',
        protoName: 'androidManageUrl')
    ..aOS(20, _omitFieldNames ? '' : 'offer')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TierData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TierData copyWith(void Function(TierData) updates) =>
      super.copyWith((message) => updates(message as TierData)) as TierData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TierData create() => TierData._();
  @$core.override
  TierData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TierData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TierData>(create);
  static TierData? _defaultInstance;

  /// this is a unique ID of the tier
  /// you should hardcode this in your app and provide icon, graphics, etc for each tier
  /// (even for old/historical/inactive/hidden tiers)
  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// localazied name of the tier
  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  /// just a short technical description
  /// you don't have to use it, you can use your own UI-friendly texts
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  /// can you buy it (ON ALL PLATFORMS, without clarification)?
  @$pb.TagNumber(4)
  $core.bool get isActive => $_getBF(3);
  @$pb.TagNumber(4)
  set isActive($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsActive() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsActive() => $_clearField(4);

  /// is this tier for debugging only?
  @$pb.TagNumber(5)
  $core.bool get isTest => $_getBF(4);
  @$pb.TagNumber(5)
  set isTest($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsTest() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsTest() => $_clearField(5);

  /// hidden tiers are only visible once user got them
  @$pb.TagNumber(6)
  $core.bool get isHiddenTier => $_getBF(5);
  @$pb.TagNumber(6)
  set isHiddenTier($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsHiddenTier() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsHiddenTier() => $_clearField(6);

  /// how long is the period of the subscription
  @$pb.TagNumber(7)
  PeriodType get periodType => $_getN(6);
  @$pb.TagNumber(7)
  set periodType(PeriodType value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPeriodType() => $_has(6);
  @$pb.TagNumber(7)
  void clearPeriodType() => $_clearField(7);

  /// i.e. "5 days" or "3 years"
  @$pb.TagNumber(8)
  $core.int get periodValue => $_getIZ(7);
  @$pb.TagNumber(8)
  set periodValue($core.int value) => $_setUnsignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPeriodValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriodValue() => $_clearField(8);

  /// this one is a price we use ONLY on Stripe platform
  @$pb.TagNumber(9)
  $core.int get priceStripeUsdCents => $_getIZ(8);
  @$pb.TagNumber(9)
  set priceStripeUsdCents($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPriceStripeUsdCents() => $_has(8);
  @$pb.TagNumber(9)
  void clearPriceStripeUsdCents() => $_clearField(9);

  /// number of ANY NS names that this tier includes
  /// (not counted as a "feature" and not in the features list)
  @$pb.TagNumber(10)
  $core.int get anyNamesCountIncluded => $_getIZ(9);
  @$pb.TagNumber(10)
  set anyNamesCountIncluded($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAnyNamesCountIncluded() => $_has(9);
  @$pb.TagNumber(10)
  void clearAnyNamesCountIncluded() => $_clearField(10);

  /// somename.any - len of 8
  @$pb.TagNumber(11)
  $core.int get anyNameMinLength => $_getIZ(10);
  @$pb.TagNumber(11)
  set anyNameMinLength($core.int value) => $_setUnsignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAnyNameMinLength() => $_has(10);
  @$pb.TagNumber(11)
  void clearAnyNameMinLength() => $_clearField(11);

  /// each tier has a set of features
  @$pb.TagNumber(12)
  $pb.PbList<Feature> get features => $_getList(11);

  /// green, blue, red, purple or custom color in string format #ff00ff
  @$pb.TagNumber(13)
  $core.String get colorStr => $_getSZ(12);
  @$pb.TagNumber(13)
  set colorStr($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasColorStr() => $_has(12);
  @$pb.TagNumber(13)
  void clearColorStr() => $_clearField(13);

  /// Stripe platform-specific data:
  @$pb.TagNumber(14)
  $core.String get stripeProductId => $_getSZ(13);
  @$pb.TagNumber(14)
  set stripeProductId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasStripeProductId() => $_has(13);
  @$pb.TagNumber(14)
  void clearStripeProductId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get stripeManageUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set stripeManageUrl($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasStripeManageUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearStripeManageUrl() => $_clearField(15);

  /// iOS platform-specific data:
  @$pb.TagNumber(16)
  $core.String get iosProductId => $_getSZ(15);
  @$pb.TagNumber(16)
  set iosProductId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIosProductId() => $_has(15);
  @$pb.TagNumber(16)
  void clearIosProductId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get iosManageUrl => $_getSZ(16);
  @$pb.TagNumber(17)
  set iosManageUrl($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasIosManageUrl() => $_has(16);
  @$pb.TagNumber(17)
  void clearIosManageUrl() => $_clearField(17);

  /// Android platform-specific data:
  @$pb.TagNumber(18)
  $core.String get androidProductId => $_getSZ(17);
  @$pb.TagNumber(18)
  set androidProductId($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasAndroidProductId() => $_has(17);
  @$pb.TagNumber(18)
  void clearAndroidProductId() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get androidManageUrl => $_getSZ(18);
  @$pb.TagNumber(19)
  set androidManageUrl($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasAndroidManageUrl() => $_has(18);
  @$pb.TagNumber(19)
  void clearAndroidManageUrl() => $_clearField(19);

  /// something like "limited offer", etc
  @$pb.TagNumber(20)
  $core.String get offer => $_getSZ(19);
  @$pb.TagNumber(20)
  set offer($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasOffer() => $_has(19);
  @$pb.TagNumber(20)
  void clearOffer() => $_clearField(20);
}

class GetTiersResponse extends $pb.GeneratedMessage {
  factory GetTiersResponse({
    $core.Iterable<TierData>? tiers,
  }) {
    final result = create();
    if (tiers != null) result.tiers.addAll(tiers);
    return result;
  }

  GetTiersResponse._();

  factory GetTiersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTiersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTiersResponse',
      createEmptyInstance: create)
    ..pPM<TierData>(1, _omitFieldNames ? '' : 'tiers',
        subBuilder: TierData.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTiersResponse copyWith(void Function(GetTiersResponse) updates) =>
      super.copyWith((message) => updates(message as GetTiersResponse))
          as GetTiersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTiersResponse create() => GetTiersResponse._();
  @$core.override
  GetTiersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTiersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTiersResponse>(create);
  static GetTiersResponse? _defaultInstance;

  /// list of all available tiers
  @$pb.TagNumber(1)
  $pb.PbList<TierData> get tiers => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
