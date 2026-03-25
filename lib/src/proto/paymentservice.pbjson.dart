// This is a generated file - do not edit.
//
// Generated from paymentservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use subscriptionTierDescriptor instead')
const SubscriptionTier$json = {
  '1': 'SubscriptionTier',
  '2': [
    {'1': 'TierUnknown', '2': 0},
    {'1': 'TierExplorer', '2': 1},
    {'1': 'TierBuilder1WeekTEST', '2': 2},
    {'1': 'TierCoCreator1WeekTEST', '2': 3},
    {'1': 'TierBuilder1Year', '2': 4},
    {'1': 'TierCoCreator1Year', '2': 5},
    {'1': 'TierBuilderPlus', '2': 6},
    {'1': 'TierAnytypeTeam', '2': 7},
  ],
};

/// Descriptor for `SubscriptionTier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subscriptionTierDescriptor = $convert.base64Decode(
    'ChBTdWJzY3JpcHRpb25UaWVyEg8KC1RpZXJVbmtub3duEAASEAoMVGllckV4cGxvcmVyEAESGA'
    'oUVGllckJ1aWxkZXIxV2Vla1RFU1QQAhIaChZUaWVyQ29DcmVhdG9yMVdlZWtURVNUEAMSFAoQ'
    'VGllckJ1aWxkZXIxWWVhchAEEhYKElRpZXJDb0NyZWF0b3IxWWVhchAFEhMKD1RpZXJCdWlsZG'
    'VyUGx1cxAGEhMKD1RpZXJBbnl0eXBlVGVhbRAH');

@$core.Deprecated('Use subscriptionStatusDescriptor instead')
const SubscriptionStatus$json = {
  '1': 'SubscriptionStatus',
  '2': [
    {'1': 'StatusUnknown', '2': 0},
    {'1': 'StatusPending', '2': 1},
    {'1': 'StatusActive', '2': 2},
    {'1': 'StatusPendingRequiresFinalization', '2': 3},
  ],
};

/// Descriptor for `SubscriptionStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subscriptionStatusDescriptor = $convert.base64Decode(
    'ChJTdWJzY3JpcHRpb25TdGF0dXMSEQoNU3RhdHVzVW5rbm93bhAAEhEKDVN0YXR1c1BlbmRpbm'
    'cQARIQCgxTdGF0dXNBY3RpdmUQAhIlCiFTdGF0dXNQZW5kaW5nUmVxdWlyZXNGaW5hbGl6YXRp'
    'b24QAw==');

@$core.Deprecated('Use paymentMethodDescriptor instead')
const PaymentMethod$json = {
  '1': 'PaymentMethod',
  '2': [
    {'1': 'MethodCard', '2': 0},
    {'1': 'MethodCrypto', '2': 1},
    {'1': 'MethodApplePay', '2': 2},
    {'1': 'MethodGooglePay', '2': 3},
    {'1': 'MethodAppleInapp', '2': 4},
    {'1': 'MethodGoogleInapp', '2': 5},
    {'1': 'MethodNone', '2': 6},
  ],
};

/// Descriptor for `PaymentMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentMethodDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50TWV0aG9kEg4KCk1ldGhvZENhcmQQABIQCgxNZXRob2RDcnlwdG8QARISCg5NZX'
    'Rob2RBcHBsZVBheRACEhMKD01ldGhvZEdvb2dsZVBheRADEhQKEE1ldGhvZEFwcGxlSW5hcHAQ'
    'BBIVChFNZXRob2RHb29nbGVJbmFwcBAFEg4KCk1ldGhvZE5vbmUQBg==');

