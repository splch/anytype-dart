// This is a generated file - do not edit.
//
// Generated from nameservice.proto.

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

import 'nameservice.pb.dart' as $0;
import 'nameservice_aa.pb.dart' as $1;

export 'nameservice.pb.dart';

@$pb.GrpcServiceName('Anyns')
class AnynsClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AnynsClient(super.channel, {super.options, super.interceptors});

  /// Lookup: name -> address
  $grpc.ResponseFuture<$0.NameAvailableResponse> isNameAvailable(
    $0.NameAvailableRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$isNameAvailable, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchNameAvailableResponse> batchIsNameAvailable(
    $0.BatchNameAvailableRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$batchIsNameAvailable, request, options: options);
  }

  /// Reverse lookup: address -> name
  $grpc.ResponseFuture<$0.NameByAddressResponse> getNameByAddress(
    $0.NameByAddressRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getNameByAddress, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchNameByAddressResponse> batchGetNameByAddress(
    $0.BatchNameByAddressRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$batchGetNameByAddress, request, options: options);
  }

  /// Reverse lookup: ANY ID -> name
  $grpc.ResponseFuture<$0.NameByAddressResponse> getNameByAnyId(
    $0.NameByAnyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getNameByAnyId, request, options: options);
  }

  $grpc.ResponseFuture<$0.BatchNameByAddressResponse> batchGetNameByAnyId(
    $0.BatchNameByAnyIdRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$batchGetNameByAnyId, request, options: options);
  }

  /// Register new name for the user (on behalf of the user)
  /// Anytype CAN only register names for users, but can not transfer!
  $grpc.ResponseFuture<$1.OperationResponse> adminNameRegisterSigned(
    $1.NameRegisterRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminNameRegisterSigned, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.OperationResponse> adminNameRenewSigned(
    $1.NameRenewRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminNameRenewSigned, request, options: options);
  }

  // method descriptors

  static final _$isNameAvailable =
      $grpc.ClientMethod<$0.NameAvailableRequest, $0.NameAvailableResponse>(
          '/Anyns/IsNameAvailable',
          ($0.NameAvailableRequest value) => value.writeToBuffer(),
          $0.NameAvailableResponse.fromBuffer);
  static final _$batchIsNameAvailable = $grpc.ClientMethod<
          $0.BatchNameAvailableRequest, $0.BatchNameAvailableResponse>(
      '/Anyns/BatchIsNameAvailable',
      ($0.BatchNameAvailableRequest value) => value.writeToBuffer(),
      $0.BatchNameAvailableResponse.fromBuffer);
  static final _$getNameByAddress =
      $grpc.ClientMethod<$0.NameByAddressRequest, $0.NameByAddressResponse>(
          '/Anyns/GetNameByAddress',
          ($0.NameByAddressRequest value) => value.writeToBuffer(),
          $0.NameByAddressResponse.fromBuffer);
  static final _$batchGetNameByAddress = $grpc.ClientMethod<
          $0.BatchNameByAddressRequest, $0.BatchNameByAddressResponse>(
      '/Anyns/BatchGetNameByAddress',
      ($0.BatchNameByAddressRequest value) => value.writeToBuffer(),
      $0.BatchNameByAddressResponse.fromBuffer);
  static final _$getNameByAnyId =
      $grpc.ClientMethod<$0.NameByAnyIdRequest, $0.NameByAddressResponse>(
          '/Anyns/GetNameByAnyId',
          ($0.NameByAnyIdRequest value) => value.writeToBuffer(),
          $0.NameByAddressResponse.fromBuffer);
  static final _$batchGetNameByAnyId = $grpc.ClientMethod<
          $0.BatchNameByAnyIdRequest, $0.BatchNameByAddressResponse>(
      '/Anyns/BatchGetNameByAnyId',
      ($0.BatchNameByAnyIdRequest value) => value.writeToBuffer(),
      $0.BatchNameByAddressResponse.fromBuffer);
  static final _$adminNameRegisterSigned =
      $grpc.ClientMethod<$1.NameRegisterRequestSigned, $1.OperationResponse>(
          '/Anyns/AdminNameRegisterSigned',
          ($1.NameRegisterRequestSigned value) => value.writeToBuffer(),
          $1.OperationResponse.fromBuffer);
  static final _$adminNameRenewSigned =
      $grpc.ClientMethod<$1.NameRenewRequestSigned, $1.OperationResponse>(
          '/Anyns/AdminNameRenewSigned',
          ($1.NameRenewRequestSigned value) => value.writeToBuffer(),
          $1.OperationResponse.fromBuffer);
}

