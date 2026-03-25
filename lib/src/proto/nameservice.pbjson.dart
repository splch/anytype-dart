// This is a generated file - do not edit.
//
// Generated from nameservice.proto.

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

@$core.Deprecated('Use nameAvailableRequestDescriptor instead')
const NameAvailableRequest$json = {
  '1': 'NameAvailableRequest',
  '2': [
    {'1': 'fullName', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
  ],
};

/// Descriptor for `NameAvailableRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameAvailableRequestDescriptor =
    $convert.base64Decode(
        'ChROYW1lQXZhaWxhYmxlUmVxdWVzdBIaCghmdWxsTmFtZRgBIAEoCVIIZnVsbE5hbWU=');

@$core.Deprecated('Use batchNameAvailableRequestDescriptor instead')
const BatchNameAvailableRequest$json = {
  '1': 'BatchNameAvailableRequest',
  '2': [
    {'1': 'fullNames', '3': 1, '4': 3, '5': 9, '10': 'fullNames'},
  ],
};

/// Descriptor for `BatchNameAvailableRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchNameAvailableRequestDescriptor =
    $convert.base64Decode(
        'ChlCYXRjaE5hbWVBdmFpbGFibGVSZXF1ZXN0EhwKCWZ1bGxOYW1lcxgBIAMoCVIJZnVsbE5hbW'
        'Vz');

@$core.Deprecated('Use nameByAddressRequestDescriptor instead')
const NameByAddressRequest$json = {
  '1': 'NameByAddressRequest',
  '2': [
    {
      '1': 'ownerScwEthAddress',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'ownerScwEthAddress'
    },
  ],
};

/// Descriptor for `NameByAddressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameByAddressRequestDescriptor = $convert.base64Decode(
    'ChROYW1lQnlBZGRyZXNzUmVxdWVzdBIuChJvd25lclNjd0V0aEFkZHJlc3MYASABKAlSEm93bm'
    'VyU2N3RXRoQWRkcmVzcw==');

@$core.Deprecated('Use batchNameByAddressRequestDescriptor instead')
const BatchNameByAddressRequest$json = {
  '1': 'BatchNameByAddressRequest',
  '2': [
    {
      '1': 'ownerScwEthAddresses',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'ownerScwEthAddresses'
    },
  ],
};

/// Descriptor for `BatchNameByAddressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchNameByAddressRequestDescriptor =
    $convert.base64Decode(
        'ChlCYXRjaE5hbWVCeUFkZHJlc3NSZXF1ZXN0EjIKFG93bmVyU2N3RXRoQWRkcmVzc2VzGAEgAy'
        'gJUhRvd25lclNjd0V0aEFkZHJlc3Nlcw==');

@$core.Deprecated('Use nameByAnyIdRequestDescriptor instead')
const NameByAnyIdRequest$json = {
  '1': 'NameByAnyIdRequest',
  '2': [
    {'1': 'anyAddress', '3': 1, '4': 1, '5': 9, '10': 'anyAddress'},
  ],
};

/// Descriptor for `NameByAnyIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameByAnyIdRequestDescriptor = $convert.base64Decode(
    'ChJOYW1lQnlBbnlJZFJlcXVlc3QSHgoKYW55QWRkcmVzcxgBIAEoCVIKYW55QWRkcmVzcw==');

@$core.Deprecated('Use batchNameByAnyIdRequestDescriptor instead')
const BatchNameByAnyIdRequest$json = {
  '1': 'BatchNameByAnyIdRequest',
  '2': [
    {'1': 'anyAddresses', '3': 1, '4': 3, '5': 9, '10': 'anyAddresses'},
  ],
};

/// Descriptor for `BatchNameByAnyIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchNameByAnyIdRequestDescriptor =
    $convert.base64Decode(
        'ChdCYXRjaE5hbWVCeUFueUlkUmVxdWVzdBIiCgxhbnlBZGRyZXNzZXMYASADKAlSDGFueUFkZH'
        'Jlc3Nlcw==');

@$core.Deprecated('Use nameAvailableResponseDescriptor instead')
const NameAvailableResponse$json = {
  '1': 'NameAvailableResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
    {
      '1': 'ownerScwEthAddress',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'ownerScwEthAddress'
    },
    {'1': 'ownerEthAddress', '3': 3, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'ownerAnyAddress', '3': 4, '4': 1, '5': 9, '10': 'ownerAnyAddress'},
    {'1': 'spaceId', '3': 5, '4': 1, '5': 9, '10': 'spaceId'},
    {'1': 'nameExpires', '3': 6, '4': 1, '5': 3, '10': 'nameExpires'},
  ],
};

/// Descriptor for `NameAvailableResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameAvailableResponseDescriptor = $convert.base64Decode(
    'ChVOYW1lQXZhaWxhYmxlUmVzcG9uc2USHAoJYXZhaWxhYmxlGAEgASgIUglhdmFpbGFibGUSLg'
    'oSb3duZXJTY3dFdGhBZGRyZXNzGAIgASgJUhJvd25lclNjd0V0aEFkZHJlc3MSKAoPb3duZXJF'
    'dGhBZGRyZXNzGAMgASgJUg9vd25lckV0aEFkZHJlc3MSKAoPb3duZXJBbnlBZGRyZXNzGAQgAS'
    'gJUg9vd25lckFueUFkZHJlc3MSGAoHc3BhY2VJZBgFIAEoCVIHc3BhY2VJZBIgCgtuYW1lRXhw'
    'aXJlcxgGIAEoA1ILbmFtZUV4cGlyZXM=');

@$core.Deprecated('Use batchNameAvailableResponseDescriptor instead')
const BatchNameAvailableResponse$json = {
  '1': 'BatchNameAvailableResponse',
  '2': [
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.NameAvailableResponse',
      '10': 'results'
    },
  ],
};

/// Descriptor for `BatchNameAvailableResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchNameAvailableResponseDescriptor =
    $convert.base64Decode(
        'ChpCYXRjaE5hbWVBdmFpbGFibGVSZXNwb25zZRIwCgdyZXN1bHRzGAEgAygLMhYuTmFtZUF2YW'
        'lsYWJsZVJlc3BvbnNlUgdyZXN1bHRz');

@$core.Deprecated('Use nameByAddressResponseDescriptor instead')
const NameByAddressResponse$json = {
  '1': 'NameByAddressResponse',
  '2': [
    {'1': 'found', '3': 1, '4': 1, '5': 8, '10': 'found'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `NameByAddressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameByAddressResponseDescriptor = $convert.base64Decode(
    'ChVOYW1lQnlBZGRyZXNzUmVzcG9uc2USFAoFZm91bmQYASABKAhSBWZvdW5kEhIKBG5hbWUYAi'
    'ABKAlSBG5hbWU=');

@$core.Deprecated('Use batchNameByAddressResponseDescriptor instead')
const BatchNameByAddressResponse$json = {
  '1': 'BatchNameByAddressResponse',
  '2': [
    {
      '1': 'results',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.NameByAddressResponse',
      '10': 'results'
    },
  ],
};

/// Descriptor for `BatchNameByAddressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchNameByAddressResponseDescriptor =
    $convert.base64Decode(
        'ChpCYXRjaE5hbWVCeUFkZHJlc3NSZXNwb25zZRIwCgdyZXN1bHRzGAEgAygLMhYuTmFtZUJ5QW'
        'RkcmVzc1Jlc3BvbnNlUgdyZXN1bHRz');
