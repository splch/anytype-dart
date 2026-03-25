// This is a generated file - do not edit.
//
// Generated from identityrepo.proto.

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

import 'identityrepo.pb.dart' as $0;

export 'identityrepo.pb.dart';

@$pb.GrpcServiceName('identityRepo.IdentityRepo')
class IdentityRepoClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  IdentityRepoClient(super.channel, {super.options, super.interceptors});

  /// DataPut puts client data to a repository
  $grpc.ResponseFuture<$0.Ok> dataPut(
    $0.DataPutRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$dataPut, request, options: options);
  }

  /// DataDelete deletes client data from a repository
  $grpc.ResponseFuture<$0.Ok> dataDelete(
    $0.DataDeleteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$dataDelete, request, options: options);
  }

  /// DataPull pulls client data from a repository
  $grpc.ResponseFuture<$0.DataPullResponse> dataPull(
    $0.DataPullRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$dataPull, request, options: options);
  }

  // method descriptors

  static final _$dataPut = $grpc.ClientMethod<$0.DataPutRequest, $0.Ok>(
      '/identityRepo.IdentityRepo/DataPut',
      ($0.DataPutRequest value) => value.writeToBuffer(),
      $0.Ok.fromBuffer);
  static final _$dataDelete = $grpc.ClientMethod<$0.DataDeleteRequest, $0.Ok>(
      '/identityRepo.IdentityRepo/DataDelete',
      ($0.DataDeleteRequest value) => value.writeToBuffer(),
      $0.Ok.fromBuffer);
  static final _$dataPull =
      $grpc.ClientMethod<$0.DataPullRequest, $0.DataPullResponse>(
          '/identityRepo.IdentityRepo/DataPull',
          ($0.DataPullRequest value) => value.writeToBuffer(),
          $0.DataPullResponse.fromBuffer);
}

@$pb.GrpcServiceName('identityRepo.IdentityRepo')
abstract class IdentityRepoServiceBase extends $grpc.Service {
  $core.String get $name => 'identityRepo.IdentityRepo';

  IdentityRepoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DataPutRequest, $0.Ok>(
        'DataPut',
        dataPut_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DataPutRequest.fromBuffer(value),
        ($0.Ok value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DataDeleteRequest, $0.Ok>(
        'DataDelete',
        dataDelete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DataDeleteRequest.fromBuffer(value),
        ($0.Ok value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DataPullRequest, $0.DataPullResponse>(
        'DataPull',
        dataPull_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DataPullRequest.fromBuffer(value),
        ($0.DataPullResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Ok> dataPut_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DataPutRequest> $request) async {
    return dataPut($call, await $request);
  }

  $async.Future<$0.Ok> dataPut(
      $grpc.ServiceCall call, $0.DataPutRequest request);

  $async.Future<$0.Ok> dataDelete_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DataDeleteRequest> $request) async {
    return dataDelete($call, await $request);
  }

  $async.Future<$0.Ok> dataDelete(
      $grpc.ServiceCall call, $0.DataDeleteRequest request);

  $async.Future<$0.DataPullResponse> dataPull_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DataPullRequest> $request) async {
    return dataPull($call, await $request);
  }

  $async.Future<$0.DataPullResponse> dataPull(
      $grpc.ServiceCall call, $0.DataPullRequest request);
}
