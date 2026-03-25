// This is a generated file - do not edit.
//
// Generated from paymentservice.proto.

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

import 'paymentservice.pb.dart' as $0;
import 'paymentservice_tiers.pb.dart' as $1;

export 'paymentservice.pb.dart';

/// NOTICE:
/// 1 - User can not ask for a payment/other links on behalf of another user (a signature is required)
/// 2 - Admin can do that on behalf of any user
@$pb.GrpcServiceName('AnyPaymentProcessing')
class AnyPaymentProcessingClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AnyPaymentProcessingClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetSubscriptionResponse> getSubscriptionStatus(
    $0.GetSubscriptionRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSubscriptionStatus, request, options: options);
  }

  /// Check if the requested name is valid for the requested tier
  /// before requesting a payment link and paying
  $grpc.ResponseFuture<$0.IsNameValidResponse> isNameValid(
    $0.IsNameValidRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$isNameValid, request, options: options);
  }

  /// Save a new BillingID to DB, and return a payment link.
  /// You can call BuySubscription multiple times even if current payment is not processed yet
  /// (to get new payment link).
  /// If user has already an active subscription, then this will return an error.
  $grpc.ResponseFuture<$0.BuySubscriptionResponse> buySubscription(
    $0.BuySubscriptionRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$buySubscription, request, options: options);
  }

  /// If your subscription is in StatusPendingRequiresFinalization, then you need to call this method
  $grpc.ResponseFuture<$0.FinalizeSubscriptionResponse> finalizeSubscription(
    $0.FinalizeSubscriptionRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$finalizeSubscription, request, options: options);
  }

  /// Generate a link to the portal where user can:
  /// a) change her billing details
  /// b) see payment info, invoices, etc
  /// c) cancel/renew the subscription
  $grpc.ResponseFuture<$0.GetSubscriptionPortalLinkResponse>
      getSubscriptionPortalLink(
    $0.GetSubscriptionPortalLinkRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSubscriptionPortalLink, request,
        options: options);
  }

  /// Verify user's email: 1st step - get a verification link to the email
  /// Will fail if already verified, i.e. you can not change your email
  $grpc.ResponseFuture<$0.GetVerificationEmailResponse> getVerificationEmail(
    $0.GetVerificationEmailRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVerificationEmail, request, options: options);
  }

  /// Enter the code from the email
  /// Will fail if: link was not requested, link is expired, if email is already verified
  $grpc.ResponseFuture<$0.VerifyEmailResponse> verifyEmail(
    $0.VerifyEmailRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyEmail, request, options: options);
  }

  /// Returns all available application tiers, including inactive
  /// 1 - this list does not depend on the current platform (iOS, Android, Desktop)
  /// 2 - this list can be different for different users, based on their account ID
  /// 3 - user can not buy stripe
  /// 4 - some tiers are custom ()
  $grpc.ResponseFuture<$1.GetTiersResponse> getAllTiers(
    $1.GetTiersRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAllTiers, request, options: options);
  }

  /// Verify purchase in case subscription was bought via AppStore
  /// Incoming receipt contains all information to register purchase on Payment Node
  $grpc.ResponseFuture<$0.VerifyAppStoreReceiptResponse> verifyAppStoreReceipt(
    $0.VerifyAppStoreReceiptRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyAppStoreReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.CodeGetInfoResponse> codeGetInfo(
    $0.CodeGetInfoRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$codeGetInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.CodeRedeemResponse> codeRedeem(
    $0.CodeRedeemRequestSigned request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$codeRedeem, request, options: options);
  }

  // method descriptors

  static final _$getSubscriptionStatus = $grpc.ClientMethod<
          $0.GetSubscriptionRequestSigned, $0.GetSubscriptionResponse>(
      '/AnyPaymentProcessing/GetSubscriptionStatus',
      ($0.GetSubscriptionRequestSigned value) => value.writeToBuffer(),
      $0.GetSubscriptionResponse.fromBuffer);
  static final _$isNameValid =
      $grpc.ClientMethod<$0.IsNameValidRequest, $0.IsNameValidResponse>(
          '/AnyPaymentProcessing/IsNameValid',
          ($0.IsNameValidRequest value) => value.writeToBuffer(),
          $0.IsNameValidResponse.fromBuffer);
  static final _$buySubscription = $grpc.ClientMethod<
          $0.BuySubscriptionRequestSigned, $0.BuySubscriptionResponse>(
      '/AnyPaymentProcessing/BuySubscription',
      ($0.BuySubscriptionRequestSigned value) => value.writeToBuffer(),
      $0.BuySubscriptionResponse.fromBuffer);
  static final _$finalizeSubscription = $grpc.ClientMethod<
          $0.FinalizeSubscriptionRequestSigned,
          $0.FinalizeSubscriptionResponse>(
      '/AnyPaymentProcessing/FinalizeSubscription',
      ($0.FinalizeSubscriptionRequestSigned value) => value.writeToBuffer(),
      $0.FinalizeSubscriptionResponse.fromBuffer);
  static final _$getSubscriptionPortalLink = $grpc.ClientMethod<
          $0.GetSubscriptionPortalLinkRequestSigned,
          $0.GetSubscriptionPortalLinkResponse>(
      '/AnyPaymentProcessing/GetSubscriptionPortalLink',
      ($0.GetSubscriptionPortalLinkRequestSigned value) =>
          value.writeToBuffer(),
      $0.GetSubscriptionPortalLinkResponse.fromBuffer);
  static final _$getVerificationEmail = $grpc.ClientMethod<
          $0.GetVerificationEmailRequestSigned,
          $0.GetVerificationEmailResponse>(
      '/AnyPaymentProcessing/GetVerificationEmail',
      ($0.GetVerificationEmailRequestSigned value) => value.writeToBuffer(),
      $0.GetVerificationEmailResponse.fromBuffer);
  static final _$verifyEmail =
      $grpc.ClientMethod<$0.VerifyEmailRequestSigned, $0.VerifyEmailResponse>(
          '/AnyPaymentProcessing/VerifyEmail',
          ($0.VerifyEmailRequestSigned value) => value.writeToBuffer(),
          $0.VerifyEmailResponse.fromBuffer);
  static final _$getAllTiers =
      $grpc.ClientMethod<$1.GetTiersRequestSigned, $1.GetTiersResponse>(
          '/AnyPaymentProcessing/GetAllTiers',
          ($1.GetTiersRequestSigned value) => value.writeToBuffer(),
          $1.GetTiersResponse.fromBuffer);
  static final _$verifyAppStoreReceipt = $grpc.ClientMethod<
          $0.VerifyAppStoreReceiptRequestSigned,
          $0.VerifyAppStoreReceiptResponse>(
      '/AnyPaymentProcessing/VerifyAppStoreReceipt',
      ($0.VerifyAppStoreReceiptRequestSigned value) => value.writeToBuffer(),
      $0.VerifyAppStoreReceiptResponse.fromBuffer);
  static final _$codeGetInfo =
      $grpc.ClientMethod<$0.CodeGetInfoRequestSigned, $0.CodeGetInfoResponse>(
          '/AnyPaymentProcessing/CodeGetInfo',
          ($0.CodeGetInfoRequestSigned value) => value.writeToBuffer(),
          $0.CodeGetInfoResponse.fromBuffer);
  static final _$codeRedeem =
      $grpc.ClientMethod<$0.CodeRedeemRequestSigned, $0.CodeRedeemResponse>(
          '/AnyPaymentProcessing/CodeRedeem',
          ($0.CodeRedeemRequestSigned value) => value.writeToBuffer(),
          $0.CodeRedeemResponse.fromBuffer);
}

