// This is a generated file - do not edit.
//
// Generated from clientspace.proto.

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

@$core.Deprecated('Use spaceExchangeRequestDescriptor instead')
const SpaceExchangeRequest$json = {
  '1': 'SpaceExchangeRequest',
  '2': [
    {'1': 'spaceIds', '3': 1, '4': 3, '5': 9, '10': 'spaceIds'},
    {
      '1': 'localServer',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.clientspace.LocalServer',
      '10': 'localServer'
    },
  ],
};

/// Descriptor for `SpaceExchangeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spaceExchangeRequestDescriptor = $convert.base64Decode(
    'ChRTcGFjZUV4Y2hhbmdlUmVxdWVzdBIaCghzcGFjZUlkcxgBIAMoCVIIc3BhY2VJZHMSOgoLbG'
    '9jYWxTZXJ2ZXIYAiABKAsyGC5jbGllbnRzcGFjZS5Mb2NhbFNlcnZlclILbG9jYWxTZXJ2ZXI=');

@$core.Deprecated('Use spaceExchangeResponseDescriptor instead')
const SpaceExchangeResponse$json = {
  '1': 'SpaceExchangeResponse',
  '2': [
    {'1': 'spaceIds', '3': 1, '4': 3, '5': 9, '10': 'spaceIds'},
  ],
};

/// Descriptor for `SpaceExchangeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spaceExchangeResponseDescriptor =
    $convert.base64Decode(
        'ChVTcGFjZUV4Y2hhbmdlUmVzcG9uc2USGgoIc3BhY2VJZHMYASADKAlSCHNwYWNlSWRz');

@$core.Deprecated('Use localServerDescriptor instead')
const LocalServer$json = {
  '1': 'LocalServer',
  '2': [
    {'1': 'Ips', '3': 1, '4': 3, '5': 9, '10': 'Ips'},
    {'1': 'port', '3': 2, '4': 1, '5': 5, '10': 'port'},
  ],
};

/// Descriptor for `LocalServer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List localServerDescriptor = $convert.base64Decode(
    'CgtMb2NhbFNlcnZlchIQCgNJcHMYASADKAlSA0lwcxISCgRwb3J0GAIgASgFUgRwb3J0');