@$core.Deprecated('Use errorCodesDescriptor instead')
const ErrorCodes$json = {
  '1': 'ErrorCodes',
  '2': [
    {'1': 'Unexpected', '2': 0},
    {'1': 'EthAddressEmpty', '2': 1},
    {'1': 'InvalidSignature', '2': 2},
    {'1': 'TierWrong', '2': 3},
    {'1': 'TierNotFound', '2': 4},
    {'1': 'TierInactive', '2': 5},
    {'1': 'PaymentMethodWrong', '2': 6},
    {'1': 'BadAnyName', '2': 7},
    {'1': 'Unknown', '2': 8},
    {'1': 'SubsAlreadyActive', '2': 9},
    {'1': 'SubsNotFound', '2': 10},
    {'1': 'SubsWrongState', '2': 11},
    {'1': 'EmailWrongFormat', '2': 12},
    {'1': 'EmailAlreadyVerified', '2': 13},
    {'1': 'EmailAlreadySent', '2': 14},
    {'1': 'EmailFailedToSend', '2': 15},
    {'1': 'EmailExpired', '2': 16},
    {'1': 'EmailWrongCode', '2': 17},
    {'1': 'AppleInvalidReceipt', '2': 18},
    {'1': 'ApplePurchaseRegistration', '2': 19},
    {'1': 'AppleSubscriptionRenew', '2': 20},
    {'1': 'CodeNotFound', '2': 21},
    {'1': 'CodeAlreadyUsed', '2': 22},
    {'1': 'ErrorOffset', '2': 600},
  ],
};

/// Descriptor for `ErrorCodes`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorCodesDescriptor = $convert.base64Decode(
    'CgpFcnJvckNvZGVzEg4KClVuZXhwZWN0ZWQQABITCg9FdGhBZGRyZXNzRW1wdHkQARIUChBJbn'
    'ZhbGlkU2lnbmF0dXJlEAISDQoJVGllcldyb25nEAMSEAoMVGllck5vdEZvdW5kEAQSEAoMVGll'
    'ckluYWN0aXZlEAUSFgoSUGF5bWVudE1ldGhvZFdyb25nEAYSDgoKQmFkQW55TmFtZRAHEgsKB1'
    'Vua25vd24QCBIVChFTdWJzQWxyZWFkeUFjdGl2ZRAJEhAKDFN1YnNOb3RGb3VuZBAKEhIKDlN1'
    'YnNXcm9uZ1N0YXRlEAsSFAoQRW1haWxXcm9uZ0Zvcm1hdBAMEhgKFEVtYWlsQWxyZWFkeVZlcm'
    'lmaWVkEA0SFAoQRW1haWxBbHJlYWR5U2VudBAOEhUKEUVtYWlsRmFpbGVkVG9TZW5kEA8SEAoM'
    'RW1haWxFeHBpcmVkEBASEgoORW1haWxXcm9uZ0NvZGUQERIXChNBcHBsZUludmFsaWRSZWNlaX'
    'B0EBISHQoZQXBwbGVQdXJjaGFzZVJlZ2lzdHJhdGlvbhATEhoKFkFwcGxlU3Vic2NyaXB0aW9u'
    'UmVuZXcQFBIQCgxDb2RlTm90Rm91bmQQFRITCg9Db2RlQWxyZWFkeVVzZWQQFhIQCgtFcnJvck'
    '9mZnNldBDYBA==');

@$core.Deprecated('Use getSubscriptionRequestDescriptor instead')
const GetSubscriptionRequest$json = {
  '1': 'GetSubscriptionRequest',
  '2': [
    {'1': 'ownerAnyID', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyID'},
  ],
};

/// Descriptor for `GetSubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRTdWJzY3JpcHRpb25SZXF1ZXN0Eh4KCm93bmVyQW55SUQYASABKAlSCm93bmVyQW55SU'
        'Q=');

