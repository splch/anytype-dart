// This is a generated file - do not edit.
//
// Generated from clientspace.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class SpaceExchangeRequest extends $pb.GeneratedMessage {
  factory SpaceExchangeRequest({
    $core.Iterable<$core.String>? spaceIds,
    LocalServer? localServer,
  }) {
    final result = create();
    if (spaceIds != null) result.spaceIds.addAll(spaceIds);
    if (localServer != null) result.localServer = localServer;
    return result;
  }

  SpaceExchangeRequest._();

  factory SpaceExchangeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SpaceExchangeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SpaceExchangeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'clientspace'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'spaceIds', protoName: 'spaceIds')
    ..aOM<LocalServer>(2, _omitFieldNames ? '' : 'localServer',
        protoName: 'localServer', subBuilder: LocalServer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpaceExchangeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpaceExchangeRequest copyWith(void Function(SpaceExchangeRequest) updates) =>
      super.copyWith((message) => updates(message as SpaceExchangeRequest))
          as SpaceExchangeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpaceExchangeRequest create() => SpaceExchangeRequest._();
  @$core.override
  SpaceExchangeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SpaceExchangeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SpaceExchangeRequest>(create);
  static SpaceExchangeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get spaceIds => $_getList(0);

  @$pb.TagNumber(2)
  LocalServer get localServer => $_getN(1);
  @$pb.TagNumber(2)
  set localServer(LocalServer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLocalServer() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalServer() => $_clearField(2);
  @$pb.TagNumber(2)
  LocalServer ensureLocalServer() => $_ensure(1);
}

class SpaceExchangeResponse extends $pb.GeneratedMessage {
  factory SpaceExchangeResponse({
    $core.Iterable<$core.String>? spaceIds,
  }) {
    final result = create();
    if (spaceIds != null) result.spaceIds.addAll(spaceIds);
    return result;
  }

  SpaceExchangeResponse._();

  factory SpaceExchangeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SpaceExchangeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SpaceExchangeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'clientspace'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'spaceIds', protoName: 'spaceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpaceExchangeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SpaceExchangeResponse copyWith(
          void Function(SpaceExchangeResponse) updates) =>
      super.copyWith((message) => updates(message as SpaceExchangeResponse))
          as SpaceExchangeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpaceExchangeResponse create() => SpaceExchangeResponse._();
  @$core.override
  SpaceExchangeResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SpaceExchangeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SpaceExchangeResponse>(create);
  static SpaceExchangeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get spaceIds => $_getList(0);
}

class LocalServer extends $pb.GeneratedMessage {
  factory LocalServer({
    $core.Iterable<$core.String>? ips,
    $core.int? port,
  }) {
    final result = create();
    if (ips != null) result.ips.addAll(ips);
    if (port != null) result.port = port;
    return result;
  }

  LocalServer._();

  factory LocalServer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LocalServer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocalServer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'clientspace'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'Ips', protoName: 'Ips')
    ..aI(2, _omitFieldNames ? '' : 'port')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocalServer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocalServer copyWith(void Function(LocalServer) updates) =>
      super.copyWith((message) => updates(message as LocalServer))
          as LocalServer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LocalServer create() => LocalServer._();
  @$core.override
  LocalServer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LocalServer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LocalServer>(create);
  static LocalServer? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get ips => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get port => $_getIZ(1);
  @$pb.TagNumber(2)
  set port($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPort() => $_has(1);
  @$pb.TagNumber(2)
  void clearPort() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
