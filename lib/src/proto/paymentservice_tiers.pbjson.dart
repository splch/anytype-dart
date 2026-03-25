// This is a generated file - do not edit.
//
// Generated from paymentservice_tiers.proto.

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

@$core.Deprecated('Use periodTypeDescriptor instead')
const PeriodType$json = {
  '1': 'PeriodType',
  '2': [
    {'1': 'PeriodTypeUnknown', '2': 0},
    {'1': 'PeriodTypeUnlimited', '2': 1},
    {'1': 'PeriodTypeDays', '2': 2},
    {'1': 'PeriodTypeWeeks', '2': 3},
    {'1': 'PeriodTypeMonths', '2': 4},
    {'1': 'PeriodTypeYears', '2': 5},
  ],
};

/// Descriptor for `PeriodType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List periodTypeDescriptor = $convert.base64Decode(
    'CgpQZXJpb2RUeXBlEhUKEVBlcmlvZFR5cGVVbmtub3duEAASFwoTUGVyaW9kVHlwZVVubGltaX'
    'RlZBABEhIKDlBlcmlvZFR5cGVEYXlzEAISEwoPUGVyaW9kVHlwZVdlZWtzEAMSFAoQUGVyaW9k'
    'VHlwZU1vbnRocxAEEhMKD1BlcmlvZFR5cGVZZWFycxAF');

@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `Feature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureDescriptor = $convert.base64Decode(
    'CgdGZWF0dXJlEiAKC2Rlc2NyaXB0aW9uGAEgASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use getTiersRequestDescriptor instead')
const GetTiersRequest$json = {
  '1': 'GetTiersRequest',
  '2': [
    {'1': 'ownerAnyId', '3': 1, '4': 1, '5': 9, '10': 'ownerAnyId'},
    {'1': 'locale', '3': 2, '4': 1, '5': 9, '10': 'locale'},
    {'1': 'version', '3': 3, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `GetTiersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTiersRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRUaWVyc1JlcXVlc3QSHgoKb3duZXJBbnlJZBgBIAEoCVIKb3duZXJBbnlJZBIWCgZsb2'
    'NhbGUYAiABKAlSBmxvY2FsZRIYCgd2ZXJzaW9uGAMgASgJUgd2ZXJzaW9u');

@$core.Deprecated('Use getTiersRequestSignedDescriptor instead')
const GetTiersRequestSigned$json = {
  '1': 'GetTiersRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `GetTiersRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTiersRequestSignedDescriptor = $convert.base64Decode(
    'ChVHZXRUaWVyc1JlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcGF5bG9hZBIcCglzaW'
    'duYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use tierDataDescriptor instead')
const TierData$json = {
  '1': 'TierData',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'isActive', '3': 4, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'isTest', '3': 5, '4': 1, '5': 8, '10': 'isTest'},
    {'1': 'isHiddenTier', '3': 6, '4': 1, '5': 8, '10': 'isHiddenTier'},
    {
      '1': 'periodType',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.PeriodType',
      '10': 'periodType'
    },
    {'1': 'periodValue', '3': 8, '4': 1, '5': 13, '10': 'periodValue'},
    {
      '1': 'priceStripeUsdCents',
      '3': 9,
      '4': 1,
      '5': 13,
      '10': 'priceStripeUsdCents'
    },
    {
      '1': 'anyNamesCountIncluded',
      '3': 10,
      '4': 1,
      '5': 13,
      '10': 'anyNamesCountIncluded'
    },
    {
      '1': 'anyNameMinLength',
      '3': 11,
      '4': 1,
      '5': 13,
      '10': 'anyNameMinLength'
    },
    {
      '1': 'features',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.Feature',
      '10': 'features'
    },
    {'1': 'colorStr', '3': 13, '4': 1, '5': 9, '10': 'colorStr'},
    {'1': 'stripeProductId', '3': 14, '4': 1, '5': 9, '10': 'stripeProductId'},
    {'1': 'stripeManageUrl', '3': 15, '4': 1, '5': 9, '10': 'stripeManageUrl'},
    {'1': 'iosProductId', '3': 16, '4': 1, '5': 9, '10': 'iosProductId'},
    {'1': 'iosManageUrl', '3': 17, '4': 1, '5': 9, '10': 'iosManageUrl'},
    {
      '1': 'androidProductId',
      '3': 18,
      '4': 1,
      '5': 9,
      '10': 'androidProductId'
    },
    {
      '1': 'androidManageUrl',
      '3': 19,
      '4': 1,
      '5': 9,
      '10': 'androidManageUrl'
    },
    {'1': 'offer', '3': 20, '4': 1, '5': 9, '10': 'offer'},
  ],
};

/// Descriptor for `TierData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tierDataDescriptor = $convert.base64Decode(
    'CghUaWVyRGF0YRIOCgJpZBgBIAEoDVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcm'
    'lwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGgoIaXNBY3RpdmUYBCABKAhSCGlzQWN0aXZlEhYK'
    'BmlzVGVzdBgFIAEoCFIGaXNUZXN0EiIKDGlzSGlkZGVuVGllchgGIAEoCFIMaXNIaWRkZW5UaW'
    'VyEisKCnBlcmlvZFR5cGUYByABKA4yCy5QZXJpb2RUeXBlUgpwZXJpb2RUeXBlEiAKC3Blcmlv'
    'ZFZhbHVlGAggASgNUgtwZXJpb2RWYWx1ZRIwChNwcmljZVN0cmlwZVVzZENlbnRzGAkgASgNUh'
    'NwcmljZVN0cmlwZVVzZENlbnRzEjQKFWFueU5hbWVzQ291bnRJbmNsdWRlZBgKIAEoDVIVYW55'
    'TmFtZXNDb3VudEluY2x1ZGVkEioKEGFueU5hbWVNaW5MZW5ndGgYCyABKA1SEGFueU5hbWVNaW'
    '5MZW5ndGgSJAoIZmVhdHVyZXMYDCADKAsyCC5GZWF0dXJlUghmZWF0dXJlcxIaCghjb2xvclN0'
    'chgNIAEoCVIIY29sb3JTdHISKAoPc3RyaXBlUHJvZHVjdElkGA4gASgJUg9zdHJpcGVQcm9kdW'
    'N0SWQSKAoPc3RyaXBlTWFuYWdlVXJsGA8gASgJUg9zdHJpcGVNYW5hZ2VVcmwSIgoMaW9zUHJv'
    'ZHVjdElkGBAgASgJUgxpb3NQcm9kdWN0SWQSIgoMaW9zTWFuYWdlVXJsGBEgASgJUgxpb3NNYW'
    '5hZ2VVcmwSKgoQYW5kcm9pZFByb2R1Y3RJZBgSIAEoCVIQYW5kcm9pZFByb2R1Y3RJZBIqChBh'
    'bmRyb2lkTWFuYWdlVXJsGBMgASgJUhBhbmRyb2lkTWFuYWdlVXJsEhQKBW9mZmVyGBQgASgJUg'
    'VvZmZlcg==');

@$core.Deprecated('Use getTiersResponseDescriptor instead')
const GetTiersResponse$json = {
  '1': 'GetTiersResponse',
  '2': [
    {'1': 'tiers', '3': 1, '4': 3, '5': 11, '6': '.TierData', '10': 'tiers'},
  ],
};

/// Descriptor for `GetTiersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTiersResponseDescriptor = $convert.base64Decode(
    'ChBHZXRUaWVyc1Jlc3BvbnNlEh8KBXRpZXJzGAEgAygLMgkuVGllckRhdGFSBXRpZXJz');