@$core.Deprecated('Use getSubscriptionRequestSignedDescriptor instead')
const GetSubscriptionRequestSigned$json = {
  '1': 'GetSubscriptionRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `GetSubscriptionRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionRequestSignedDescriptor =
    $convert.base64Decode(
        'ChxHZXRTdWJzY3JpcHRpb25SZXF1ZXN0U2lnbmVkEhgKB3BheWxvYWQYASABKAxSB3BheWxvYW'
        'QSHAoJc2lnbmF0dXJlGAIgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use getSubscriptionResponseDescriptor instead')
const GetSubscriptionResponse$json = {
  '1': 'GetSubscriptionResponse',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 13, '10': 'tier'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.SubscriptionStatus',
      '10': 'status'
    },
    {'1': 'dateStarted', '3': 3, '4': 1, '5': 4, '10': 'dateStarted'},
    {'1': 'dateEnds', '3': 4, '4': 1, '5': 4, '10': 'dateEnds'},
    {'1': 'isAutoRenew', '3': 5, '4': 1, '5': 8, '10': 'isAutoRenew'},
    {
      '1': 'paymentMethod',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.PaymentMethod',
      '10': 'paymentMethod'
    },
    {'1': 'requestedAnyName', '3': 7, '4': 1, '5': 9, '10': 'requestedAnyName'},
    {'1': 'userEmail', '3': 8, '4': 1, '5': 9, '10': 'userEmail'},
    {
      '1': 'subscribeToNewsletter',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'subscribeToNewsletter'
    },
  ],
};

/// Descriptor for `GetSubscriptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionResponseDescriptor = $convert.base64Decode(
    'ChdHZXRTdWJzY3JpcHRpb25SZXNwb25zZRISCgR0aWVyGAEgASgNUgR0aWVyEisKBnN0YXR1cx'
    'gCIAEoDjITLlN1YnNjcmlwdGlvblN0YXR1c1IGc3RhdHVzEiAKC2RhdGVTdGFydGVkGAMgASgE'
    'UgtkYXRlU3RhcnRlZBIaCghkYXRlRW5kcxgEIAEoBFIIZGF0ZUVuZHMSIAoLaXNBdXRvUmVuZX'
    'cYBSABKAhSC2lzQXV0b1JlbmV3EjQKDXBheW1lbnRNZXRob2QYBiABKA4yDi5QYXltZW50TWV0'
    'aG9kUg1wYXltZW50TWV0aG9kEioKEHJlcXVlc3RlZEFueU5hbWUYByABKAlSEHJlcXVlc3RlZE'
    'FueU5hbWUSHAoJdXNlckVtYWlsGAggASgJUgl1c2VyRW1haWwSNAoVc3Vic2NyaWJlVG9OZXdz'
    'bGV0dGVyGAkgASgIUhVzdWJzY3JpYmVUb05ld3NsZXR0ZXI=');

@$core.Deprecated('Use buySubscriptionRequestDescriptor instead')
const BuySubscriptionRequest$json = {
  '1': 'BuySubscriptionRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'requestedTier', '3': 3, '4': 1, '5': 13, '10': 'requestedTier'},
    {
      '1': 'paymentMethod',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.PaymentMethod',
      '10': 'paymentMethod'
    },
    {'1': 'requestedAnyName', '3': 5, '4': 1, '5': 9, '10': 'requestedAnyName'},
    {'1': 'userEmail', '3': 6, '4': 1, '5': 9, '10': 'userEmail'},
  ],
};

/// Descriptor for `BuySubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buySubscriptionRequestDescriptor = $convert.base64Decode(
    'ChZCdXlTdWJzY3JpcHRpb25SZXF1ZXN0Eh4KCm93bmVyQW55SWQYASABKAlSCm93bmVyQW55SW'
    'QSKAoPb3duZXJFdGhBZGRyZXNzGAIgASgJUg9vd25lckV0aEFkZHJlc3MSJAoNcmVxdWVzdGVk'
    'VGllchgDIAEoDVINcmVxdWVzdGVkVGllchI0Cg1wYXltZW50TWV0aG9kGAQgASgOMg4uUGF5bW'
    'VudE1ldGhvZFINcGF5bWVudE1ldGhvZBIqChByZXF1ZXN0ZWRBbnlOYW1lGAUgASgJUhByZXF1'
    'ZXN0ZWRBbnlOYW1lEhwKCXVzZXJFbWFpbBgGIAEoCVIJdXNlckVtYWls');

