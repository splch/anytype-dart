// This is a generated file - do not edit.
//
// Generated from nameservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class NameAvailableRequest extends $pb.GeneratedMessage {
  factory NameAvailableRequest({
    $core.String? fullName,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    return result;
  }

  NameAvailableRequest._();

  factory NameAvailableRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameAvailableRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameAvailableRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName', protoName: 'fullName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameAvailableRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameAvailableRequest copyWith(void Function(NameAvailableRequest) updates) =>
      super.copyWith((message) => updates(message as NameAvailableRequest))
          as NameAvailableRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameAvailableRequest create() => NameAvailableRequest._();
  @$core.override
  NameAvailableRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameAvailableRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameAvailableRequest>(create);
  static NameAvailableRequest? _defaultInstance;

  /// Name including .any suffix
  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);
}

class BatchNameAvailableRequest extends $pb.GeneratedMessage {
  factory BatchNameAvailableRequest({
    $core.Iterable<$core.String>? fullNames,
  }) {
    final result = create();
    if (fullNames != null) result.fullNames.addAll(fullNames);
    return result;
  }

  BatchNameAvailableRequest._();

  factory BatchNameAvailableRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchNameAvailableRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchNameAvailableRequest',
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'fullNames', protoName: 'fullNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameAvailableRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameAvailableRequest copyWith(
          void Function(BatchNameAvailableRequest) updates) =>
      super.copyWith((message) => updates(message as BatchNameAvailableRequest))
          as BatchNameAvailableRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchNameAvailableRequest create() => BatchNameAvailableRequest._();
  @$core.override
  BatchNameAvailableRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchNameAvailableRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchNameAvailableRequest>(create);
  static BatchNameAvailableRequest? _defaultInstance;

  /// Names including .any suffix
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get fullNames => $_getList(0);
}

class NameByAddressRequest extends $pb.GeneratedMessage {
  factory NameByAddressRequest({
    $core.String? ownerScwEthAddress,
  }) {
    final result = create();
    if (ownerScwEthAddress != null)
      result.ownerScwEthAddress = ownerScwEthAddress;
    return result;
  }

  NameByAddressRequest._();

  factory NameByAddressRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameByAddressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameByAddressRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerScwEthAddress',
        protoName: 'ownerScwEthAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAddressRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAddressRequest copyWith(void Function(NameByAddressRequest) updates) =>
      super.copyWith((message) => updates(message as NameByAddressRequest))
          as NameByAddressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameByAddressRequest create() => NameByAddressRequest._();
  @$core.override
  NameByAddressRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameByAddressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameByAddressRequest>(create);
  static NameByAddressRequest? _defaultInstance;

  /// EOA -> SCW -> name
  /// A SCW Ethereum address that owns that name
  @$pb.TagNumber(1)
  $core.String get ownerScwEthAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerScwEthAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerScwEthAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerScwEthAddress() => $_clearField(1);
}

class BatchNameByAddressRequest extends $pb.GeneratedMessage {
  factory BatchNameByAddressRequest({
    $core.Iterable<$core.String>? ownerScwEthAddresses,
  }) {
    final result = create();
    if (ownerScwEthAddresses != null)
      result.ownerScwEthAddresses.addAll(ownerScwEthAddresses);
    return result;
  }

  BatchNameByAddressRequest._();

  factory BatchNameByAddressRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchNameByAddressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchNameByAddressRequest',
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'ownerScwEthAddresses',
        protoName: 'ownerScwEthAddresses')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAddressRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAddressRequest copyWith(
          void Function(BatchNameByAddressRequest) updates) =>
      super.copyWith((message) => updates(message as BatchNameByAddressRequest))
          as BatchNameByAddressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchNameByAddressRequest create() => BatchNameByAddressRequest._();
  @$core.override
  BatchNameByAddressRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchNameByAddressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchNameByAddressRequest>(create);
  static BatchNameByAddressRequest? _defaultInstance;

  /// EOA -> SCW -> name
  /// A SCW Ethereum address that owns that name
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get ownerScwEthAddresses => $_getList(0);
}

