// This is a generated file - do not edit.
//
// Generated from paymentservice2.proto.

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

import 'paymentservice2.pb.dart' as $0;

export 'paymentservice2.pb.dart';

@$pb.GrpcServiceName('AnyPaymentProcessingV2')
class AnyPaymentProcessingV2Client extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AnyPaymentProcessingV2Client(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.MembershipV2_SubscribeToUpdatesResponse>
      subscribeToUpdates(
    $0.MembershipV2_SubscribeToUpdatesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$subscribeToUpdates, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_GetProductsResponse> getProducts(
    $0.MembershipV2_GetProductsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProducts, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_GetStatusResponse> getStatus(
    $0.MembershipV2_GetStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_WebAuthResponse> webAuth(
    $0.MembershipV2_WebAuthRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$webAuth, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_AnyNameIsValidResponse> anyNameIsValid(
    $0.MembershipV2_AnyNameIsValidRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$anyNameIsValid, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_AnyNameAllocateResponse> anyNameAllocate(
    $0.MembershipV2_AnyNameAllocateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$anyNameAllocate, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_StoreCartGetResponse> storeCartGet(
    $0.MembershipV2_StoreCartGetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$storeCartGet, request, options: options);
  }

  $grpc.ResponseFuture<$0.MembershipV2_StoreCartUpdateResponse> storeCartUpdate(
    $0.MembershipV2_StoreCartUpdateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$storeCartUpdate, request, options: options);
  }

  // method descriptors

  static final _$subscribeToUpdates = $grpc.ClientMethod<
          $0.MembershipV2_SubscribeToUpdatesRequest,
          $0.MembershipV2_SubscribeToUpdatesResponse>(
      '/AnyPaymentProcessingV2/SubscribeToUpdates',
      ($0.MembershipV2_SubscribeToUpdatesRequest value) =>
          value.writeToBuffer(),
      $0.MembershipV2_SubscribeToUpdatesResponse.fromBuffer);
  static final _$getProducts = $grpc.ClientMethod<
          $0.MembershipV2_GetProductsRequest,
          $0.MembershipV2_GetProductsResponse>(
      '/AnyPaymentProcessingV2/GetProducts',
      ($0.MembershipV2_GetProductsRequest value) => value.writeToBuffer(),
      $0.MembershipV2_GetProductsResponse.fromBuffer);
  static final _$getStatus = $grpc.ClientMethod<
          $0.MembershipV2_GetStatusRequest, $0.MembershipV2_GetStatusResponse>(
      '/AnyPaymentProcessingV2/GetStatus',
      ($0.MembershipV2_GetStatusRequest value) => value.writeToBuffer(),
      $0.MembershipV2_GetStatusResponse.fromBuffer);
  static final _$webAuth = $grpc.ClientMethod<$0.MembershipV2_WebAuthRequest,
          $0.MembershipV2_WebAuthResponse>(
      '/AnyPaymentProcessingV2/WebAuth',
      ($0.MembershipV2_WebAuthRequest value) => value.writeToBuffer(),
      $0.MembershipV2_WebAuthResponse.fromBuffer);
  static final _$anyNameIsValid = $grpc.ClientMethod<
          $0.MembershipV2_AnyNameIsValidRequest,
          $0.MembershipV2_AnyNameIsValidResponse>(
      '/AnyPaymentProcessingV2/AnyNameIsValid',
      ($0.MembershipV2_AnyNameIsValidRequest value) => value.writeToBuffer(),
      $0.MembershipV2_AnyNameIsValidResponse.fromBuffer);
  static final _$anyNameAllocate = $grpc.ClientMethod<
          $0.MembershipV2_AnyNameAllocateRequest,
          $0.MembershipV2_AnyNameAllocateResponse>(
      '/AnyPaymentProcessingV2/AnyNameAllocate',
      ($0.MembershipV2_AnyNameAllocateRequest value) => value.writeToBuffer(),
      $0.MembershipV2_AnyNameAllocateResponse.fromBuffer);
  static final _$storeCartGet = $grpc.ClientMethod<
          $0.MembershipV2_StoreCartGetRequest,
          $0.MembershipV2_StoreCartGetResponse>(
      '/AnyPaymentProcessingV2/StoreCartGet',
      ($0.MembershipV2_StoreCartGetRequest value) => value.writeToBuffer(),
      $0.MembershipV2_StoreCartGetResponse.fromBuffer);
  static final _$storeCartUpdate = $grpc.ClientMethod<
          $0.MembershipV2_StoreCartUpdateRequest,
          $0.MembershipV2_StoreCartUpdateResponse>(
      '/AnyPaymentProcessingV2/StoreCartUpdate',
      ($0.MembershipV2_StoreCartUpdateRequest value) => value.writeToBuffer(),
      $0.MembershipV2_StoreCartUpdateResponse.fromBuffer);
}

@$pb.GrpcServiceName('AnyPaymentProcessingV2')
abstract class AnyPaymentProcessingV2ServiceBase extends $grpc.Service {
  $core.String get $name => 'AnyPaymentProcessingV2';

  AnyPaymentProcessingV2ServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_SubscribeToUpdatesRequest,
            $0.MembershipV2_SubscribeToUpdatesResponse>(
        'SubscribeToUpdates',
        subscribeToUpdates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_SubscribeToUpdatesRequest.fromBuffer(value),
        ($0.MembershipV2_SubscribeToUpdatesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_GetProductsRequest,
            $0.MembershipV2_GetProductsResponse>(
        'GetProducts',
        getProducts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_GetProductsRequest.fromBuffer(value),
        ($0.MembershipV2_GetProductsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_GetStatusRequest,
            $0.MembershipV2_GetStatusResponse>(
        'GetStatus',
        getStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_GetStatusRequest.fromBuffer(value),
        ($0.MembershipV2_GetStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_WebAuthRequest,
            $0.MembershipV2_WebAuthResponse>(
        'WebAuth',
        webAuth_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_WebAuthRequest.fromBuffer(value),
        ($0.MembershipV2_WebAuthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_AnyNameIsValidRequest,
            $0.MembershipV2_AnyNameIsValidResponse>(
        'AnyNameIsValid',
        anyNameIsValid_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_AnyNameIsValidRequest.fromBuffer(value),
        ($0.MembershipV2_AnyNameIsValidResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_AnyNameAllocateRequest,
            $0.MembershipV2_AnyNameAllocateResponse>(
        'AnyNameAllocate',
        anyNameAllocate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_AnyNameAllocateRequest.fromBuffer(value),
        ($0.MembershipV2_AnyNameAllocateResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_StoreCartGetRequest,
            $0.MembershipV2_StoreCartGetResponse>(
        'StoreCartGet',
        storeCartGet_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_StoreCartGetRequest.fromBuffer(value),
        ($0.MembershipV2_StoreCartGetResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MembershipV2_StoreCartUpdateRequest,
            $0.MembershipV2_StoreCartUpdateResponse>(
        'StoreCartUpdate',
        storeCartUpdate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MembershipV2_StoreCartUpdateRequest.fromBuffer(value),
        ($0.MembershipV2_StoreCartUpdateResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.MembershipV2_SubscribeToUpdatesResponse>
      subscribeToUpdates_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.MembershipV2_SubscribeToUpdatesRequest>
              $request) async {
    return subscribeToUpdates($call, await $request);
  }

  $async.Future<$0.MembershipV2_SubscribeToUpdatesResponse> subscribeToUpdates(
      $grpc.ServiceCall call,
      $0.MembershipV2_SubscribeToUpdatesRequest request);

  $async.Future<$0.MembershipV2_GetProductsResponse> getProducts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_GetProductsRequest> $request) async {
    return getProducts($call, await $request);
  }

  $async.Future<$0.MembershipV2_GetProductsResponse> getProducts(
      $grpc.ServiceCall call, $0.MembershipV2_GetProductsRequest request);

  $async.Future<$0.MembershipV2_GetStatusResponse> getStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_GetStatusRequest> $request) async {
    return getStatus($call, await $request);
  }

  $async.Future<$0.MembershipV2_GetStatusResponse> getStatus(
      $grpc.ServiceCall call, $0.MembershipV2_GetStatusRequest request);

  $async.Future<$0.MembershipV2_WebAuthResponse> webAuth_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_WebAuthRequest> $request) async {
    return webAuth($call, await $request);
  }

  $async.Future<$0.MembershipV2_WebAuthResponse> webAuth(
      $grpc.ServiceCall call, $0.MembershipV2_WebAuthRequest request);

  $async.Future<$0.MembershipV2_AnyNameIsValidResponse> anyNameIsValid_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_AnyNameIsValidRequest> $request) async {
    return anyNameIsValid($call, await $request);
  }

  $async.Future<$0.MembershipV2_AnyNameIsValidResponse> anyNameIsValid(
      $grpc.ServiceCall call, $0.MembershipV2_AnyNameIsValidRequest request);

  $async.Future<$0.MembershipV2_AnyNameAllocateResponse> anyNameAllocate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_AnyNameAllocateRequest> $request) async {
    return anyNameAllocate($call, await $request);
  }

  $async.Future<$0.MembershipV2_AnyNameAllocateResponse> anyNameAllocate(
      $grpc.ServiceCall call, $0.MembershipV2_AnyNameAllocateRequest request);

  $async.Future<$0.MembershipV2_StoreCartGetResponse> storeCartGet_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_StoreCartGetRequest> $request) async {
    return storeCartGet($call, await $request);
  }

  $async.Future<$0.MembershipV2_StoreCartGetResponse> storeCartGet(
      $grpc.ServiceCall call, $0.MembershipV2_StoreCartGetRequest request);

  $async.Future<$0.MembershipV2_StoreCartUpdateResponse> storeCartUpdate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.MembershipV2_StoreCartUpdateRequest> $request) async {
    return storeCartUpdate($call, await $request);
  }

  $async.Future<$0.MembershipV2_StoreCartUpdateResponse> storeCartUpdate(
      $grpc.ServiceCall call, $0.MembershipV2_StoreCartUpdateRequest request);
}