@$core.Deprecated('Use buySubscriptionRequestSignedDescriptor instead')
const BuySubscriptionRequestSigned$json = {
  '1': 'BuySubscriptionRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `BuySubscriptionRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buySubscriptionRequestSignedDescriptor =
    $convert.base64Decode(
        'ChxCdXlTdWJzY3JpcHRpb25SZXF1ZXN0U2lnbmVkEhgKB3BheWxvYWQYASABKAxSB3BheWxvYW'
        'QSHAoJc2lnbmF0dXJlGAIgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use buySubscriptionResponseDescriptor instead')
const BuySubscriptionResponse$json = {
  '1': 'BuySubscriptionResponse',
  '2': [
    {'1': 'paymentUrl', '3': 1, '4': 1, '5': 9, '10': 'paymentUrl'},
    {'1': 'billingID', '3': 2, '4': 1, '5': 9, '10': 'billingID'},
  ],
};

/// Descriptor for `BuySubscriptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buySubscriptionResponseDescriptor =
    $convert.base64Decode(
        'ChdCdXlTdWJzY3JpcHRpb25SZXNwb25zZRIeCgpwYXltZW50VXJsGAEgASgJUgpwYXltZW50VX'
        'JsEhwKCWJpbGxpbmdJRBgCIAEoCVIJYmlsbGluZ0lE');

@$core.Deprecated('Use finalizeSubscriptionRequestDescriptor instead')
const FinalizeSubscriptionRequest$json = {
  '1': 'FinalizeSubscriptionRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'requestedAnyName', '3': 3, '4': 1, '5': 9, '10': 'requestedAnyName'},
  ],
};

/// Descriptor for `FinalizeSubscriptionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizeSubscriptionRequestDescriptor =
    $convert.base64Decode(
        'ChtGaW5hbGl6ZVN1YnNjcmlwdGlvblJlcXVlc3QSHgoKb3duZXJBbnlJZBgBIAEoCVIKb3duZX'
        'JBbnlJZBIoCg9vd25lckV0aEFkZHJlc3MYAiABKAlSD293bmVyRXRoQWRkcmVzcxIqChByZXF1'
        'ZXN0ZWRBbnlOYW1lGAMgASgJUhByZXF1ZXN0ZWRBbnlOYW1l');

@$core.Deprecated('Use finalizeSubscriptionResponseDescriptor instead')
const FinalizeSubscriptionResponse$json = {
  '1': 'FinalizeSubscriptionResponse',
};

/// Descriptor for `FinalizeSubscriptionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizeSubscriptionResponseDescriptor =
    $convert.base64Decode('ChxGaW5hbGl6ZVN1YnNjcmlwdGlvblJlc3BvbnNl');

@$core.Deprecated('Use finalizeSubscriptionRequestSignedDescriptor instead')
const FinalizeSubscriptionRequestSigned$json = {
  '1': 'FinalizeSubscriptionRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `FinalizeSubscriptionRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizeSubscriptionRequestSignedDescriptor =
    $convert.base64Decode(
        'CiFGaW5hbGl6ZVN1YnNjcmlwdGlvblJlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcG'
        'F5bG9hZBIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use getSubscriptionPortalLinkRequestDescriptor instead')
const GetSubscriptionPortalLinkRequest$json = {
  '1': 'GetSubscriptionPortalLinkRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
  ],
};

/// Descriptor for `GetSubscriptionPortalLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionPortalLinkRequestDescriptor =
    $convert.base64Decode(
        'CiBHZXRTdWJzY3JpcHRpb25Qb3J0YWxMaW5rUmVxdWVzdBIeCgpvd25lckFueUlkGAEgASgJUg'
        'pvd25lckFueUlk');

@$core
    .Deprecated('Use getSubscriptionPortalLinkRequestSignedDescriptor instead')
