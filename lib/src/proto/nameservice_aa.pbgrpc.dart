// This is a generated file - do not edit.
//
// Generated from nameservice_aa.proto.

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

import 'nameservice_aa.pb.dart' as $0;

export 'nameservice_aa.pb.dart';

@$pb.GrpcServiceName('AnynsAccountAbstraction')
class AnynsAccountAbstractionClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AnynsAccountAbstractionClient(super.channel,
      {super.options, super.interceptors});

  /// COMMON METHODS:
  $grpc.ResponseFuture<$0.OperationResponse> getOperation(
    $0.GetOperationStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getOperation, request, options: options);
  }

  /// ADMIN METHODS:
  /// Will send "access tokens" to the user's account (to his SmartContractWallet).
  /// User will be able to use these "access tokens" to register his name later directly.
  ///
  /// Blocking, will send TX to EVM chain
  /// If finished without error -> please use GetUserAccount to get updated info
  $grpc.ResponseFuture<$0.OperationResponse> adminFundUserAccount(
    $0.AdminFundUserAccountRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminFundUserAccount, request, options: options);
  }

  /// Each operation is a single blockchain TX like "name update".
  /// User will be able to send operations without having any gas in his wallet later
  $grpc.ResponseFuture<$0.OperationResponse> adminFundGasOperations(
    $0.AdminFundGasOperationsRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminFundGasOperations, request,
        options: options);
  }

  /// USER METHODS:
  /// Use it to:
  /// 1 - get your SmartContractWallet address
  /// 2 - get how many operations you still have
  $grpc.ResponseFuture<$0.UserAccount> getUserAccount(
    $0.GetUserAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserAccount, request, options: options);
  }

  /// Example usage:
  /// 1. get data + context
  /// 2. sign it with your Ethereum private key
  /// 3. send it using CreateUserOperation
  /// 4. check operation status using GetOperation
  ///
  /// Register new name for my Any identity
  $grpc.ResponseFuture<$0.GetDataNameRegisterResponse> getDataNameRegister(
    $0.NameRegisterRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDataNameRegister, request, options: options);
  }

  /// Register new name and attach Space ID to it
  $grpc.ResponseFuture<$0.GetDataNameRegisterResponse>
      getDataNameRegisterForSpace(
    $0.NameRegisterForSpaceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDataNameRegisterForSpace, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.OperationResponse> createUserOperation(
    $0.CreateUserOperationRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createUserOperation, request, options: options);
  }

  // method descriptors

  static final _$getOperation =
      $grpc.ClientMethod<$0.GetOperationStatusRequest, $0.OperationResponse>(
          '/AnynsAccountAbstraction/GetOperation',
          ($0.GetOperationStatusRequest value) => value.writeToBuffer(),
          $0.OperationResponse.fromBuffer);
  static final _$adminFundUserAccount = $grpc.ClientMethod<
          $0.AdminFundUserAccountRequestSigned, $0.OperationResponse>(
      '/AnynsAccountAbstraction/AdminFundUserAccount',
      ($0.AdminFundUserAccountRequestSigned value) => value.writeToBuffer(),
      $0.OperationResponse.fromBuffer);
  static final _$adminFundGasOperations = $grpc.ClientMethod<
          $0.AdminFundGasOperationsRequestSigned, $0.OperationResponse>(
      '/AnynsAccountAbstraction/AdminFundGasOperations',
      ($0.AdminFundGasOperationsRequestSigned value) => value.writeToBuffer(),
      $0.OperationResponse.fromBuffer);
  static final _$getUserAccount =
      $grpc.ClientMethod<$0.GetUserAccountRequest, $0.UserAccount>(
          '/AnynsAccountAbstraction/GetUserAccount',
          ($0.GetUserAccountRequest value) => value.writeToBuffer(),
          $0.UserAccount.fromBuffer);
  static final _$getDataNameRegister = $grpc.ClientMethod<
          $0.NameRegisterRequest, $0.GetDataNameRegisterResponse>(
      '/AnynsAccountAbstraction/GetDataNameRegister',
      ($0.NameRegisterRequest value) => value.writeToBuffer(),
      $0.GetDataNameRegisterResponse.fromBuffer);
  static final _$getDataNameRegisterForSpace = $grpc.ClientMethod<
          $0.NameRegisterForSpaceRequest, $0.GetDataNameRegisterResponse>(
      '/AnynsAccountAbstraction/GetDataNameRegisterForSpace',
      ($0.NameRegisterForSpaceRequest value) => value.writeToBuffer(),
      $0.GetDataNameRegisterResponse.fromBuffer);
  static final _$createUserOperation = $grpc.ClientMethod<
          $0.CreateUserOperationRequestSigned, $0.OperationResponse>(
      '/AnynsAccountAbstraction/CreateUserOperation',
      ($0.CreateUserOperationRequestSigned value) => value.writeToBuffer(),
      $0.OperationResponse.fromBuffer);
}