class NameByAnyIdRequest extends $pb.GeneratedMessage {
  factory NameByAnyIdRequest({
    $core.String? anyAddress,
  }) {
    final result = create();
    if (anyAddress != null) result.anyAddress = anyAddress;
    return result;
  }

  NameByAnyIdRequest._();

  factory NameByAnyIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameByAnyIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameByAnyIdRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'anyAddress', protoName: 'anyAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAnyIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAnyIdRequest copyWith(void Function(NameByAnyIdRequest) updates) =>
      super.copyWith((message) => updates(message as NameByAnyIdRequest))
          as NameByAnyIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameByAnyIdRequest create() => NameByAnyIdRequest._();
  @$core.override
  NameByAnyIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameByAnyIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameByAnyIdRequest>(create);
  static NameByAnyIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get anyAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set anyAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnyAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnyAddress() => $_clearField(1);
}

class BatchNameByAnyIdRequest extends $pb.GeneratedMessage {
  factory BatchNameByAnyIdRequest({
    $core.Iterable<$core.String>? anyAddresses,
  }) {
    final result = create();
    if (anyAddresses != null) result.anyAddresses.addAll(anyAddresses);
    return result;
  }

  BatchNameByAnyIdRequest._();

  factory BatchNameByAnyIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchNameByAnyIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchNameByAnyIdRequest',
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'anyAddresses', protoName: 'anyAddresses')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAnyIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAnyIdRequest copyWith(
          void Function(BatchNameByAnyIdRequest) updates) =>
      super.copyWith((message) => updates(message as BatchNameByAnyIdRequest))
          as BatchNameByAnyIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchNameByAnyIdRequest create() => BatchNameByAnyIdRequest._();
  @$core.override
  BatchNameByAnyIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchNameByAnyIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchNameByAnyIdRequest>(create);
  static BatchNameByAnyIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get anyAddresses => $_getList(0);
}

class NameAvailableResponse extends $pb.GeneratedMessage {
  factory NameAvailableResponse({
    $core.bool? available,
    $core.String? ownerScwEthAddress,
    $core.String? ownerEthAddress,
    $core.String? ownerAnyAddress,
    $core.String? spaceId,
    $fixnum.Int64? nameExpires,
  }) {
    final result = create();
    if (available != null) result.available = available;
    if (ownerScwEthAddress != null)
      result.ownerScwEthAddress = ownerScwEthAddress;
    if (ownerEthAddress != null) result.ownerEthAddress = ownerEthAddress;
    if (ownerAnyAddress != null) result.ownerAnyAddress = ownerAnyAddress;
    if (spaceId != null) result.spaceId = spaceId;
    if (nameExpires != null) result.nameExpires = nameExpires;
    return result;
  }

  NameAvailableResponse._();