const GetSubscriptionPortalLinkRequestSigned$json = {
  '1': 'GetSubscriptionPortalLinkRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `GetSubscriptionPortalLinkRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionPortalLinkRequestSignedDescriptor =
    $convert.base64Decode(
        'CiZHZXRTdWJzY3JpcHRpb25Qb3J0YWxMaW5rUmVxdWVzdFNpZ25lZBIYCgdwYXlsb2FkGAEgAS'
        'gMUgdwYXlsb2FkEhwKCXNpZ25hdHVyZRgCIAEoDFIJc2lnbmF0dXJl');

@$core.Deprecated('Use getSubscriptionPortalLinkResponseDescriptor instead')
const GetSubscriptionPortalLinkResponse$json = {
  '1': 'GetSubscriptionPortalLinkResponse',
  '2': [
    {'1': 'portalUrl', '3': 1, '4': 1, '5': 9, '10': 'portalUrl'},
  ],
};

/// Descriptor for `GetSubscriptionPortalLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSubscriptionPortalLinkResponseDescriptor =
    $convert.base64Decode(
        'CiFHZXRTdWJzY3JpcHRpb25Qb3J0YWxMaW5rUmVzcG9uc2USHAoJcG9ydGFsVXJsGAEgASgJUg'
        'lwb3J0YWxVcmw=');

@$core.Deprecated('Use getVerificationEmailRequestDescriptor instead')
const GetVerificationEmailRequest$json = {
  '1': 'GetVerificationEmailRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'subscribeToNewsletter',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'subscribeToNewsletter'
    },
    {
      '1': 'insiderTipsAndTutorials',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'insiderTipsAndTutorials'
    },
    {'1': 'isOnboardingList', '3': 5, '4': 1, '5': 8, '10': 'isOnboardingList'},
  ],
};

/// Descriptor for `GetVerificationEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVerificationEmailRequestDescriptor = $convert.base64Decode(
    'ChtHZXRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3QSHgoKb3duZXJBbnlJZBgBIAEoCVIKb3duZX'
    'JBbnlJZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSNAoVc3Vic2NyaWJlVG9OZXdzbGV0dGVyGAMg'
    'ASgIUhVzdWJzY3JpYmVUb05ld3NsZXR0ZXISOAoXaW5zaWRlclRpcHNBbmRUdXRvcmlhbHMYBC'
    'ABKAhSF2luc2lkZXJUaXBzQW5kVHV0b3JpYWxzEioKEGlzT25ib2FyZGluZ0xpc3QYBSABKAhS'
    'EGlzT25ib2FyZGluZ0xpc3Q=');

@$core.Deprecated('Use getVerificationEmailResponseDescriptor instead')
const GetVerificationEmailResponse$json = {
  '1': 'GetVerificationEmailResponse',
};

/// Descriptor for `GetVerificationEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVerificationEmailResponseDescriptor =
    $convert.base64Decode('ChxHZXRWZXJpZmljYXRpb25FbWFpbFJlc3BvbnNl');

