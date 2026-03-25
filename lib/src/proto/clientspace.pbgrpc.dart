// This is a generated file - do not edit.
//
// Generated from clientspace.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'clientspace.pb.dart' as $0;

export 'clientspace.pb.dart';

@$pb.GrpcServiceName('clientspace.ClientSpace')
class ClientSpaceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  ClientSpaceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SpaceExchangeResponse> spaceExchange(
    $0.SpaceExchangeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$spaceExchange, request, options: options);
  }

  // method descriptors

  static final _$spaceExchange =
      $grpc.ClientMethod<$0.SpaceExchangeRequest, $0.SpaceExchangeResponse>(
          '/clientspace.ClientSpace/SpaceExchange',
          ($0.SpaceExchangeRequest value) => value.writeToBuffer(),
          $0.SpaceExchangeResponse.fromBuffer);
}

@$pb.GrpcServiceName('clientspace.ClientSpace')
abstract class ClientSpaceServiceBase extends $grpc.Service {
  $core.String get $name => 'clientspace.ClientSpace';

  ClientSpaceServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.SpaceExchangeRequest, $0.SpaceExchangeResponse>(
            'SpaceExchange',
            spaceExchange_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SpaceExchangeRequest.fromBuffer(value),
            ($0.SpaceExchangeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SpaceExchangeResponse> spaceExchange_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SpaceExchangeRequest> $request) async {
    return spaceExchange($call, await $request);
  }

  $async.Future<$0.SpaceExchangeResponse> spaceExchange(
      $grpc.ServiceCall call, $0.SpaceExchangeRequest request);
}
