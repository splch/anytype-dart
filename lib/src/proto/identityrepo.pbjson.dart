// This is a generated file - do not edit.
//
// Generated from identityrepo.proto.

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

@$core.Deprecated('Use dataDescriptor instead')
const Data$json = {
  '1': 'Data',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 9, '10': 'kind'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'signature', '3': 3, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `Data`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDescriptor = $convert.base64Decode(
    'CgREYXRhEhIKBGtpbmQYASABKAlSBGtpbmQSEgoEZGF0YRgCIAEoDFIEZGF0YRIcCglzaWduYX'
    'R1cmUYAyABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use dataWithIdentityDescriptor instead')
const DataWithIdentity$json = {
  '1': 'DataWithIdentity',
  '2': [
    {'1': 'identity', '3': 1, '4': 1, '5': 9, '10': 'identity'},
    {
      '1': 'data',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.identityRepo.Data',
      '10': 'data'
    },
  ],
};

/// Descriptor for `DataWithIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataWithIdentityDescriptor = $convert.base64Decode(
    'ChBEYXRhV2l0aElkZW50aXR5EhoKCGlkZW50aXR5GAEgASgJUghpZGVudGl0eRImCgRkYXRhGA'
    'IgAygLMhIuaWRlbnRpdHlSZXBvLkRhdGFSBGRhdGE=');

@$core.Deprecated('Use dataPutRequestDescriptor instead')
const DataPutRequest$json = {
  '1': 'DataPutRequest',
  '2': [
    {'1': 'identity', '3': 1, '4': 1, '5': 9, '10': 'identity'},
    {
      '1': 'data',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.identityRepo.Data',
      '10': 'data'
    },
  ],
};

/// Descriptor for `DataPutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPutRequestDescriptor = $convert.base64Decode(
    'Cg5EYXRhUHV0UmVxdWVzdBIaCghpZGVudGl0eRgBIAEoCVIIaWRlbnRpdHkSJgoEZGF0YRgCIA'
    'MoCzISLmlkZW50aXR5UmVwby5EYXRhUgRkYXRh');

@$core.Deprecated('Use dataDeleteRequestDescriptor instead')
const DataDeleteRequest$json = {
  '1': 'DataDeleteRequest',
  '2': [
    {'1': 'identity', '3': 1, '4': 1, '5': 9, '10': 'identity'},
    {'1': 'kinds', '3': 2, '4': 3, '5': 9, '10': 'kinds'},
  ],
};

/// Descriptor for `DataDeleteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataDeleteRequestDescriptor = $convert.base64Decode(
    'ChFEYXRhRGVsZXRlUmVxdWVzdBIaCghpZGVudGl0eRgBIAEoCVIIaWRlbnRpdHkSFAoFa2luZH'
    'MYAiADKAlSBWtpbmRz');

@$core.Deprecated('Use dataPullRequestDescriptor instead')
const DataPullRequest$json = {
  '1': 'DataPullRequest',
  '2': [
    {'1': 'identities', '3': 1, '4': 3, '5': 9, '10': 'identities'},
    {'1': 'kinds', '3': 2, '4': 3, '5': 9, '10': 'kinds'},
  ],
};

/// Descriptor for `DataPullRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPullRequestDescriptor = $convert.base64Decode(
    'Cg9EYXRhUHVsbFJlcXVlc3QSHgoKaWRlbnRpdGllcxgBIAMoCVIKaWRlbnRpdGllcxIUCgVraW'
    '5kcxgCIAMoCVIFa2luZHM=');

@$core.Deprecated('Use dataPullResponseDescriptor instead')
const DataPullResponse$json = {
  '1': 'DataPullResponse',
  '2': [
    {
      '1': 'data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.identityRepo.DataWithIdentity',
      '10': 'data'
    },
  ],
};

/// Descriptor for `DataPullResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataPullResponseDescriptor = $convert.base64Decode(
    'ChBEYXRhUHVsbFJlc3BvbnNlEjIKBGRhdGEYASADKAsyHi5pZGVudGl0eVJlcG8uRGF0YVdpdG'
    'hJZGVudGl0eVIEZGF0YQ==');

@$core.Deprecated('Use okDescriptor instead')
const Ok$json = {
  '1': 'Ok',
};

/// Descriptor for `Ok`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List okDescriptor = $convert.base64Decode('CgJPaw==');