@$core.Deprecated('Use getVerificationEmailRequestSignedDescriptor instead')
const GetVerificationEmailRequestSigned$json = {
  '1': 'GetVerificationEmailRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `GetVerificationEmailRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVerificationEmailRequestSignedDescriptor =
    $convert.base64Decode(
        'CiFHZXRWZXJpZmljYXRpb25FbWFpbFJlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcG'
        'F5bG9hZBIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use verifyEmailRequestDescriptor instead')
const VerifyEmailRequest$json = {
  '1': 'VerifyEmailRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `VerifyEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestDescriptor = $convert.base64Decode(
    'ChJWZXJpZnlFbWFpbFJlcXVlc3QSHgoKb3duZXJBbnlJZBgBIAEoCVIKb3duZXJBbnlJZBIoCg'
    '9vd25lckV0aEFkZHJlc3MYAiABKAlSD293bmVyRXRoQWRkcmVzcxISCgRjb2RlGAMgASgJUgRj'
    'b2Rl');

@$core.Deprecated('Use verifyEmailResponseDescriptor instead')
const VerifyEmailResponse$json = {
  '1': 'VerifyEmailResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `VerifyEmailResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailResponseDescriptor =
    $convert.base64Decode(
        'ChNWZXJpZnlFbWFpbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use verifyEmailRequestSignedDescriptor instead')
const VerifyEmailRequestSigned$json = {
  '1': 'VerifyEmailRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `VerifyEmailRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyEmailRequestSignedDescriptor =
    $convert.base64Decode(
        'ChhWZXJpZnlFbWFpbFJlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcGF5bG9hZBIcCg'
        'lzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use isNameValidRequestDescriptor instead')
const IsNameValidRequest$json = {
  '1': 'IsNameValidRequest',
  '2': [
    {'1': 'requestedTier', '3': 1, '4': 1, '5': 13, '10': 'requestedTier'},
    {'1': 'requestedAnyName', '3': 2, '4': 1, '5': 9, '10': 'requestedAnyName'},
  ],
};

/// Descriptor for `IsNameValidRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isNameValidRequestDescriptor = $convert.base64Decode(
    'ChJJc05hbWVWYWxpZFJlcXVlc3QSJAoNcmVxdWVzdGVkVGllchgBIAEoDVINcmVxdWVzdGVkVG'
    'llchIqChByZXF1ZXN0ZWRBbnlOYW1lGAIgASgJUhByZXF1ZXN0ZWRBbnlOYW1l');

@$core.Deprecated('Use isNameValidResponseDescriptor instead')
const IsNameValidResponse$json = {
  '1': 'IsNameValidResponse',
  '2': [
    {
      '1': 'code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.IsNameValidResponse.Code',
      '10': 'code'
    },
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': [IsNameValidResponse_Code$json],
};

@$core.Deprecated('Use isNameValidResponseDescriptor instead')
const IsNameValidResponse_Code$json = {
  '1': 'Code',
  '2': [
    {'1': 'Valid', '2': 0},
    {'1': 'NoDotAny', '2': 1},
    {'1': 'TooShort', '2': 2},
    {'1': 'TooLong', '2': 3},
    {'1': 'HasInvalidChars', '2': 4},
    {'1': 'TierFeatureNoName', '2': 5},
    {'1': 'CanNotReserve', '2': 6},
  ],
};

/// Descriptor for `IsNameValidResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isNameValidResponseDescriptor = $convert.base64Decode(
    'ChNJc05hbWVWYWxpZFJlc3BvbnNlEi0KBGNvZGUYASABKA4yGS5Jc05hbWVWYWxpZFJlc3Bvbn'
    'NlLkNvZGVSBGNvZGUSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaXB0aW9uInkKBENvZGUS'
    'CQoFVmFsaWQQABIMCghOb0RvdEFueRABEgwKCFRvb1Nob3J0EAISCwoHVG9vTG9uZxADEhMKD0'
    'hhc0ludmFsaWRDaGFycxAEEhUKEVRpZXJGZWF0dXJlTm9OYW1lEAUSEQoNQ2FuTm90UmVzZXJ2'
    'ZRAG');

@$core.Deprecated('Use verifyAppStoreReceiptRequestDescriptor instead')
const VerifyAppStoreReceiptRequest$json = {
  '1': 'VerifyAppStoreReceiptRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'receipt', '3': 2, '4': 1, '5': 9, '10': 'receipt'},
  ],
};

/// Descriptor for `VerifyAppStoreReceiptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAppStoreReceiptRequestDescriptor =
    $convert.base64Decode(
        'ChxWZXJpZnlBcHBTdG9yZVJlY2VpcHRSZXF1ZXN0Eh4KCm93bmVyQW55SWQYASABKAlSCm93bm'
        'VyQW55SWQSGAoHcmVjZWlwdBgCIAEoCVIHcmVjZWlwdA==');

@$core.Deprecated('Use verifyAppStoreReceiptRequestSignedDescriptor instead')
const VerifyAppStoreReceiptRequestSigned$json = {
  '1': 'VerifyAppStoreReceiptRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `VerifyAppStoreReceiptRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAppStoreReceiptRequestSignedDescriptor =
    $convert.base64Decode(
        'CiJWZXJpZnlBcHBTdG9yZVJlY2VpcHRSZXF1ZXN0U2lnbmVkEhgKB3BheWxvYWQYASABKAxSB3'
        'BheWxvYWQSHAoJc2lnbmF0dXJlGAIgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use verifyAppStoreReceiptResponseDescriptor instead')
const VerifyAppStoreReceiptResponse$json = {
  '1': 'VerifyAppStoreReceiptResponse',
};

/// Descriptor for `VerifyAppStoreReceiptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyAppStoreReceiptResponseDescriptor =
    $convert.base64Decode('Ch1WZXJpZnlBcHBTdG9yZVJlY2VpcHRSZXNwb25zZQ==');

@$core.Deprecated('Use codeGetInfoRequestDescriptor instead')
const CodeGetInfoRequest$json = {
  '1': 'CodeGetInfoRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CodeGetInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeGetInfoRequestDescriptor = $convert.base64Decode(
    'ChJDb2RlR2V0SW5mb1JlcXVlc3QSHgoKb3duZXJBbnlJZBgBIAEoCVIKb3duZXJBbnlJZBIoCg'
    '9vd25lckV0aEFkZHJlc3MYAiABKAlSD293bmVyRXRoQWRkcmVzcxISCgRjb2RlGAMgASgJUgRj'
    'b2Rl');

@$core.Deprecated('Use codeGetInfoRequestSignedDescriptor instead')
const CodeGetInfoRequestSigned$json = {
  '1': 'CodeGetInfoRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `CodeGetInfoRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeGetInfoRequestSignedDescriptor =
    $convert.base64Decode(
        'ChhDb2RlR2V0SW5mb1JlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcGF5bG9hZBIcCg'
        'lzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use codeGetInfoResponseDescriptor instead')
const CodeGetInfoResponse$json = {
  '1': 'CodeGetInfoResponse',
  '2': [
    {'1': 'tier', '3': 1, '4': 1, '5': 13, '10': 'tier'},
  ],
};

/// Descriptor for `CodeGetInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeGetInfoResponseDescriptor = $convert
    .base64Decode('ChNDb2RlR2V0SW5mb1Jlc3BvbnNlEhIKBHRpZXIYASABKA1SBHRpZXI=');

@$core.Deprecated('Use codeRedeemRequestDescriptor instead')
const CodeRedeemRequest$json = {
  '1': 'CodeRedeemRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'requestedAnyName', '3': 3, '4': 1, '5': 9, '10': 'requestedAnyName'},
    {'1': 'code', '3': 4, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CodeRedeemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeRedeemRequestDescriptor = $convert.base64Decode(
    'ChFDb2RlUmVkZWVtUmVxdWVzdBIeCgpvd25lckFueUlkGAEgASgJUgpvd25lckFueUlkEigKD2'
    '93bmVyRXRoQWRkcmVzcxgCIAEoCVIPb3duZXJFdGhBZGRyZXNzEioKEHJlcXVlc3RlZEFueU5h'
    'bWUYAyABKAlSEHJlcXVlc3RlZEFueU5hbWUSEgoEY29kZRgEIAEoCVIEY29kZQ==');

@$core.Deprecated('Use codeRedeemRequestSignedDescriptor instead')
const CodeRedeemRequestSigned$json = {
  '1': 'CodeRedeemRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `CodeRedeemRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeRedeemRequestSignedDescriptor =
    $convert.base64Decode(
        'ChdDb2RlUmVkZWVtUmVxdWVzdFNpZ25lZBIYCgdwYXlsb2FkGAEgASgMUgdwYXlsb2FkEhwKCX'
        'NpZ25hdHVyZRgCIAEoDFIJc2lnbmF0dXJl');

@$core.Deprecated('Use codeRedeemResponseDescriptor instead')
const CodeRedeemResponse$json = {
  '1': 'CodeRedeemResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `CodeRedeemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List codeRedeemResponseDescriptor =
    $convert.base64Decode(
        'ChJDb2RlUmVkZWVtUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2Vzcw==');
