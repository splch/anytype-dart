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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'paymentservice2.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'paymentservice2.pbenum.dart';

class MembershipV2_Amount extends $pb.GeneratedMessage {
  factory MembershipV2_Amount({
    $core.String? currency,
    $fixnum.Int64? amountCents,
  }) {
    final result = create();
    if (currency != null) result.currency = currency;
    if (amountCents != null) result.amountCents = amountCents;
    return result;
  }

  MembershipV2_Amount._();

  factory MembershipV2_Amount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_Amount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.Amount',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..aInt64(2, _omitFieldNames ? '' : 'amountCents', protoName: 'amountCents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Amount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Amount copyWith(void Function(MembershipV2_Amount) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_Amount))
          as MembershipV2_Amount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_Amount create() => MembershipV2_Amount._();
  @$core.override
  MembershipV2_Amount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_Amount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_Amount>(create);
  static MembershipV2_Amount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => $_clearField(1);

  /// $0.01 = 1
  /// $1.00 = 100
  /// negative amounts
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountCents => $_getI64(1);
  @$pb.TagNumber(2)
  set amountCents($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountCents() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountCents() => $_clearField(2);
}

class MembershipV2_Features extends $pb.GeneratedMessage {
  factory MembershipV2_Features({
    $fixnum.Int64? storageBytes,
    $core.int? spaceReaders,
    $core.int? spaceWriters,
    $core.int? sharedSpaces,
    $core.int? teamSeats,
    $core.int? anyNameCount,
    $core.int? anyNameMinLen,
  }) {
    final result = create();
    if (storageBytes != null) result.storageBytes = storageBytes;
    if (spaceReaders != null) result.spaceReaders = spaceReaders;
    if (spaceWriters != null) result.spaceWriters = spaceWriters;
    if (sharedSpaces != null) result.sharedSpaces = sharedSpaces;
    if (teamSeats != null) result.teamSeats = teamSeats;
    if (anyNameCount != null) result.anyNameCount = anyNameCount;
    if (anyNameMinLen != null) result.anyNameMinLen = anyNameMinLen;
    return result;
  }

  MembershipV2_Features._();