@$pb.GrpcServiceName('AnynsAccountAbstraction')
abstract class AnynsAccountAbstractionServiceBase extends $grpc.Service {
  $core.String get $name => 'AnynsAccountAbstraction';

  AnynsAccountAbstractionServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetOperationStatusRequest, $0.OperationResponse>(
            'GetOperation',
            getOperation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOperationStatusRequest.fromBuffer(value),
            ($0.OperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminFundUserAccountRequestSigned,
            $0.OperationResponse>(
        'AdminFundUserAccount',
        adminFundUserAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminFundUserAccountRequestSigned.fromBuffer(value),
        ($0.OperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminFundGasOperationsRequestSigned,
            $0.OperationResponse>(
        'AdminFundGasOperations',
        adminFundGasOperations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminFundGasOperationsRequestSigned.fromBuffer(value),
        ($0.OperationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserAccountRequest, $0.UserAccount>(
        'GetUserAccount',
        getUserAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserAccountRequest.fromBuffer(value),
        ($0.UserAccount value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.NameRegisterRequest,
            $0.GetDataNameRegisterResponse>(
        'GetDataNameRegister',
        getDataNameRegister_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.NameRegisterRequest.fromBuffer(value),
        ($0.GetDataNameRegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.NameRegisterForSpaceRequest,
            $0.GetDataNameRegisterResponse>(
        'GetDataNameRegisterForSpace',
        getDataNameRegisterForSpace_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.NameRegisterForSpaceRequest.fromBuffer(value),
        ($0.GetDataNameRegisterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUserOperationRequestSigned,
            $0.OperationResponse>(
        'CreateUserOperation',
        createUserOperation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateUserOperationRequestSigned.fromBuffer(value),
        ($0.OperationResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.OperationResponse> getOperation_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetOperationStatusRequest> $request) async {
    return getOperation($call, await $request);
  }

  $async.Future<$0.OperationResponse> getOperation(
      $grpc.ServiceCall call, $0.GetOperationStatusRequest request);

  $async.Future<$0.OperationResponse> adminFundUserAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminFundUserAccountRequestSigned> $request) async {
    return adminFundUserAccount($call, await $request);
  }

  $async.Future<$0.OperationResponse> adminFundUserAccount(
      $grpc.ServiceCall call, $0.AdminFundUserAccountRequestSigned request);

  $async.Future<$0.OperationResponse> adminFundGasOperations_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminFundGasOperationsRequestSigned> $request) async {
    return adminFundGasOperations($call, await $request);
  }

  $async.Future<$0.OperationResponse> adminFundGasOperations(
      $grpc.ServiceCall call, $0.AdminFundGasOperationsRequestSigned request);

  $async.Future<$0.UserAccount> getUserAccount_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserAccountRequest> $request) async {
    return getUserAccount($call, await $request);
  }

  $async.Future<$0.UserAccount> getUserAccount(
      $grpc.ServiceCall call, $0.GetUserAccountRequest request);

  $async.Future<$0.GetDataNameRegisterResponse> getDataNameRegister_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NameRegisterRequest> $request) async {
    return getDataNameRegister($call, await $request);
  }

  $async.Future<$0.GetDataNameRegisterResponse> getDataNameRegister(
      $grpc.ServiceCall call, $0.NameRegisterRequest request);

  $async.Future<$0.GetDataNameRegisterResponse> getDataNameRegisterForSpace_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.NameRegisterForSpaceRequest> $request) async {
    return getDataNameRegisterForSpace($call, await $request);
  }

  $async.Future<$0.GetDataNameRegisterResponse> getDataNameRegisterForSpace(
      $grpc.ServiceCall call, $0.NameRegisterForSpaceRequest request);

  $async.Future<$0.OperationResponse> createUserOperation_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateUserOperationRequestSigned> $request) async {
    return createUserOperation($call, await $request);
  }

  $async.Future<$0.OperationResponse> createUserOperation(
      $grpc.ServiceCall call, $0.CreateUserOperationRequestSigned request);
}
