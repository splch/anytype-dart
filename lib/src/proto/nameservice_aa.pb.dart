// This is a generated file - do not edit.
//
// Generated from nameservice_aa.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'nameservice_aa.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'nameservice_aa.pbenum.dart';

class UserAccount extends $pb.GeneratedMessage {
  factory UserAccount({
    $core.String? ownerEthAddress,
    $core.String? ownerSmartContracWalletAddress,
    $core.bool? ownerSmartContracWalletDeployed,
    $fixnum.Int64? namesCountLeft,
    $fixnum.Int64? operationsCountLeft,
  }) {
    final result = create();
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (ownerSmartContracWalletAddress != null)
      result.ownerSmartContracWalletAddress = ownerSmartContracWalletAddress;
    if (ownerSmartContracWalletDeployed != null)
      result.ownerSmartContracWalletDeployed = ownerSmartContracWalletDeployed;
    if (namesCountLeft != null) result.namesCountLeft = namesCountLeft;
    if (operationsCountLeft != null)
      result.operationsCountLeft = operationsCountLeft;
    return result;
  }

  UserAccount._();

  factory UserAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserAccount',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(2, _omitFieldNames ? '' : 'ownerSmartContracWalletAddress',
        protoName: 'ownerSmartContracWalletAddress')
    ..aOB(3, _omitFieldNames ? '' : 'ownerSmartContracWalletDeployed',
        protoName: 'ownerSmartContracWalletDeployed')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'namesCountLeft', $pb.PbFieldType.OU6,
        protoName: 'namesCountLeft', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'operationsCountLeft', $pb.PbFieldType.OU6,
        protoName: 'operationsCountLeft', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAccount clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserAccount copyWith(void Function(UserAccount) updates) =>
      super.copyWith((message) => updates(message as UserAccount))
          as UserAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserAccount create() => UserAccount._();
  @$core.override
  UserAccount createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserAccount>(create);
  static UserAccount? _defaultInstance;

  /// An Ethereum address that owns that account
  @$pb.TagNumber(1)
  $core.String get ownerEthAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerEthAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerEthAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerEthAddress() => $_clearField(1);

  /// This smart contract really controls all names
  /// you can ask .owner() method to get 'ownerEthAddress'
  @$pb.TagNumber(2)
  $core.String get ownerSmartContracWalletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerSmartContracWalletAddress($core.String value) =>
      $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerSmartContracWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerSmartContracWalletAddress() => $_clearField(2);

  /// The ownerSmartContracWalletAddress field is calculated automatically
  /// from ownerEthAddress even if SCW is not deployed yet
  /// SCW is deployed automatically after first operation
  @$pb.TagNumber(3)
  $core.bool get ownerSmartContracWalletDeployed => $_getBF(2);
  @$pb.TagNumber(3)
  set ownerSmartContracWalletDeployed($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerSmartContracWalletDeployed() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerSmartContracWalletDeployed() => $_clearField(3);

  /// Number of names that the user can buy. We will mint him tokens that he can use to buy names
  /// (one token per name)
  @$pb.TagNumber(4)
  $fixnum.Int64 get namesCountLeft => $_getI64(3);
  @$pb.TagNumber(4)
  set namesCountLeft($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNamesCountLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearNamesCountLeft() => $_clearField(4);

  /// Number of gas operations: update name, add new data, etc
  @$pb.TagNumber(5)
  $fixnum.Int64 get operationsCountLeft => $_getI64(4);
  @$pb.TagNumber(5)
  set operationsCountLeft($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOperationsCountLeft() => $_has(4);
  @$pb.TagNumber(5)
  void clearOperationsCountLeft() => $_clearField(5);
}

class AdminFundUserAccountRequest extends $pb.GeneratedMessage {
  factory AdminFundUserAccountRequest({
    $core.String? ownerEthAddress,
    $fixnum.Int64? namesCount,
  }) {
    final result = create();
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (namesCount != null) result.namesCount = namesCount;
    return result;
  }

  AdminFundUserAccountRequest._();

  factory AdminFundUserAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFundUserAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFundUserAccountRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'namesCount', $pb.PbFieldType.OU6,
        protoName: 'namesCount', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundUserAccountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundUserAccountRequest copyWith(
          void Function(AdminFundUserAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminFundUserAccountRequest))
          as AdminFundUserAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFundUserAccountRequest create() =>
      AdminFundUserAccountRequest._();
  @$core.override
  AdminFundUserAccountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminFundUserAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFundUserAccountRequest>(create);
  static AdminFundUserAccountRequest? _defaultInstance;

  /// An Ethereum address that owns that name
  @$pb.TagNumber(1)
  $core.String get ownerEthAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerEthAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerEthAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerEthAddress() => $_clearField(1);

  /// Number of names that user can buy. We will mint him tokens that he can use to buy names
  /// (one token per name)
  @$pb.TagNumber(2)
  $fixnum.Int64 get namesCount => $_getI64(1);
  @$pb.TagNumber(2)
  set namesCount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNamesCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearNamesCount() => $_clearField(2);
}

class AdminFundUserAccountRequestSigned extends $pb.GeneratedMessage {
  factory AdminFundUserAccountRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  AdminFundUserAccountRequestSigned._();

  factory AdminFundUserAccountRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFundUserAccountRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFundUserAccountRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundUserAccountRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundUserAccountRequestSigned copyWith(
          void Function(AdminFundUserAccountRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as AdminFundUserAccountRequestSigned))
          as AdminFundUserAccountRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFundUserAccountRequestSigned create() =>
      AdminFundUserAccountRequestSigned._();
  @$core.override
  AdminFundUserAccountRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminFundUserAccountRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFundUserAccountRequestSigned>(
          create);
  static AdminFundUserAccountRequestSigned? _defaultInstance;

  /// AdminFundUserAccountRequest struct
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// payload signed by Admin of this service
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class AdminFundGasOperationsRequest extends $pb.GeneratedMessage {
  factory AdminFundGasOperationsRequest({
    $core.String? ownerEthAddress,
    $core.String? ownerAnyID,
    $fixnum.Int64? operationsCount,
  }) {
    final result = create();
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (ownerAnyID != null) result.ownerAnyID = ownerAnyID;
    if (operationsCount != null) result.operationsCount = operationsCount;
    return result;
  }

  AdminFundGasOperationsRequest._();

  factory AdminFundGasOperationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFundGasOperationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFundGasOperationsRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(2, _omitFieldNames ? '' : 'ownerAnyID', protoName: 'ownerAnyID')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'operationsCount', $pb.PbFieldType.OU6,
        protoName: 'operationsCount', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundGasOperationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundGasOperationsRequest copyWith(
          void Function(AdminFundGasOperationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminFundGasOperationsRequest))
          as AdminFundGasOperationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFundGasOperationsRequest create() =>
      AdminFundGasOperationsRequest._();
  @$core.override
  AdminFundGasOperationsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminFundGasOperationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFundGasOperationsRequest>(create);
  static AdminFundGasOperationsRequest? _defaultInstance;

  /// An Ethereum address that owns that name
  @$pb.TagNumber(1)
  $core.String get ownerEthAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerEthAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerEthAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerEthAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get ownerAnyID => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerAnyID($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerAnyID() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerAnyID() => $_clearField(2);

  /// Number of gas operations: update name, add new data, etc
  @$pb.TagNumber(3)
  $fixnum.Int64 get operationsCount => $_getI64(2);
  @$pb.TagNumber(3)
  set operationsCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOperationsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperationsCount() => $_clearField(3);
}

class AdminFundGasOperationsRequestSigned extends $pb.GeneratedMessage {
  factory AdminFundGasOperationsRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  AdminFundGasOperationsRequestSigned._();

  factory AdminFundGasOperationsRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFundGasOperationsRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFundGasOperationsRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundGasOperationsRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFundGasOperationsRequestSigned copyWith(
          void Function(AdminFundGasOperationsRequestSigned) updates) =>
      super.copyWith((message) =>
              updates(message as AdminFundGasOperationsRequestSigned))
          as AdminFundGasOperationsRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFundGasOperationsRequestSigned create() =>
      AdminFundGasOperationsRequestSigned._();
  @$core.override
  AdminFundGasOperationsRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminFundGasOperationsRequestSigned getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminFundGasOperationsRequestSigned>(create);
  static AdminFundGasOperationsRequestSigned? _defaultInstance;

  /// AdminFundGasOperationsRequest struct
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// payload signed by Admin of this service
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

/// no signature required here
class GetUserAccountRequest extends $pb.GeneratedMessage {
  factory GetUserAccountRequest({
    $core.String? ownerEthAddress,
  }) {
    final result = create();
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    return result;
  }

  GetUserAccountRequest._();

  factory GetUserAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserAccountRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserAccountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserAccountRequest copyWith(
          void Function(GetUserAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserAccountRequest))
          as GetUserAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAccountRequest create() => GetUserAccountRequest._();
  @$core.override
  GetUserAccountRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserAccountRequest>(create);
  static GetUserAccountRequest? _defaultInstance;

  /// An Ethereum address that owns that account
  @$pb.TagNumber(1)
  $core.String get ownerEthAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerEthAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerEthAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerEthAddress() => $_clearField(1);
}

class GetDataNameRegisterResponse extends $pb.GeneratedMessage {
  factory GetDataNameRegisterResponse({
    $core.List<$core.int>? data,
    $core.List<$core.int>? context,
  }) {
    final result = create();
    if (data != null) result.data = data;
    if (context != null) result.context = context;
    return result;
  }

  GetDataNameRegisterResponse._();

  factory GetDataNameRegisterResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDataNameRegisterResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDataNameRegisterResponse',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'context', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDataNameRegisterResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDataNameRegisterResponse copyWith(
          void Function(GetDataNameRegisterResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetDataNameRegisterResponse))
          as GetDataNameRegisterResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDataNameRegisterResponse create() =>
      GetDataNameRegisterResponse._();
  @$core.override
  GetDataNameRegisterResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetDataNameRegisterResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDataNameRegisterResponse>(create);
  static GetDataNameRegisterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get context => $_getN(1);
  @$pb.TagNumber(2)
  set context($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearContext() => $_clearField(2);
}

class CreateUserOperationRequest extends $pb.GeneratedMessage {
  factory CreateUserOperationRequest({
    $core.List<$core.int>? data,
    $core.List<$core.int>? signedData,
    $core.List<$core.int>? context,
    $core.String? ownerEthAddress,
    $core.String? ownerAnyID,
    $core.String? fullName,
  }) {
    final result = create();
    if (data != null) result.data = data;
    if (signedData != null) result.signedData = signedData;
    if (context != null) result.context = context;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (ownerAnyID != null) result.ownerAnyID = ownerAnyID;
    if (fullName != null) result.fullName = fullName;
    return result;
  }

  CreateUserOperationRequest._();

  factory CreateUserOperationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserOperationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserOperationRequest',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signedData', $pb.PbFieldType.OY,
        protoName: 'signedData')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'context', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(5, _omitFieldNames ? '' : 'ownerAnyID', protoName: 'ownerAnyID')
    ..aOS(6, _omitFieldNames ? '' : 'fullName', protoName: 'fullName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserOperationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserOperationRequest copyWith(
          void Function(CreateUserOperationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateUserOperationRequest))
          as CreateUserOperationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserOperationRequest create() => CreateUserOperationRequest._();
  @$core.override
  CreateUserOperationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateUserOperationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserOperationRequest>(create);
  static CreateUserOperationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  /// "data" signed with Ethereum private key
  @$pb.TagNumber(2)
  $core.List<$core.int> get signedData => $_getN(1);
  @$pb.TagNumber(2)
  set signedData($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignedData() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignedData() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get context => $_getN(2);
  @$pb.TagNumber(3)
  set context($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContext() => $_has(2);
  @$pb.TagNumber(3)
  void clearContext() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get ownerEthAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set ownerEthAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOwnerEthAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearOwnerEthAddress() => $_clearField(4);

  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(5)
  $core.String get ownerAnyID => $_getSZ(4);
  @$pb.TagNumber(5)
  set ownerAnyID($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOwnerAnyID() => $_has(4);
  @$pb.TagNumber(5)
  void clearOwnerAnyID() => $_clearField(5);

  /// all operations currently are towards single name, please specify it
  /// we can use it for caching, etc purps.
  @$pb.TagNumber(6)
  $core.String get fullName => $_getSZ(5);
  @$pb.TagNumber(6)
  set fullName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFullName() => $_has(5);
  @$pb.TagNumber(6)
  void clearFullName() => $_clearField(6);
}

class CreateUserOperationRequestSigned extends $pb.GeneratedMessage {
  factory CreateUserOperationRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  CreateUserOperationRequestSigned._();

  factory CreateUserOperationRequestSigned.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateUserOperationRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUserOperationRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserOperationRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUserOperationRequestSigned copyWith(
          void Function(CreateUserOperationRequestSigned) updates) =>
      super.copyWith(
              (message) => updates(message as CreateUserOperationRequestSigned))
          as CreateUserOperationRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserOperationRequestSigned create() =>
      CreateUserOperationRequestSigned._();
  @$core.override
  CreateUserOperationRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateUserOperationRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUserOperationRequestSigned>(
          create);
  static CreateUserOperationRequestSigned? _defaultInstance;

  /// CreateUserOperationRequest struct
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// payload signed with Anytype identity
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class NameRegisterRequest extends $pb.GeneratedMessage {
  factory NameRegisterRequest({
    $core.String? fullName,
    $core.String? ownerAnyAddress,
    $core.String? ownerEthAddress,
    $core.bool? registerToSmartContractWallet,
    $core.int? registerPeriodMonths,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    if (ownerAnyAddress != null) result.ownerAnyAddress = ownerAnyAddress;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (registerToSmartContractWallet != null)
      result.registerToSmartContractWallet = registerToSmartContractWallet;
    if (registerPeriodMonths != null)
      result.registerPeriodMonths = registerPeriodMonths;
    return result;
  }

  NameRegisterRequest._();

  factory NameRegisterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameRegisterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameRegisterRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName', protoName: 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'ownerAnyAddress',
        protoName: 'ownerAnyAddress')
    ..aOS(3, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOB(4, _omitFieldNames ? '' : 'registerToSmartContractWallet',
        protoName: 'registerToSmartContractWallet')
    ..aI(5, _omitFieldNames ? '' : 'registerPeriodMonths',
        protoName: 'registerPeriodMonths', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterRequest copyWith(void Function(NameRegisterRequest) updates) =>
      super.copyWith((message) => updates(message as NameRegisterRequest))
          as NameRegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRegisterRequest create() => NameRegisterRequest._();
  @$core.override
  NameRegisterRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameRegisterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameRegisterRequest>(create);
  static NameRegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);

  /// A content hash attached to this name
  /// This should not be empty!
  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(2)
  $core.String get ownerAnyAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerAnyAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerAnyAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerAnyAddress() => $_clearField(2);

  /// An Ethereum address that owns that name
  @$pb.TagNumber(3)
  $core.String get ownerEthAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerEthAddress($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerEthAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerEthAddress() => $_clearField(3);

  /// if false -> name ownership will belong to ownerEthAddress
  /// if true -> name ownership will belong to SCW of ownerEthAddress (AccountAbstraction)
  @$pb.TagNumber(4)
  $core.bool get registerToSmartContractWallet => $_getBF(3);
  @$pb.TagNumber(4)
  set registerToSmartContractWallet($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRegisterToSmartContractWallet() => $_has(3);
  @$pb.TagNumber(4)
  void clearRegisterToSmartContractWallet() => $_clearField(4);

  /// How many months to register the name for
  @$pb.TagNumber(5)
  $core.int get registerPeriodMonths => $_getIZ(4);
  @$pb.TagNumber(5)
  set registerPeriodMonths($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRegisterPeriodMonths() => $_has(4);
  @$pb.TagNumber(5)
  void clearRegisterPeriodMonths() => $_clearField(5);
}

class NameRegisterRequestSigned extends $pb.GeneratedMessage {
  factory NameRegisterRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  NameRegisterRequestSigned._();

  factory NameRegisterRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameRegisterRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameRegisterRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterRequestSigned copyWith(
          void Function(NameRegisterRequestSigned) updates) =>
      super.copyWith((message) => updates(message as NameRegisterRequestSigned))
          as NameRegisterRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRegisterRequestSigned create() => NameRegisterRequestSigned._();
  @$core.override
  NameRegisterRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameRegisterRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameRegisterRequestSigned>(create);
  static NameRegisterRequestSigned? _defaultInstance;

  /// NameRegisterRequest struct
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// payload signed by payload.ownerEthAddress
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class NameRenewRequest extends $pb.GeneratedMessage {
  factory NameRenewRequest({
    $core.String? fullName,
    $core.String? ownerAnyAddress,
    $core.String? ownerEthAddress,
    $core.bool? renewToSmartContractWallet,
    $core.int? renewPeriodMonths,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    if (ownerAnyAddress != null) result.ownerAnyAddress = ownerAnyAddress;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (renewToSmartContractWallet != null)
      result.renewToSmartContractWallet = renewToSmartContractWallet;
    if (renewPeriodMonths != null) result.renewPeriodMonths = renewPeriodMonths;
    return result;
  }

  NameRenewRequest._();

  factory NameRenewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameRenewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameRenewRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName', protoName: 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'ownerAnyAddress',
        protoName: 'ownerAnyAddress')
    ..aOS(3, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOB(4, _omitFieldNames ? '' : 'renewToSmartContractWallet',
        protoName: 'renewToSmartContractWallet')
    ..aI(5, _omitFieldNames ? '' : 'renewPeriodMonths',
        protoName: 'renewPeriodMonths', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRenewRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRenewRequest copyWith(void Function(NameRenewRequest) updates) =>
      super.copyWith((message) => updates(message as NameRenewRequest))
          as NameRenewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRenewRequest create() => NameRenewRequest._();
  @$core.override
  NameRenewRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameRenewRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameRenewRequest>(create);
  static NameRenewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);

  /// A content hash attached to this name
  /// This should not be empty!
  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(2)
  $core.String get ownerAnyAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerAnyAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerAnyAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerAnyAddress() => $_clearField(2);

  /// An Ethereum address that owns that name
  @$pb.TagNumber(3)
  $core.String get ownerEthAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerEthAddress($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerEthAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerEthAddress() => $_clearField(3);

  /// if false -> name ownership will belong to ownerEthAddress
  /// if true -> name ownership will belong to SCW of ownerEthAddress (AccountAbstraction)
  @$pb.TagNumber(4)
  $core.bool get renewToSmartContractWallet => $_getBF(3);
  @$pb.TagNumber(4)
  set renewToSmartContractWallet($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRenewToSmartContractWallet() => $_has(3);
  @$pb.TagNumber(4)
  void clearRenewToSmartContractWallet() => $_clearField(4);

  /// How many months to register the name for
  @$pb.TagNumber(5)
  $core.int get renewPeriodMonths => $_getIZ(4);
  @$pb.TagNumber(5)
  set renewPeriodMonths($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRenewPeriodMonths() => $_has(4);
  @$pb.TagNumber(5)
  void clearRenewPeriodMonths() => $_clearField(5);
}

class NameRenewRequestSigned extends $pb.GeneratedMessage {
  factory NameRenewRequestSigned({
    $core.List<$core.int>? payload,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (signature != null) result.signature = signature;
    return result;
  }

  NameRenewRequestSigned._();

  factory NameRenewRequestSigned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameRenewRequestSigned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameRenewRequestSigned',
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRenewRequestSigned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRenewRequestSigned copyWith(
          void Function(NameRenewRequestSigned) updates) =>
      super.copyWith((message) => updates(message as NameRenewRequestSigned))
          as NameRenewRequestSigned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRenewRequestSigned create() => NameRenewRequestSigned._();
  @$core.override
  NameRenewRequestSigned createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameRenewRequestSigned getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameRenewRequestSigned>(create);
  static NameRenewRequestSigned? _defaultInstance;

  /// NameRenewRequest struct
  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  /// payload signed by payload.ownerEthAddress
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class NameRegisterForSpaceRequest extends $pb.GeneratedMessage {
  factory NameRegisterForSpaceRequest({
    $core.String? fullName,
    $core.String? ownerAnyAddress,
    $core.String? ownerEthAddress,
    $core.String? spaceId,
    $core.int? registerPeriodMonths,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    if (ownerAnyAddress != null) result.ownerAnyAddress = ownerAnyAddress;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (spaceId != null) result.spaceId = spaceId;
    if (registerPeriodMonths != null)
      result.registerPeriodMonths = registerPeriodMonths;
    return result;
  }

  NameRegisterForSpaceRequest._();

  factory NameRegisterForSpaceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameRegisterForSpaceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameRegisterForSpaceRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName', protoName: 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'ownerAnyAddress',
        protoName: 'ownerAnyAddress')
    ..aOS(3, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(4, _omitFieldNames ? '' : 'spaceId', protoName: 'spaceId')
    ..aI(5, _omitFieldNames ? '' : 'registerPeriodMonths',
        protoName: 'registerPeriodMonths', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterForSpaceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameRegisterForSpaceRequest copyWith(
          void Function(NameRegisterForSpaceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as NameRegisterForSpaceRequest))
          as NameRegisterForSpaceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameRegisterForSpaceRequest create() =>
      NameRegisterForSpaceRequest._();
  @$core.override
  NameRegisterForSpaceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameRegisterForSpaceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameRegisterForSpaceRequest>(create);
  static NameRegisterForSpaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);

  /// A content hash attached to this name
  /// This should not be empty!
  /// in the following format: "A5k2d9sFZw84yisTxRnz2bPRd1YPfVfhxqymZ6yESprFTG65"
  /// you can get it with Account().SignKey.GetPublic().Account()
  @$pb.TagNumber(2)
  $core.String get ownerAnyAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerAnyAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerAnyAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerAnyAddress() => $_clearField(2);

  /// An Ethereum address that owns that name
  @$pb.TagNumber(3)
  $core.String get ownerEthAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerEthAddress($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerEthAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerEthAddress() => $_clearField(3);

  /// A SpaceID attached to this name
  @$pb.TagNumber(4)
  $core.String get spaceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set spaceId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpaceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpaceId() => $_clearField(4);

  /// How many months to register the name for
  @$pb.TagNumber(5)
  $core.int get registerPeriodMonths => $_getIZ(4);
  @$pb.TagNumber(5)
  set registerPeriodMonths($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRegisterPeriodMonths() => $_has(4);
  @$pb.TagNumber(5)
  void clearRegisterPeriodMonths() => $_clearField(5);
}

class GetOperationStatusRequest extends $pb.GeneratedMessage {
  factory GetOperationStatusRequest({
    $core.String? operationId,
  }) {
    final result = create();
    if (operationId != null) result.operationId = operationId;
    return result;
  }

  GetOperationStatusRequest._();

  factory GetOperationStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOperationStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOperationStatusRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'operationId', protoName: 'operationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOperationStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOperationStatusRequest copyWith(
          void Function(GetOperationStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetOperationStatusRequest))
          as GetOperationStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOperationStatusRequest create() => GetOperationStatusRequest._();
  @$core.override
  GetOperationStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetOperationStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOperationStatusRequest>(create);
  static GetOperationStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get operationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set operationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOperationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperationId() => $_clearField(1);
}

class OperationResponse extends $pb.GeneratedMessage {
  factory OperationResponse({
    $core.String? operationId,
    OperationState? operationState,
  }) {
    final result = create();
    if (operationId != null) result.operationId = operationId;
    if (operationState != null) result.operationState = operationState;
    return result;
  }

  OperationResponse._();

  factory OperationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OperationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationResponse',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'operationId', protoName: 'operationId')
    ..aE<OperationState>(2, _omitFieldNames ? '' : 'operationState',
        protoName: 'operationState', enumValues: OperationState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OperationResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OperationResponse copyWith(void Function(OperationResponse) updates) =>
      super.copyWith((message) => updates(message as OperationResponse))
          as OperationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationResponse create() => OperationResponse._();
  @$core.override
  OperationResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OperationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationResponse>(create);
  static OperationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get operationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set operationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOperationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperationId() => $_clearField(1);

  @$pb.TagNumber(2)
  OperationState get operationState => $_getN(1);
  @$pb.TagNumber(2)
  set operationState(OperationState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasOperationState() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperationState() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
