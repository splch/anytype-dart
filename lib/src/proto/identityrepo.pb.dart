// This is a generated file - do not edit.
//
// Generated from identityrepo.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Data extends $pb.GeneratedMessage {
  factory Data({
    $core.String? kind,
    $core.List<$core.int>? data,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (data != null) result.data = data;
    if (signature != null) result.signature = signature;
    return result;
  }

  Data._();

  factory Data.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Data.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Data',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'kind')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Data clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Data copyWith(void Function(Data) updates) =>
      super.copyWith((message) => updates(message as Data)) as Data;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Data create() => Data._();
  @$core.override
  Data createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Data getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Data>(create);
  static Data? _defaultInstance;

  /// kind is a string representing the kind of data
  @$pb.TagNumber(1)
  $core.String get kind => $_getSZ(0);
  @$pb.TagNumber(1)
  set kind($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// data is a byte payload
  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);

  /// data signature
  @$pb.TagNumber(3)
  $core.List<$core.int> get signature => $_getN(2);
  @$pb.TagNumber(3)
  set signature($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);
}

class DataWithIdentity extends $pb.GeneratedMessage {
  factory DataWithIdentity({
    $core.String? identity,
    $core.Iterable<Data>? data,
  }) {
    final result = create();
    if (identity != null) result.identity = identity;
    if (data != null) result.data.addAll(data);
    return result;
  }

  DataWithIdentity._();

  factory DataWithIdentity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataWithIdentity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataWithIdentity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'identity')
    ..pPM<Data>(2, _omitFieldNames ? '' : 'data', subBuilder: Data.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataWithIdentity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataWithIdentity copyWith(void Function(DataWithIdentity) updates) =>
      super.copyWith((message) => updates(message as DataWithIdentity))
          as DataWithIdentity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataWithIdentity create() => DataWithIdentity._();
  @$core.override
  DataWithIdentity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataWithIdentity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataWithIdentity>(create);
  static DataWithIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get identity => $_getSZ(0);
  @$pb.TagNumber(1)
  set identity($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentity() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Data> get data => $_getList(1);
}

class DataPutRequest extends $pb.GeneratedMessage {
  factory DataPutRequest({
    $core.String? identity,
    $core.Iterable<Data>? data,
  }) {
    final result = create();
    if (identity != null) result.identity = identity;
    if (data != null) result.data.addAll(data);
    return result;
  }

  DataPutRequest._();

  factory DataPutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataPutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataPutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'identity')
    ..pPM<Data>(2, _omitFieldNames ? '' : 'data', subBuilder: Data.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPutRequest copyWith(void Function(DataPutRequest) updates) =>
      super.copyWith((message) => updates(message as DataPutRequest))
          as DataPutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataPutRequest create() => DataPutRequest._();
  @$core.override
  DataPutRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataPutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataPutRequest>(create);
  static DataPutRequest? _defaultInstance;

  /// string representation of identity, must be equal handshake result
  @$pb.TagNumber(1)
  $core.String get identity => $_getSZ(0);
  @$pb.TagNumber(1)
  set identity($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentity() => $_clearField(1);

  /// data to save
  @$pb.TagNumber(2)
  $pb.PbList<Data> get data => $_getList(1);
}

class DataDeleteRequest extends $pb.GeneratedMessage {
  factory DataDeleteRequest({
    $core.String? identity,
    $core.Iterable<$core.String>? kinds,
  }) {
    final result = create();
    if (identity != null) result.identity = identity;
    if (kinds != null) result.kinds.addAll(kinds);
    return result;
  }

  DataDeleteRequest._();

  factory DataDeleteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataDeleteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataDeleteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'identity')
    ..pPS(2, _omitFieldNames ? '' : 'kinds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataDeleteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataDeleteRequest copyWith(void Function(DataDeleteRequest) updates) =>
      super.copyWith((message) => updates(message as DataDeleteRequest))
          as DataDeleteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataDeleteRequest create() => DataDeleteRequest._();
  @$core.override
  DataDeleteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataDeleteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataDeleteRequest>(create);
  static DataDeleteRequest? _defaultInstance;

  /// string representation of identity, must be equal handshake result
  @$pb.TagNumber(1)
  $core.String get identity => $_getSZ(0);
  @$pb.TagNumber(1)
  set identity($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentity() => $_clearField(1);

  /// kinds of data to delete, if empty all kinds will be deleted
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get kinds => $_getList(1);
}

class DataPullRequest extends $pb.GeneratedMessage {
  factory DataPullRequest({
    $core.Iterable<$core.String>? identities,
    $core.Iterable<$core.String>? kinds,
  }) {
    final result = create();
    if (identities != null) result.identities.addAll(identities);
    if (kinds != null) result.kinds.addAll(kinds);
    return result;
  }

  DataPullRequest._();

  factory DataPullRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataPullRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataPullRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'identities')
    ..pPS(2, _omitFieldNames ? '' : 'kinds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPullRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPullRequest copyWith(void Function(DataPullRequest) updates) =>
      super.copyWith((message) => updates(message as DataPullRequest))
          as DataPullRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataPullRequest create() => DataPullRequest._();
  @$core.override
  DataPullRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataPullRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataPullRequest>(create);
  static DataPullRequest? _defaultInstance;

  /// list of identities wanted to request
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get identities => $_getList(0);

  /// kinds of data wanted to request
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get kinds => $_getList(1);
}

class DataPullResponse extends $pb.GeneratedMessage {
  factory DataPullResponse({
    $core.Iterable<DataWithIdentity>? data,
  }) {
    final result = create();
    if (data != null) result.data.addAll(data);
    return result;
  }

  DataPullResponse._();

  factory DataPullResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataPullResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataPullResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..pPM<DataWithIdentity>(1, _omitFieldNames ? '' : 'data',
        subBuilder: DataWithIdentity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPullResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataPullResponse copyWith(void Function(DataPullResponse) updates) =>
      super.copyWith((message) => updates(message as DataPullResponse))
          as DataPullResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataPullResponse create() => DataPullResponse._();
  @$core.override
  DataPullResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataPullResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataPullResponse>(create);
  static DataPullResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DataWithIdentity> get data => $_getList(0);
}

class Ok extends $pb.GeneratedMessage {
  factory Ok() => create();

  Ok._();

  factory Ok.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Ok.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Ok',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'identityRepo'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ok clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ok copyWith(void Function(Ok) updates) =>
      super.copyWith((message) => updates(message as Ok)) as Ok;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Ok create() => Ok._();
  @$core.override
  Ok createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Ok getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Ok>(create);
  static Ok? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