@$pb.GrpcServiceName('Anyns')
abstract class AnynsServiceBase extends $grpc.Service {
  $core.String get $name => 'Anyns';

  AnynsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.NameAvailableRequest, $0.NameAvailableResponse>(
            'IsNameAvailable',
            isNameAvailable_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.NameAvailableRequest.fromBuffer(value),
            ($0.NameAvailableResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchNameAvailableRequest,
            $0.BatchNameAvailableResponse>(
        'BatchIsNameAvailable',
        batchIsNameAvailable_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BatchNameAvailableRequest.fromBuffer(value),
        ($0.BatchNameAvailableResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.NameByAddressRequest, $0.NameByAddressResponse>(
            'GetNameByAddress',
            getNameByAddress_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.NameByAddressRequest.fromBuffer(value),
            ($0.NameByAddressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchNameByAddressRequest,
            $0.BatchNameByAddressResponse>(
        'BatchGetNameByAddress',
        batchGetNameByAddress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BatchNameByAddressRequest.fromBuffer(value),
        ($0.BatchNameByAddressResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.NameByAnyIdRequest, $0.NameByAddressResponse>(
            'GetNameByAnyId',
            getNameByAnyId_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.NameByAnyIdRequest.fromBuffer(value),
            ($0.NameByAddressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BatchNameByAnyIdRequest,
            $0.BatchNameByAddressResponse>(
        'BatchGetNameByAnyId',
        batchGetNameByAnyId_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BatchNameByAnyIdRequest.fromBuffer(value),
        ($0.BatchNameByAddressResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.NameRegisterRequestSigned, $1.OperationResponse>(
            'AdminNameRegisterSigned',
            adminNameRegisterSigned_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.NameRegisterRequestSigned.fromBuffer(value),
            ($1.OperationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.NameRenewRequestSigned, $1.OperationResponse>(
            'AdminNameRenewSigned',
            adminNameRenewSigned_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.NameRenewRequestSigned.fromBuffer(value),
            ($1.OperationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NameAvailableResponse> isNameAvailable_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NameAvailableRequest> $request) async {
    return isNameAvailable($call, await $request);
  }

  $async.Future<$0.NameAvailableResponse> isNameAvailable(
      $grpc.ServiceCall call, $0.NameAvailableRequest request);

  $async.Future<$0.BatchNameAvailableResponse> batchIsNameAvailable_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.BatchNameAvailableRequest> $request) async {
    return batchIsNameAvailable($call, await $request);
  }

  $async.Future<$0.BatchNameAvailableResponse> batchIsNameAvailable(
      $grpc.ServiceCall call, $0.BatchNameAvailableRequest request);

  $async.Future<$0.NameByAddressResponse> getNameByAddress_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NameByAddressRequest> $request) async {
    return getNameByAddress($call, await $request);
  }

  $async.Future<$0.NameByAddressResponse> getNameByAddress(
      $grpc.ServiceCall call, $0.NameByAddressRequest request);

  $async.Future<$0.BatchNameByAddressResponse> batchGetNameByAddress_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.BatchNameByAddressRequest> $request) async {
    return batchGetNameByAddress($call, await $request);
  }

  $async.Future<$0.BatchNameByAddressResponse> batchGetNameByAddress(
      $grpc.ServiceCall call, $0.BatchNameByAddressRequest request);

  $async.Future<$0.NameByAddressResponse> getNameByAnyId_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NameByAnyIdRequest> $request) async {
    return getNameByAnyId($call, await $request);
  }

  $async.Future<$0.NameByAddressResponse> getNameByAnyId(
      $grpc.ServiceCall call, $0.NameByAnyIdRequest request);

  $async.Future<$0.BatchNameByAddressResponse> batchGetNameByAnyId_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.BatchNameByAnyIdRequest> $request) async {
    return batchGetNameByAnyId($call, await $request);
  }

  $async.Future<$0.BatchNameByAddressResponse> batchGetNameByAnyId(
      $grpc.ServiceCall call, $0.BatchNameByAnyIdRequest request);

  $async.Future<$1.OperationResponse> adminNameRegisterSigned_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.NameRegisterRequestSigned> $request) async {
    return adminNameRegisterSigned($call, await $request);
  }

  $async.Future<$1.OperationResponse> adminNameRegisterSigned(
      $grpc.ServiceCall call, $1.NameRegisterRequestSigned request);

  $async.Future<$1.OperationResponse> adminNameRenewSigned_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$1.NameRenewRequestSigned> $request) async {
    return adminNameRenewSigned($call, await $request);
  }

  $async.Future<$1.OperationResponse> adminNameRenewSigned(
      $grpc.ServiceCall call, $1.NameRenewRequestSigned request);
}