  factory MembershipV2_Features.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_Features.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.Features',
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'storageBytes', $pb.PbFieldType.OU6,
        protoName: 'storageBytes', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(2, _omitFieldNames ? '' : 'spaceReaders',
        protoName: 'spaceReaders', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'spaceWriters',
        protoName: 'spaceWriters', fieldType: $pb.PbFieldType.OU3)
    ..aI(4, _omitFieldNames ? '' : 'sharedSpaces',
        protoName: 'sharedSpaces', fieldType: $pb.PbFieldType.OU3)
    ..aI(5, _omitFieldNames ? '' : 'teamSeats',
        protoName: 'teamSeats', fieldType: $pb.PbFieldType.OU3)
    ..aI(6, _omitFieldNames ? '' : 'anyNameCount',
        protoName: 'anyNameCount', fieldType: $pb.PbFieldType.OU3)
    ..aI(7, _omitFieldNames ? '' : 'anyNameMinLen',
        protoName: 'anyNameMinLen', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Features clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Features copyWith(
          void Function(MembershipV2_Features) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_Features))
          as MembershipV2_Features;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_Features create() => MembershipV2_Features._();
  @$core.override
  MembershipV2_Features createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_Features getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_Features>(create);
  static MembershipV2_Features? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get storageBytes => $_getI64(0);
  @$pb.TagNumber(1)
  set storageBytes($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStorageBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageBytes() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get spaceReaders => $_getIZ(1);
  @$pb.TagNumber(2)
  set spaceReaders($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSpaceReaders() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpaceReaders() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get spaceWriters => $_getIZ(2);
  @$pb.TagNumber(3)
  set spaceWriters($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpaceWriters() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpaceWriters() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get sharedSpaces => $_getIZ(3);
  @$pb.TagNumber(4)
  set sharedSpaces($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSharedSpaces() => $_has(3);
  @$pb.TagNumber(4)
  void clearSharedSpaces() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get teamSeats => $_getIZ(4);
  @$pb.TagNumber(5)
  set teamSeats($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTeamSeats() => $_has(4);
  @$pb.TagNumber(5)
  void clearTeamSeats() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get anyNameCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set anyNameCount($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAnyNameCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAnyNameCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get anyNameMinLen => $_getIZ(6);
  @$pb.TagNumber(7)
  set anyNameMinLen($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAnyNameMinLen() => $_has(6);
  @$pb.TagNumber(7)
  void clearAnyNameMinLen() => $_clearField(7);
}

class MembershipV2_Product extends $pb.GeneratedMessage {
  factory MembershipV2_Product({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.bool? isTopLevel,
    $core.bool? isHidden,
    $core.bool? isIntro,
    $core.bool? isUpgradeable,
    $core.Iterable<MembershipV2_Amount>? pricesYearly,
    $core.Iterable<MembershipV2_Amount>? pricesMonthly,
    $core.String? colorStr,
    $core.String? offer,
    MembershipV2_Features? features,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (isTopLevel != null) result.isTopLevel = isTopLevel;
    if (isHidden != null) result.isHidden = isHidden;
    if (isIntro != null) result.isIntro = isIntro;
    if (isUpgradeable != null) result.isUpgradeable = isUpgradeable;
    if (pricesYearly != null) result.pricesYearly.addAll(pricesYearly);
    if (pricesMonthly != null) result.pricesMonthly.addAll(pricesMonthly);
    if (colorStr != null) result.colorStr = colorStr;
    if (offer != null) result.offer = offer;
    if (features != null) result.features = features;
    return result;
  }

  MembershipV2_Product._();

  factory MembershipV2_Product.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_Product.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.Product',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOB(4, _omitFieldNames ? '' : 'isTopLevel', protoName: 'isTopLevel')
    ..aOB(5, _omitFieldNames ? '' : 'isHidden', protoName: 'isHidden')
    ..aOB(6, _omitFieldNames ? '' : 'isIntro', protoName: 'isIntro')
    ..aOB(7, _omitFieldNames ? '' : 'isUpgradeable', protoName: 'isUpgradeable')
    ..pPM<MembershipV2_Amount>(8, _omitFieldNames ? '' : 'pricesYearly',
        protoName: 'pricesYearly', subBuilder: MembershipV2_Amount.create)
    ..pPM<MembershipV2_Amount>(9, _omitFieldNames ? '' : 'pricesMonthly',
        protoName: 'pricesMonthly', subBuilder: MembershipV2_Amount.create)
    ..aOS(10, _omitFieldNames ? '' : 'colorStr', protoName: 'colorStr')
    ..aOS(11, _omitFieldNames ? '' : 'offer')
    ..aOM<MembershipV2_Features>(12, _omitFieldNames ? '' : 'features',
        subBuilder: MembershipV2_Features.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Product clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Product copyWith(void Function(MembershipV2_Product) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_Product))
          as MembershipV2_Product;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_Product create() => MembershipV2_Product._();
  @$core.override
  MembershipV2_Product createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_Product getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_Product>(create);
  static MembershipV2_Product? _defaultInstance;

  /// this is a unique Payment Node ID
  /// adding 2 same products to a cart means we will have 2 items with same ID
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isTopLevel => $_getBF(3);
  @$pb.TagNumber(4)
  set isTopLevel($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsTopLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsTopLevel() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isHidden => $_getBF(4);
  @$pb.TagNumber(5)
  set isHidden($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsHidden() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsHidden() => $_clearField(5);

  /// isIntro flag can be used as follows:
  ///
  /// 1. if current user's top level product has isIntro flag ->
  /// then you'd rather show a FULL list of all products
  /// to enable upgrading from CURRENT product
  /// 2. but if current user's top level product has no isIntro flag ->
  /// then it means that this plan was aquired and user need to control it.
  /// then show "second screen" to control that product instead
  @$pb.TagNumber(6)
  $core.bool get isIntro => $_getBF(5);
  @$pb.TagNumber(6)
  set isIntro($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsIntro() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsIntro() => $_clearField(6);

  /// isUpgradeable can be used as follows:
  ///
  /// if current user's top level product has isUpgradeable flag ->
  /// show incentives to buy something else
  @$pb.TagNumber(7)
  $core.bool get isUpgradeable => $_getBF(6);
  @$pb.TagNumber(7)
  set isUpgradeable($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsUpgradeable() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsUpgradeable() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<MembershipV2_Amount> get pricesYearly => $_getList(7);

  @$pb.TagNumber(9)
  $pb.PbList<MembershipV2_Amount> get pricesMonthly => $_getList(8);

  /// green, blue, red, purple, custom, etc
  @$pb.TagNumber(10)
  $core.String get colorStr => $_getSZ(9);
  @$pb.TagNumber(10)
  set colorStr($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasColorStr() => $_has(9);
  @$pb.TagNumber(10)
  void clearColorStr() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get offer => $_getSZ(10);
  @$pb.TagNumber(11)
  set offer($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasOffer() => $_has(10);
  @$pb.TagNumber(11)
  void clearOffer() => $_clearField(11);

  @$pb.TagNumber(12)
  MembershipV2_Features get features => $_getN(11);
  @$pb.TagNumber(12)
  set features(MembershipV2_Features value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasFeatures() => $_has(11);
  @$pb.TagNumber(12)
  void clearFeatures() => $_clearField(12);
  @$pb.TagNumber(12)
  MembershipV2_Features ensureFeatures() => $_ensure(11);
}

class MembershipV2_PurchaseInfo extends $pb.GeneratedMessage {
  factory MembershipV2_PurchaseInfo({
    $fixnum.Int64? dateStarted,
    $fixnum.Int64? dateEnds,
    $core.bool? isAutoRenew,
    MembershipV2_Period? period,
  }) {
    final result = create();
    if (dateStarted != null) result.dateStarted = dateStarted;
    if (dateEnds != null) result.dateEnds = dateEnds;
    if (isAutoRenew != null) result.isAutoRenew = isAutoRenew;
    if (period != null) result.period = period;
    return result;
  }

  MembershipV2_PurchaseInfo._();

  factory MembershipV2_PurchaseInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_PurchaseInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.PurchaseInfo',
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'dateStarted', $pb.PbFieldType.OU6,
        protoName: 'dateStarted', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'dateEnds', $pb.PbFieldType.OU6,
        protoName: 'dateEnds', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(3, _omitFieldNames ? '' : 'isAutoRenew', protoName: 'isAutoRenew')
    ..aE<MembershipV2_Period>(4, _omitFieldNames ? '' : 'period',
        enumValues: MembershipV2_Period.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_PurchaseInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_PurchaseInfo copyWith(
          void Function(MembershipV2_PurchaseInfo) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_PurchaseInfo))
          as MembershipV2_PurchaseInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_PurchaseInfo create() => MembershipV2_PurchaseInfo._();
  @$core.override
  MembershipV2_PurchaseInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_PurchaseInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_PurchaseInfo>(create);
  static MembershipV2_PurchaseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get dateStarted => $_getI64(0);
  @$pb.TagNumber(1)
  set dateStarted($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDateStarted() => $_has(0);
  @$pb.TagNumber(1)
  void clearDateStarted() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get dateEnds => $_getI64(1);
  @$pb.TagNumber(2)
  set dateEnds($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDateEnds() => $_has(1);
  @$pb.TagNumber(2)
  void clearDateEnds() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isAutoRenew => $_getBF(2);
  @$pb.TagNumber(3)
  set isAutoRenew($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsAutoRenew() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsAutoRenew() => $_clearField(3);

  @$pb.TagNumber(4)
  MembershipV2_Period get period => $_getN(3);
  @$pb.TagNumber(4)
  set period(MembershipV2_Period value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => $_clearField(4);
}

class MembershipV2_ProductStatus extends $pb.GeneratedMessage {
  factory MembershipV2_ProductStatus({
    MembershipV2_ProductStatus_Status? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  MembershipV2_ProductStatus._();

  factory MembershipV2_ProductStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_ProductStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.ProductStatus',
      createEmptyInstance: create)
    ..aE<MembershipV2_ProductStatus_Status>(1, _omitFieldNames ? '' : 'status',
        enumValues: MembershipV2_ProductStatus_Status.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_ProductStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_ProductStatus copyWith(
          void Function(MembershipV2_ProductStatus) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_ProductStatus))
          as MembershipV2_ProductStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_ProductStatus create() => MembershipV2_ProductStatus._();
  @$core.override
  MembershipV2_ProductStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_ProductStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_ProductStatus>(create);
  static MembershipV2_ProductStatus? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_ProductStatus_Status get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(MembershipV2_ProductStatus_Status value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class MembershipV2_PurchasedProduct extends $pb.GeneratedMessage {
  factory MembershipV2_PurchasedProduct({
    MembershipV2_Product? product,
    MembershipV2_PurchaseInfo? purchaseInfo,
    MembershipV2_ProductStatus? productStatus,
  }) {
    final result = create();
    if (product != null) result.product = product;
    if (purchaseInfo != null) result.purchaseInfo = purchaseInfo;
    if (productStatus != null) result.productStatus = productStatus;
    return result;
  }

  MembershipV2_PurchasedProduct._();

  factory MembershipV2_PurchasedProduct.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_PurchasedProduct.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.PurchasedProduct',
      createEmptyInstance: create)
    ..aOM<MembershipV2_Product>(1, _omitFieldNames ? '' : 'product',
        subBuilder: MembershipV2_Product.create)
    ..aOM<MembershipV2_PurchaseInfo>(2, _omitFieldNames ? '' : 'purchaseInfo',
        protoName: 'purchaseInfo', subBuilder: MembershipV2_PurchaseInfo.create)
    ..aOM<MembershipV2_ProductStatus>(3, _omitFieldNames ? '' : 'productStatus',
        protoName: 'productStatus',
        subBuilder: MembershipV2_ProductStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_PurchasedProduct clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_PurchasedProduct copyWith(
          void Function(MembershipV2_PurchasedProduct) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_PurchasedProduct))
          as MembershipV2_PurchasedProduct;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_PurchasedProduct create() =>
      MembershipV2_PurchasedProduct._();
  @$core.override
  MembershipV2_PurchasedProduct createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_PurchasedProduct getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_PurchasedProduct>(create);
  static MembershipV2_PurchasedProduct? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_Product get product => $_getN(0);
  @$pb.TagNumber(1)
  set product(MembershipV2_Product value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProduct() => $_has(0);
  @$pb.TagNumber(1)
  void clearProduct() => $_clearField(1);
  @$pb.TagNumber(1)
  MembershipV2_Product ensureProduct() => $_ensure(0);

  @$pb.TagNumber(2)
  MembershipV2_PurchaseInfo get purchaseInfo => $_getN(1);
  @$pb.TagNumber(2)
  set purchaseInfo(MembershipV2_PurchaseInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPurchaseInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurchaseInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  MembershipV2_PurchaseInfo ensurePurchaseInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  MembershipV2_ProductStatus get productStatus => $_getN(2);
  @$pb.TagNumber(3)
  set productStatus(MembershipV2_ProductStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProductStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearProductStatus() => $_clearField(3);
  @$pb.TagNumber(3)
  MembershipV2_ProductStatus ensureProductStatus() => $_ensure(2);
}

class MembershipV2_CartProduct extends $pb.GeneratedMessage {
  factory MembershipV2_CartProduct({
    MembershipV2_Product? product,
    $core.bool? isYearly,
    $core.bool? remove,
  }) {
    final result = create();
    if (product != null) result.product = product;
    if (isYearly != null) result.isYearly = isYearly;
    if (remove != null) result.remove = remove;
    return result;
  }

  MembershipV2_CartProduct._();

  factory MembershipV2_CartProduct.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_CartProduct.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.CartProduct',
      createEmptyInstance: create)
    ..aOM<MembershipV2_Product>(1, _omitFieldNames ? '' : 'product',
        subBuilder: MembershipV2_Product.create)
    ..aOB(2, _omitFieldNames ? '' : 'isYearly', protoName: 'isYearly')
    ..aOB(3, _omitFieldNames ? '' : 'remove')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_CartProduct clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_CartProduct copyWith(
          void Function(MembershipV2_CartProduct) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_CartProduct))
          as MembershipV2_CartProduct;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_CartProduct create() => MembershipV2_CartProduct._();
  @$core.override
  MembershipV2_CartProduct createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_CartProduct getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_CartProduct>(create);
  static MembershipV2_CartProduct? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_Product get product => $_getN(0);
  @$pb.TagNumber(1)
  set product(MembershipV2_Product value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProduct() => $_has(0);
  @$pb.TagNumber(1)
  void clearProduct() => $_clearField(1);
  @$pb.TagNumber(1)
  MembershipV2_Product ensureProduct() => $_ensure(0);

  /// otherwise - monthly
  @$pb.TagNumber(2)
  $core.bool get isYearly => $_getBF(1);
  @$pb.TagNumber(2)
  set isYearly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsYearly() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsYearly() => $_clearField(2);

  /// set to true if you want to remove this item from the customer
  /// it's like setting -1 to some product
  @$pb.TagNumber(3)
  $core.bool get remove => $_getBF(2);
  @$pb.TagNumber(3)
  set remove($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemove() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemove() => $_clearField(3);
}

class MembershipV2_Invoice extends $pb.GeneratedMessage {
  factory MembershipV2_Invoice({
    $core.String? id,
    $fixnum.Int64? date,
    MembershipV2_Amount? total,
    MembershipV2_Invoice_Status? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (date != null) result.date = date;
    if (total != null) result.total = total;
    if (status != null) result.status = status;
    return result;
  }

  MembershipV2_Invoice._();

  factory MembershipV2_Invoice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_Invoice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.Invoice',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'date', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MembershipV2_Amount>(3, _omitFieldNames ? '' : 'total',
        subBuilder: MembershipV2_Amount.create)
    ..aE<MembershipV2_Invoice_Status>(4, _omitFieldNames ? '' : 'status',
        enumValues: MembershipV2_Invoice_Status.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Invoice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Invoice copyWith(void Function(MembershipV2_Invoice) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_Invoice))
          as MembershipV2_Invoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_Invoice create() => MembershipV2_Invoice._();
  @$core.override
  MembershipV2_Invoice createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_Invoice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_Invoice>(create);
  static MembershipV2_Invoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get date => $_getI64(1);
  @$pb.TagNumber(2)
  set date($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);

  @$pb.TagNumber(3)
  MembershipV2_Amount get total => $_getN(2);
  @$pb.TagNumber(3)
  set total(MembershipV2_Amount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
  @$pb.TagNumber(3)
  MembershipV2_Amount ensureTotal() => $_ensure(2);

  @$pb.TagNumber(4)
  MembershipV2_Invoice_Status get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(MembershipV2_Invoice_Status value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class MembershipV2_Cart extends $pb.GeneratedMessage {
  factory MembershipV2_Cart({
    $core.Iterable<MembershipV2_CartProduct>? products,
    MembershipV2_Amount? total,
    MembershipV2_Amount? totalNextInvoice,
    $fixnum.Int64? nextInvoiceDate,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (total != null) result.total = total;
    if (totalNextInvoice != null) result.totalNextInvoice = totalNextInvoice;
    if (nextInvoiceDate != null) result.nextInvoiceDate = nextInvoiceDate;
    return result;
  }

  MembershipV2_Cart._();

  factory MembershipV2_Cart.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_Cart.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.Cart',
      createEmptyInstance: create)
    ..pPM<MembershipV2_CartProduct>(1, _omitFieldNames ? '' : 'products',
        subBuilder: MembershipV2_CartProduct.create)
    ..aOM<MembershipV2_Amount>(2, _omitFieldNames ? '' : 'total',
        subBuilder: MembershipV2_Amount.create)
    ..aOM<MembershipV2_Amount>(3, _omitFieldNames ? '' : 'totalNextInvoice',
        protoName: 'totalNextInvoice', subBuilder: MembershipV2_Amount.create)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'nextInvoiceDate', $pb.PbFieldType.OU6,
        protoName: 'nextInvoiceDate', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Cart clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_Cart copyWith(void Function(MembershipV2_Cart) updates) =>
      super.copyWith((message) => updates(message as MembershipV2_Cart))
          as MembershipV2_Cart;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_Cart create() => MembershipV2_Cart._();
  @$core.override
  MembershipV2_Cart createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_Cart getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_Cart>(create);
  static MembershipV2_Cart? _defaultInstance;

  /// if you add Nx the same product - it will be Nx in the 'products' array, i.e:
  /// each product instance has a unique index
  @$pb.TagNumber(1)
  $pb.PbList<MembershipV2_CartProduct> get products => $_getList(0);

  /// total amount of the cart (including discounts, etc)
  @$pb.TagNumber(2)
  MembershipV2_Amount get total => $_getN(1);
  @$pb.TagNumber(2)
  set total(MembershipV2_Amount value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
  @$pb.TagNumber(2)
  MembershipV2_Amount ensureTotal() => $_ensure(1);

  /// in case you are paying in the middle of the period (for existing customers)
  /// the next invoice amount will also be generated
  @$pb.TagNumber(3)
  MembershipV2_Amount get totalNextInvoice => $_getN(2);
  @$pb.TagNumber(3)
  set totalNextInvoice(MembershipV2_Amount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalNextInvoice() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalNextInvoice() => $_clearField(3);
  @$pb.TagNumber(3)
  MembershipV2_Amount ensureTotalNextInvoice() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get nextInvoiceDate => $_getI64(3);
  @$pb.TagNumber(4)
  set nextInvoiceDate($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextInvoiceDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextInvoiceDate() => $_clearField(4);
}

class MembershipV2_GetProductsRequest extends $pb.GeneratedMessage {
  factory MembershipV2_GetProductsRequest() => create();

  MembershipV2_GetProductsRequest._();

  factory MembershipV2_GetProductsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_GetProductsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.GetProductsRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetProductsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetProductsRequest copyWith(
          void Function(MembershipV2_GetProductsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_GetProductsRequest))
          as MembershipV2_GetProductsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetProductsRequest create() =>
      MembershipV2_GetProductsRequest._();
  @$core.override
  MembershipV2_GetProductsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetProductsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_GetProductsRequest>(
          create);
  static MembershipV2_GetProductsRequest? _defaultInstance;
}

class MembershipV2_GetProductsResponse extends $pb.GeneratedMessage {
  factory MembershipV2_GetProductsResponse({
    $core.Iterable<MembershipV2_Product>? products,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    return result;
  }

  MembershipV2_GetProductsResponse._();

  factory MembershipV2_GetProductsResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_GetProductsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.GetProductsResponse',
      createEmptyInstance: create)
    ..pPM<MembershipV2_Product>(1, _omitFieldNames ? '' : 'products',
        subBuilder: MembershipV2_Product.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetProductsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetProductsResponse copyWith(
          void Function(MembershipV2_GetProductsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_GetProductsResponse))
          as MembershipV2_GetProductsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetProductsResponse create() =>
      MembershipV2_GetProductsResponse._();
  @$core.override
  MembershipV2_GetProductsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetProductsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_GetProductsResponse>(
          create);
  static MembershipV2_GetProductsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MembershipV2_Product> get products => $_getList(0);
}

class MembershipV2_GetStatusRequest extends $pb.GeneratedMessage {
  factory MembershipV2_GetStatusRequest() => create();

  MembershipV2_GetStatusRequest._();

  factory MembershipV2_GetStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_GetStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.GetStatusRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetStatusRequest copyWith(
          void Function(MembershipV2_GetStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_GetStatusRequest))
          as MembershipV2_GetStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetStatusRequest create() =>
      MembershipV2_GetStatusRequest._();
  @$core.override
  MembershipV2_GetStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_GetStatusRequest>(create);
  static MembershipV2_GetStatusRequest? _defaultInstance;
}

class MembershipV2_GetStatusResponse extends $pb.GeneratedMessage {
  factory MembershipV2_GetStatusResponse({
    $core.Iterable<MembershipV2_PurchasedProduct>? products,
    MembershipV2_Invoice? nextInvoice,
    $core.String? teamOwnerID,
    MembershipV2_PaymentProvider? paymentProvider,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (nextInvoice != null) result.nextInvoice = nextInvoice;
    if (teamOwnerID != null) result.teamOwnerID = teamOwnerID;
    if (paymentProvider != null) result.paymentProvider = paymentProvider;
    return result;
  }

  MembershipV2_GetStatusResponse._();

  factory MembershipV2_GetStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_GetStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.GetStatusResponse',
      createEmptyInstance: create)
    ..pPM<MembershipV2_PurchasedProduct>(1, _omitFieldNames ? '' : 'products',
        subBuilder: MembershipV2_PurchasedProduct.create)
    ..aOM<MembershipV2_Invoice>(2, _omitFieldNames ? '' : 'nextInvoice',
        protoName: 'nextInvoice', subBuilder: MembershipV2_Invoice.create)
    ..aOS(3, _omitFieldNames ? '' : 'teamOwnerID', protoName: 'teamOwnerID')
    ..aE<MembershipV2_PaymentProvider>(
        4, _omitFieldNames ? '' : 'paymentProvider',
        protoName: 'paymentProvider',
        enumValues: MembershipV2_PaymentProvider.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetStatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_GetStatusResponse copyWith(
          void Function(MembershipV2_GetStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_GetStatusResponse))
          as MembershipV2_GetStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetStatusResponse create() =>
      MembershipV2_GetStatusResponse._();
  @$core.override
  MembershipV2_GetStatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_GetStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_GetStatusResponse>(create);
  static MembershipV2_GetStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MembershipV2_PurchasedProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  MembershipV2_Invoice get nextInvoice => $_getN(1);
  @$pb.TagNumber(2)
  set nextInvoice(MembershipV2_Invoice value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNextInvoice() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextInvoice() => $_clearField(2);
  @$pb.TagNumber(2)
  MembershipV2_Invoice ensureNextInvoice() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get teamOwnerID => $_getSZ(2);
  @$pb.TagNumber(3)
  set teamOwnerID($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTeamOwnerID() => $_has(2);
  @$pb.TagNumber(3)
  void clearTeamOwnerID() => $_clearField(3);

  @$pb.TagNumber(4)
  MembershipV2_PaymentProvider get paymentProvider => $_getN(3);
  @$pb.TagNumber(4)
  set paymentProvider(MembershipV2_PaymentProvider value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentProvider() => $_clearField(4);
}

class MembershipV2_StoreCartGetRequest extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartGetRequest() => create();

  MembershipV2_StoreCartGetRequest._();

  factory MembershipV2_StoreCartGetRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartGetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartGetRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartGetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartGetRequest copyWith(
          void Function(MembershipV2_StoreCartGetRequest) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_StoreCartGetRequest))
          as MembershipV2_StoreCartGetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartGetRequest create() =>
      MembershipV2_StoreCartGetRequest._();
  @$core.override
  MembershipV2_StoreCartGetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartGetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_StoreCartGetRequest>(
          create);
  static MembershipV2_StoreCartGetRequest? _defaultInstance;
}

class MembershipV2_StoreCartGetResponse extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartGetResponse({
    MembershipV2_Cart? cart,
  }) {
    final result = create();
    if (cart != null) result.cart = cart;
    return result;
  }

  MembershipV2_StoreCartGetResponse._();

  factory MembershipV2_StoreCartGetResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartGetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartGetResponse',
      createEmptyInstance: create)
    ..aOM<MembershipV2_Cart>(1, _omitFieldNames ? '' : 'cart',
        subBuilder: MembershipV2_Cart.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartGetResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartGetResponse copyWith(
          void Function(MembershipV2_StoreCartGetResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartGetResponse))
          as MembershipV2_StoreCartGetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartGetResponse create() =>
      MembershipV2_StoreCartGetResponse._();
  @$core.override
  MembershipV2_StoreCartGetResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartGetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_StoreCartGetResponse>(
          create);
  static MembershipV2_StoreCartGetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_Cart get cart => $_getN(0);
  @$pb.TagNumber(1)
  set cart(MembershipV2_Cart value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCart() => $_has(0);
  @$pb.TagNumber(1)
  void clearCart() => $_clearField(1);
  @$pb.TagNumber(1)
  MembershipV2_Cart ensureCart() => $_ensure(0);
}

class MembershipV2_StoreCartPromocodeApplyRequest extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartPromocodeApplyRequest({
    $core.String? promocode,
  }) {
    final result = create();
    if (promocode != null) result.promocode = promocode;
    return result;
  }

  MembershipV2_StoreCartPromocodeApplyRequest._();

  factory MembershipV2_StoreCartPromocodeApplyRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartPromocodeApplyRequest.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartPromocodeApplyRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'promocode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartPromocodeApplyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartPromocodeApplyRequest copyWith(
          void Function(MembershipV2_StoreCartPromocodeApplyRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartPromocodeApplyRequest))
          as MembershipV2_StoreCartPromocodeApplyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartPromocodeApplyRequest create() =>
      MembershipV2_StoreCartPromocodeApplyRequest._();
  @$core.override
  MembershipV2_StoreCartPromocodeApplyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartPromocodeApplyRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_StoreCartPromocodeApplyRequest>(create);
  static MembershipV2_StoreCartPromocodeApplyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get promocode => $_getSZ(0);
  @$pb.TagNumber(1)
  set promocode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPromocode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPromocode() => $_clearField(1);
}

class MembershipV2_StoreCartCheckoutRequest extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartCheckoutRequest() => create();

  MembershipV2_StoreCartCheckoutRequest._();

  factory MembershipV2_StoreCartCheckoutRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartCheckoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartCheckoutRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartCheckoutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartCheckoutRequest copyWith(
          void Function(MembershipV2_StoreCartCheckoutRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartCheckoutRequest))
          as MembershipV2_StoreCartCheckoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartCheckoutRequest create() =>
      MembershipV2_StoreCartCheckoutRequest._();
  @$core.override
  MembershipV2_StoreCartCheckoutRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartCheckoutRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_StoreCartCheckoutRequest>(create);
  static MembershipV2_StoreCartCheckoutRequest? _defaultInstance;
}

class MembershipV2_StoreCartCheckoutResponse extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartCheckoutResponse({
    $core.String? paymentUrl,
  }) {
    final result = create();
    if (paymentUrl != null) result.paymentUrl = paymentUrl;
    return result;
  }

  MembershipV2_StoreCartCheckoutResponse._();

  factory MembershipV2_StoreCartCheckoutResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartCheckoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartCheckoutResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentUrl', protoName: 'paymentUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartCheckoutResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartCheckoutResponse copyWith(
          void Function(MembershipV2_StoreCartCheckoutResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartCheckoutResponse))
          as MembershipV2_StoreCartCheckoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartCheckoutResponse create() =>
      MembershipV2_StoreCartCheckoutResponse._();
  @$core.override
  MembershipV2_StoreCartCheckoutResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartCheckoutResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_StoreCartCheckoutResponse>(create);
  static MembershipV2_StoreCartCheckoutResponse? _defaultInstance;

  /// for new customers - will contain a payment URL
  /// (new Stripe session)
  ///
  /// if this is empty - then this is existing customer
  /// and we are trying to process the payment
  @$pb.TagNumber(1)
  $core.String get paymentUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentUrl() => $_clearField(1);
}

class MembershipV2_StoreCartUpdateRequest extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartUpdateRequest({
    $core.Iterable<MembershipV2_CartProduct>? products,
    $core.String? ownerEthAddress,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    return result;
  }

  MembershipV2_StoreCartUpdateRequest._();

  factory MembershipV2_StoreCartUpdateRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartUpdateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartUpdateRequest',
      createEmptyInstance: create)
    ..pPM<MembershipV2_CartProduct>(1, _omitFieldNames ? '' : 'products',
        subBuilder: MembershipV2_CartProduct.create)
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartUpdateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartUpdateRequest copyWith(
          void Function(MembershipV2_StoreCartUpdateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartUpdateRequest))
          as MembershipV2_StoreCartUpdateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartUpdateRequest create() =>
      MembershipV2_StoreCartUpdateRequest._();
  @$core.override
  MembershipV2_StoreCartUpdateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartUpdateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_StoreCartUpdateRequest>(create);
  static MembershipV2_StoreCartUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MembershipV2_CartProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get ownerEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerEthAddress() => $_clearField(2);
}

class MembershipV2_StoreCartUpdateResponse extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartUpdateResponse({
    MembershipV2_Cart? cart,
  }) {
    final result = create();
    if (cart != null) result.cart = cart;
    return result;
  }

  MembershipV2_StoreCartUpdateResponse._();

  factory MembershipV2_StoreCartUpdateResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartUpdateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartUpdateResponse',
      createEmptyInstance: create)
    ..aOM<MembershipV2_Cart>(1, _omitFieldNames ? '' : 'cart',
        subBuilder: MembershipV2_Cart.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartUpdateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartUpdateResponse copyWith(
          void Function(MembershipV2_StoreCartUpdateResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartUpdateResponse))
          as MembershipV2_StoreCartUpdateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartUpdateResponse create() =>
      MembershipV2_StoreCartUpdateResponse._();
  @$core.override
  MembershipV2_StoreCartUpdateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartUpdateResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_StoreCartUpdateResponse>(create);
  static MembershipV2_StoreCartUpdateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_Cart get cart => $_getN(0);
  @$pb.TagNumber(1)
  set cart(MembershipV2_Cart value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCart() => $_has(0);
  @$pb.TagNumber(1)
  void clearCart() => $_clearField(1);
  @$pb.TagNumber(1)
  MembershipV2_Cart ensureCart() => $_ensure(0);
}

class MembershipV2_StoreCartClearRequest extends $pb.GeneratedMessage {
  factory MembershipV2_StoreCartClearRequest() => create();

  MembershipV2_StoreCartClearRequest._();

  factory MembershipV2_StoreCartClearRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_StoreCartClearRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.StoreCartClearRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartClearRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_StoreCartClearRequest copyWith(
          void Function(MembershipV2_StoreCartClearRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_StoreCartClearRequest))
          as MembershipV2_StoreCartClearRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartClearRequest create() =>
      MembershipV2_StoreCartClearRequest._();
  @$core.override
  MembershipV2_StoreCartClearRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_StoreCartClearRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_StoreCartClearRequest>(
          create);
  static MembershipV2_StoreCartClearRequest? _defaultInstance;
}

class MembershipV2_WebAuthRequest extends $pb.GeneratedMessage {
  factory MembershipV2_WebAuthRequest() => create();

  MembershipV2_WebAuthRequest._();

  factory MembershipV2_WebAuthRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_WebAuthRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.WebAuthRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_WebAuthRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_WebAuthRequest copyWith(
          void Function(MembershipV2_WebAuthRequest) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_WebAuthRequest))
          as MembershipV2_WebAuthRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_WebAuthRequest create() =>
      MembershipV2_WebAuthRequest._();
  @$core.override
  MembershipV2_WebAuthRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_WebAuthRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_WebAuthRequest>(create);
  static MembershipV2_WebAuthRequest? _defaultInstance;
}

class MembershipV2_WebAuthResponse extends $pb.GeneratedMessage {
  factory MembershipV2_WebAuthResponse({
    $core.String? jwt,
    $core.String? url,
  }) {
    final result = create();
    if (jwt != null) result.jwt = jwt;
    if (url != null) result.url = url;
    return result;
  }

  MembershipV2_WebAuthResponse._();

  factory MembershipV2_WebAuthResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_WebAuthResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.WebAuthResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'jwt')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_WebAuthResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_WebAuthResponse copyWith(
          void Function(MembershipV2_WebAuthResponse) updates) =>
      super.copyWith(
              (message) => updates(message as MembershipV2_WebAuthResponse))
          as MembershipV2_WebAuthResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_WebAuthResponse create() =>
      MembershipV2_WebAuthResponse._();
  @$core.override
  MembershipV2_WebAuthResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_WebAuthResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_WebAuthResponse>(create);
  static MembershipV2_WebAuthResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jwt => $_getSZ(0);
  @$pb.TagNumber(1)
  set jwt($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasJwt() => $_has(0);
  @$pb.TagNumber(1)
  void clearJwt() => $_clearField(1);

  /// (optional) redirect here after the auth
  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);
}

class MembershipV2_AnyNameIsValidRequest extends $pb.GeneratedMessage {
  factory MembershipV2_AnyNameIsValidRequest({
    $core.String? requestedAnyName,
  }) {
    final result = create();
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    return result;
  }

  MembershipV2_AnyNameIsValidRequest._();

  factory MembershipV2_AnyNameIsValidRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_AnyNameIsValidRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.AnyNameIsValidRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameIsValidRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameIsValidRequest copyWith(
          void Function(MembershipV2_AnyNameIsValidRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_AnyNameIsValidRequest))
          as MembershipV2_AnyNameIsValidRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameIsValidRequest create() =>
      MembershipV2_AnyNameIsValidRequest._();
  @$core.override
  MembershipV2_AnyNameIsValidRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameIsValidRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2_AnyNameIsValidRequest>(
          create);
  static MembershipV2_AnyNameIsValidRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestedAnyName => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestedAnyName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestedAnyName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestedAnyName() => $_clearField(1);
}

class MembershipV2_AnyNameIsValidResponse extends $pb.GeneratedMessage {
  factory MembershipV2_AnyNameIsValidResponse({
    MembershipV2_AnyNameIsValidResponse_Code? code,
    $core.String? description,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (description != null) result.description = description;
    return result;
  }

  MembershipV2_AnyNameIsValidResponse._();

  factory MembershipV2_AnyNameIsValidResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_AnyNameIsValidResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.AnyNameIsValidResponse',
      createEmptyInstance: create)
    ..aE<MembershipV2_AnyNameIsValidResponse_Code>(
        1, _omitFieldNames ? '' : 'code',
        enumValues: MembershipV2_AnyNameIsValidResponse_Code.values)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameIsValidResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameIsValidResponse copyWith(
          void Function(MembershipV2_AnyNameIsValidResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_AnyNameIsValidResponse))
          as MembershipV2_AnyNameIsValidResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameIsValidResponse create() =>
      MembershipV2_AnyNameIsValidResponse._();
  @$core.override
  MembershipV2_AnyNameIsValidResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameIsValidResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_AnyNameIsValidResponse>(create);
  static MembershipV2_AnyNameIsValidResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MembershipV2_AnyNameIsValidResponse_Code get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(MembershipV2_AnyNameIsValidResponse_Code value) =>
      $_setField(1, value);
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

class MembershipV2_AnyNameAllocateRequest extends $pb.GeneratedMessage {
  factory MembershipV2_AnyNameAllocateRequest({
    $core.String? requestedAnyName,
    $core.String? ownerEthAddress,
  }) {
    final result = create();
    if (requestedAnyName != null) result.requestedAnyName = requestedAnyName;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    return result;
  }

  MembershipV2_AnyNameAllocateRequest._();

  factory MembershipV2_AnyNameAllocateRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_AnyNameAllocateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.AnyNameAllocateRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestedAnyName',
        protoName: 'requestedAnyName')
    ..aOS(2, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameAllocateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameAllocateRequest copyWith(
          void Function(MembershipV2_AnyNameAllocateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_AnyNameAllocateRequest))
          as MembershipV2_AnyNameAllocateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameAllocateRequest create() =>
      MembershipV2_AnyNameAllocateRequest._();
  @$core.override
  MembershipV2_AnyNameAllocateRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameAllocateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_AnyNameAllocateRequest>(create);
  static MembershipV2_AnyNameAllocateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestedAnyName => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestedAnyName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestedAnyName() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestedAnyName() => $_clearField(1);

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
}

class MembershipV2_AnyNameAllocateResponse extends $pb.GeneratedMessage {
  factory MembershipV2_AnyNameAllocateResponse() => create();

  MembershipV2_AnyNameAllocateResponse._();

  factory MembershipV2_AnyNameAllocateResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_AnyNameAllocateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.AnyNameAllocateResponse',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameAllocateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_AnyNameAllocateResponse copyWith(
          void Function(MembershipV2_AnyNameAllocateResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_AnyNameAllocateResponse))
          as MembershipV2_AnyNameAllocateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameAllocateResponse create() =>
      MembershipV2_AnyNameAllocateResponse._();
  @$core.override
  MembershipV2_AnyNameAllocateResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_AnyNameAllocateResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_AnyNameAllocateResponse>(create);
  static MembershipV2_AnyNameAllocateResponse? _defaultInstance;
}

class MembershipV2_SubscribeToUpdatesRequest extends $pb.GeneratedMessage {
  factory MembershipV2_SubscribeToUpdatesRequest({
    $core.String? email,
    MembershipV2_Platform? platform,
    $core.bool? subscribe,
    $core.String? context,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (platform != null) result.platform = platform;
    if (subscribe != null) result.subscribe = subscribe;
    if (context != null) result.context = context;
    return result;
  }

  MembershipV2_SubscribeToUpdatesRequest._();

  factory MembershipV2_SubscribeToUpdatesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_SubscribeToUpdatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.SubscribeToUpdatesRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aE<MembershipV2_Platform>(2, _omitFieldNames ? '' : 'platform',
        enumValues: MembershipV2_Platform.values)
    ..aOB(3, _omitFieldNames ? '' : 'subscribe')
    ..aOS(4, _omitFieldNames ? '' : 'context')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_SubscribeToUpdatesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_SubscribeToUpdatesRequest copyWith(
          void Function(MembershipV2_SubscribeToUpdatesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_SubscribeToUpdatesRequest))
          as MembershipV2_SubscribeToUpdatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_SubscribeToUpdatesRequest create() =>
      MembershipV2_SubscribeToUpdatesRequest._();
  @$core.override
  MembershipV2_SubscribeToUpdatesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_SubscribeToUpdatesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_SubscribeToUpdatesRequest>(create);
  static MembershipV2_SubscribeToUpdatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  MembershipV2_Platform get platform => $_getN(1);
  @$pb.TagNumber(2)
  set platform(MembershipV2_Platform value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPlatform() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatform() => $_clearField(2);

  /// if false - unsubscribe
  @$pb.TagNumber(3)
  $core.bool get subscribe => $_getBF(2);
  @$pb.TagNumber(3)
  set subscribe($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSubscribe() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubscribe() => $_clearField(3);

  /// additional data
  @$pb.TagNumber(4)
  $core.String get context => $_getSZ(3);
  @$pb.TagNumber(4)
  set context($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContext() => $_has(3);
  @$pb.TagNumber(4)
  void clearContext() => $_clearField(4);
}

class MembershipV2_SubscribeToUpdatesResponse extends $pb.GeneratedMessage {
  factory MembershipV2_SubscribeToUpdatesResponse() => create();

  MembershipV2_SubscribeToUpdatesResponse._();

  factory MembershipV2_SubscribeToUpdatesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2_SubscribeToUpdatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2.SubscribeToUpdatesResponse',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_SubscribeToUpdatesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2_SubscribeToUpdatesResponse copyWith(
          void Function(MembershipV2_SubscribeToUpdatesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as MembershipV2_SubscribeToUpdatesResponse))
          as MembershipV2_SubscribeToUpdatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2_SubscribeToUpdatesResponse create() =>
      MembershipV2_SubscribeToUpdatesResponse._();
  @$core.override
  MembershipV2_SubscribeToUpdatesResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2_SubscribeToUpdatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MembershipV2_SubscribeToUpdatesResponse>(create);
  static MembershipV2_SubscribeToUpdatesResponse? _defaultInstance;
}

class MembershipV2 extends $pb.GeneratedMessage {
  factory MembershipV2() => create();

  MembershipV2._();

  factory MembershipV2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MembershipV2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembershipV2',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2 clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembershipV2 copyWith(void Function(MembershipV2) updates) =>
      super.copyWith((message) => updates(message as MembershipV2))
          as MembershipV2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MembershipV2 create() => MembershipV2._();
  @$core.override
  MembershipV2 createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MembershipV2 getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MembershipV2>(create);
  static MembershipV2? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