  factory NameAvailableResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameAvailableResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameAvailableResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'available')
    ..aOS(2, _omitFieldNames ? '' : 'ownerScwEthAddress',
        protoName: 'ownerScwEthAddress')
    ..aOS(3, _omitFieldNames ? '' : 'ownerEthAddress',
        protoName: 'ownerEthAddress')
    ..aOS(4, _omitFieldNames ? '' : 'ownerAnyAddress',
        protoName: 'ownerAnyAddress')
    ..aOS(5, _omitFieldNames ? '' : 'spaceId', protoName: 'spaceId')
    ..aInt64(6, _omitFieldNames ? '' : 'nameExpires', protoName: 'nameExpires')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameAvailableResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameAvailableResponse copyWith(
          void Function(NameAvailableResponse) updates) =>
      super.copyWith((message) => updates(message as NameAvailableResponse))
          as NameAvailableResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameAvailableResponse create() => NameAvailableResponse._();
  @$core.override
  NameAvailableResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameAvailableResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameAvailableResponse>(create);
  static NameAvailableResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => $_clearField(1);

  /// EOA -> SCW -> name
  /// This field is non-empty only if name is "already registered"
  @$pb.TagNumber(2)
  $core.String get ownerScwEthAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set ownerScwEthAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOwnerScwEthAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearOwnerScwEthAddress() => $_clearField(2);

  /// This field is non-empty only if name is "already registered"
  @$pb.TagNumber(3)
  $core.String get ownerEthAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerEthAddress($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerEthAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerEthAddress() => $_clearField(3);

  /// A content hash attached to this name
  /// This field is non-empty only if name is "already registered"
  @$pb.TagNumber(4)
  $core.String get ownerAnyAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set ownerAnyAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOwnerAnyAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearOwnerAnyAddress() => $_clearField(4);

  /// A SpaceID attached to this name
  /// This field is non-empty only if name is "already registered"
  @$pb.TagNumber(5)
  $core.String get spaceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set spaceId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSpaceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpaceId() => $_clearField(5);

  ///  doesn't work with marashalling/unmarshalling
  /// google.protobuf.Timestamp nameExpires = 5 [(gogoproto.stdtime) = true];
  @$pb.TagNumber(6)
  $fixnum.Int64 get nameExpires => $_getI64(5);
  @$pb.TagNumber(6)
  set nameExpires($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNameExpires() => $_has(5);
  @$pb.TagNumber(6)
  void clearNameExpires() => $_clearField(6);
}

class BatchNameAvailableResponse extends $pb.GeneratedMessage {
  factory BatchNameAvailableResponse({
    $core.Iterable<NameAvailableResponse>? results,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    return result;
  }

  BatchNameAvailableResponse._();

  factory BatchNameAvailableResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchNameAvailableResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchNameAvailableResponse',
      createEmptyInstance: create)
    ..pPM<NameAvailableResponse>(1, _omitFieldNames ? '' : 'results',
        subBuilder: NameAvailableResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameAvailableResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameAvailableResponse copyWith(
          void Function(BatchNameAvailableResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BatchNameAvailableResponse))
          as BatchNameAvailableResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchNameAvailableResponse create() => BatchNameAvailableResponse._();
  @$core.override
  BatchNameAvailableResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchNameAvailableResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchNameAvailableResponse>(create);
  static BatchNameAvailableResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NameAvailableResponse> get results => $_getList(0);
}

class NameByAddressResponse extends $pb.GeneratedMessage {
  factory NameByAddressResponse({
    $core.bool? found,
    $core.String? name,
  }) {
    final result = create();
    if (found != null) result.found = found;
    if (name != null) result.name = name;
    return result;
  }

  NameByAddressResponse._();

  factory NameByAddressResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NameByAddressResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NameByAddressResponse',
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'found')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAddressResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NameByAddressResponse copyWith(
          void Function(NameByAddressResponse) updates) =>
      super.copyWith((message) => updates(message as NameByAddressResponse))
          as NameByAddressResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NameByAddressResponse create() => NameByAddressResponse._();
  @$core.override
  NameByAddressResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NameByAddressResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NameByAddressResponse>(create);
  static NameByAddressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get found => $_getBF(0);
  @$pb.TagNumber(1)
  set found($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFound() => $_has(0);
  @$pb.TagNumber(1)
  void clearFound() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class BatchNameByAddressResponse extends $pb.GeneratedMessage {
  factory BatchNameByAddressResponse({
    $core.Iterable<NameByAddressResponse>? results,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    return result;
  }

  BatchNameByAddressResponse._();

  factory BatchNameByAddressResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BatchNameByAddressResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchNameByAddressResponse',
      createEmptyInstance: create)
    ..pPM<NameByAddressResponse>(1, _omitFieldNames ? '' : 'results',
        subBuilder: NameByAddressResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAddressResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BatchNameByAddressResponse copyWith(
          void Function(BatchNameByAddressResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BatchNameByAddressResponse))
          as BatchNameByAddressResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchNameByAddressResponse create() => BatchNameByAddressResponse._();
  @$core.override
  BatchNameByAddressResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BatchNameByAddressResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchNameByAddressResponse>(create);
  static BatchNameByAddressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NameByAddressResponse> get results => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