@$pb.GrpcServiceName('AnyPaymentProcessing')
abstract class AnyPaymentProcessingServiceBase extends $grpc.Service {
  $core.String get $name => 'AnyPaymentProcessing';

  AnyPaymentProcessingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetSubscriptionRequestSigned,
            $0.GetSubscriptionResponse>(
        'GetSubscriptionStatus',
        getSubscriptionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSubscriptionRequestSigned.fromBuffer(value),
        ($0.GetSubscriptionResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.IsNameValidRequest, $0.IsNameValidResponse>(
            'IsNameValid',
            isNameValid_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.IsNameValidRequest.fromBuffer(value),
            ($0.IsNameValidResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.BuySubscriptionRequestSigned,
            $0.BuySubscriptionResponse>(
        'BuySubscription',
        buySubscription_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BuySubscriptionRequestSigned.fromBuffer(value),
        ($0.BuySubscriptionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FinalizeSubscriptionRequestSigned,
            $0.FinalizeSubscriptionResponse>(
        'FinalizeSubscription',
        finalizeSubscription_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.FinalizeSubscriptionRequestSigned.fromBuffer(value),
        ($0.FinalizeSubscriptionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSubscriptionPortalLinkRequestSigned,
            $0.GetSubscriptionPortalLinkResponse>(
        'GetSubscriptionPortalLink',
        getSubscriptionPortalLink_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSubscriptionPortalLinkRequestSigned.fromBuffer(value),
        ($0.GetSubscriptionPortalLinkResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVerificationEmailRequestSigned,
            $0.GetVerificationEmailResponse>(
        'GetVerificationEmail',
        getVerificationEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVerificationEmailRequestSigned.fromBuffer(value),
        ($0.GetVerificationEmailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyEmailRequestSigned,
            $0.VerifyEmailResponse>(
        'VerifyEmail',
        verifyEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyEmailRequestSigned.fromBuffer(value),
        ($0.VerifyEmailResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetTiersRequestSigned, $1.GetTiersResponse>(
            'GetAllTiers',
            getAllTiers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetTiersRequestSigned.fromBuffer(value),
            ($1.GetTiersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyAppStoreReceiptRequestSigned,
            $0.VerifyAppStoreReceiptResponse>(
        'VerifyAppStoreReceipt',
        verifyAppStoreReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyAppStoreReceiptRequestSigned.fromBuffer(value),
        ($0.VerifyAppStoreReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CodeGetInfoRequestSigned,
            $0.CodeGetInfoResponse>(
        'CodeGetInfo',
        codeGetInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CodeGetInfoRequestSigned.fromBuffer(value),
        ($0.CodeGetInfoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CodeRedeemRequestSigned, $0.CodeRedeemResponse>(
            'CodeRedeem',
            codeRedeem_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CodeRedeemRequestSigned.fromBuffer(value),
            ($0.CodeRedeemResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetSubscriptionResponse> getSubscriptionStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSubscriptionRequestSigned> $request) async {
    return getSubscriptionStatus($call, await $request);
  }

  $async.Future<$0.GetSubscriptionResponse> getSubscriptionStatus(
      $grpc.ServiceCall call, $0.GetSubscriptionRequestSigned request);

  $async.Future<$0.IsNameValidResponse> isNameValid_Pre($grpc.ServiceCall $call,
      $async.Future<$0.IsNameValidRequest> $request) async {
    return isNameValid($call, await $request);
  }

  $async.Future<$0.IsNameValidResponse> isNameValid(
      $grpc.ServiceCall call, $0.IsNameValidRequest request);

  $async.Future<$0.BuySubscriptionResponse> buySubscription_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.BuySubscriptionRequestSigned> $request) async {
    return buySubscription($call, await $request);
  }

  $async.Future<$0.BuySubscriptionResponse> buySubscription(
      $grpc.ServiceCall call, $0.BuySubscriptionRequestSigned request);

  $async.Future<$0.FinalizeSubscriptionResponse> finalizeSubscription_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.FinalizeSubscriptionRequestSigned> $request) async {
    return finalizeSubscription($call, await $request);
  }

  $async.Future<$0.FinalizeSubscriptionResponse> finalizeSubscription(
      $grpc.ServiceCall call, $0.FinalizeSubscriptionRequestSigned request);

  $async.Future<$0.GetSubscriptionPortalLinkResponse>
      getSubscriptionPortalLink_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.GetSubscriptionPortalLinkRequestSigned>
              $request) async {
    return getSubscriptionPortalLink($call, await $request);
  }

  $async.Future<$0.GetSubscriptionPortalLinkResponse> getSubscriptionPortalLink(
      $grpc.ServiceCall call,
      $0.GetSubscriptionPortalLinkRequestSigned request);

  $async.Future<$0.GetVerificationEmailResponse> getVerificationEmail_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVerificationEmailRequestSigned> $request) async {
    return getVerificationEmail($call, await $request);
  }

  $async.Future<$0.GetVerificationEmailResponse> getVerificationEmail(
      $grpc.ServiceCall call, $0.GetVerificationEmailRequestSigned request);

  $async.Future<$0.VerifyEmailResponse> verifyEmail_Pre($grpc.ServiceCall $call,
      $async.Future<$0.VerifyEmailRequestSigned> $request) async {
    return verifyEmail($call, await $request);
  }

  $async.Future<$0.VerifyEmailResponse> verifyEmail(
      $grpc.ServiceCall call, $0.VerifyEmailRequestSigned request);

  $async.Future<$1.GetTiersResponse> getAllTiers_Pre($grpc.ServiceCall $call,
      $async.Future<$1.GetTiersRequestSigned> $request) async {
    return getAllTiers($call, await $request);
  }

  $async.Future<$1.GetTiersResponse> getAllTiers(
      $grpc.ServiceCall call, $1.GetTiersRequestSigned request);

  $async.Future<$0.VerifyAppStoreReceiptResponse> verifyAppStoreReceipt_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyAppStoreReceiptRequestSigned> $request) async {
    return verifyAppStoreReceipt($call, await $request);
  }

  $async.Future<$0.VerifyAppStoreReceiptResponse> verifyAppStoreReceipt(
      $grpc.ServiceCall call, $0.VerifyAppStoreReceiptRequestSigned request);

  $async.Future<$0.CodeGetInfoResponse> codeGetInfo_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CodeGetInfoRequestSigned> $request) async {
    return codeGetInfo($call, await $request);
  }

  $async.Future<$0.CodeGetInfoResponse> codeGetInfo(
      $grpc.ServiceCall call, $0.CodeGetInfoRequestSigned request);

  $async.Future<$0.CodeRedeemResponse> codeRedeem_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CodeRedeemRequestSigned> $request) async {
    return codeRedeem($call, await $request);
  }

  $async.Future<$0.CodeRedeemResponse> codeRedeem(
      $grpc.ServiceCall call, $0.CodeRedeemRequestSigned request);
}
