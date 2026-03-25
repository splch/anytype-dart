// This is a generated file - do not edit.
//
// Generated from nameservice_aa.proto.

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

@$core.Deprecated('Use operationStateDescriptor instead')
const OperationState$json = {
  '1': 'OperationState',
  '2': [
    {'1': 'OpUnknown', '2': 0},
    {'1': 'Pending', '2': 1},
    {'1': 'PendingOrNotFound', '2': 2},
    {'1': 'Completed', '2': 3},
    {'1': 'Error', '2': 4},
  ],
};

/// Descriptor for `OperationState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List operationStateDescriptor = $convert.base64Decode(
    'Cg5PcGVyYXRpb25TdGF0ZRINCglPcFVua25vd24QABILCgdQZW5kaW5nEAESFQoRUGVuZGluZ0'
    '9yTm90Rm91bmQQAhINCglDb21wbGV0ZWQQAxIJCgVFcnJvchAE');

@$core.Deprecated('Use userAccountDescriptor instead')
const UserAccount$json = {
  '1': 'UserAccount',
  '2': [
    {'1': 'ownerEthAddress', '3': 1, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {
      '1': 'ownerSmartContracWalletAddress',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'ownerSmartContracWalletAddress'
    },
    {
      '1': 'ownerSmartContracWalletDeployed',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'ownerSmartContracWalletDeployed'
    },
    {'1': 'namesCountLeft', '3': 4, '4': 1, '5': 4, '10': 'namesCountLeft'},
    {
      '1': 'operationsCountLeft',
      '3': 5,
      '4': 1,
      '5': 4,
      '10': 'operationsCountLeft'
    },
  ],
};

/// Descriptor for `UserAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userAccountDescriptor = $convert.base64Decode(
    'CgtVc2VyQWNjb3VudBIoCg9vd25lckV0aEFkZHJlc3MYASABKAlSD293bmVyRXRoQWRkcmVzcx'
    'JGCh5vd25lclNtYXJ0Q29udHJhY1dhbGxldEFkZHJlc3MYAiABKAlSHm93bmVyU21hcnRDb250'
    'cmFjV2FsbGV0QWRkcmVzcxJICh9vd25lclNtYXJ0Q29udHJhY1dhbGxldERlcGxveWVkGAMgAS'
    'gIUh9vd25lclNtYXJ0Q29udHJhY1dhbGxldERlcGxveWVkEiYKDm5hbWVzQ291bnRMZWZ0GAQg'
    'ASgEUg5uYW1lc0NvdW50TGVmdBIwChNvcGVyYXRpb25zQ291bnRMZWZ0GAUgASgEUhNvcGVyYX'
    'Rpb25zQ291bnRMZWZ0');

@$core.Deprecated('Use adminFundUserAccountRequestDescriptor instead')
const AdminFundUserAccountRequest$json = {
  '1': 'AdminFundUserAccountRequest',
  '2': [
    {'1': 'ownerEthAddress', '3': 1, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'namesCount', '3': 2, '4': 1, '5': 4, '10': 'namesCount'},
  ],
};

/// Descriptor for `AdminFundUserAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFundUserAccountRequestDescriptor =
    $convert.base64Decode(
        'ChtBZG1pbkZ1bmRVc2VyQWNjb3VudFJlcXVlc3QSKAoPb3duZXJFdGhBZGRyZXNzGAEgASgJUg'
        '9vd25lckV0aEFkZHJlc3MSHgoKbmFtZXNDb3VudBgCIAEoBFIKbmFtZXNDb3VudA==');

@$core.Deprecated('Use adminFundUserAccountRequestSignedDescriptor instead')
const AdminFundUserAccountRequestSigned$json = {
  '1': 'AdminFundUserAccountRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `AdminFundUserAccountRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFundUserAccountRequestSignedDescriptor =
    $convert.base64Decode(
        'CiFBZG1pbkZ1bmRVc2VyQWNjb3VudFJlcXVlc3RTaWduZWQSGAoHcGF5bG9hZBgBIAEoDFIHcG'
        'F5bG9hZBIcCglzaWduYXR1cmUYAiABKAxSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use adminFundGasOperationsRequestDescriptor instead')
const AdminFundGasOperationsRequest$json = {
  '1': 'AdminFundGasOperationsRequest',
  '2': [
    {'1': 'ownerEthAddress', '3': 1, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'ownerAnyID', '3': 2, '4': 1, '5': 9, '10': 'ownerAnyID'},
    {'1': 'operationsCount', '3': 3, '4': 1, '5': 4, '10': 'operationsCount'},
  ],
};

/// Descriptor for `AdminFundGasOperationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFundGasOperationsRequestDescriptor =
    $convert.base64Decode(
        'Ch1BZG1pbkZ1bmRHYXNPcGVyYXRpb25zUmVxdWVzdBIoCg9vd25lckV0aEFkZHJlc3MYASABKA'
        'lSD293bmVyRXRoQWRkcmVzcxIeCgpvd25lckFueUlEGAIgASgJUgpvd25lckFueUlEEigKD29w'
        'ZXJhdGlvbnNDb3VudBgDIAEoBFIPb3BlcmF0aW9uc0NvdW50');

@$core.Deprecated('Use adminFundGasOperationsRequestSignedDescriptor instead')
const AdminFundGasOperationsRequestSigned$json = {
  '1': 'AdminFundGasOperationsRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `AdminFundGasOperationsRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminFundGasOperationsRequestSignedDescriptor =
    $convert.base64Decode(
        'CiNBZG1pbkZ1bmRHYXNPcGVyYXRpb25zUmVxdWVzdFNpZ25lZBIYCgdwYXlsb2FkGAEgASgMUg'
        'dwYXlsb2FkEhwKCXNpZ25hdHVyZRgCIAEoDFIJc2lnbmF0dXJl');

@$core.Deprecated('Use getUserAccountRequestDescriptor instead')
const GetUserAccountRequest$json = {
  '1': 'GetUserAccountRequest',
  '2': [
    {'1': 'ownerEthAddress', '3': 1, '4': 1, '5': 9, '10': 'ownerEthAddress'},
  ],
};

/// Descriptor for `GetUserAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAccountRequestDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyQWNjb3VudFJlcXVlc3QSKAoPb3duZXJFdGhBZGRyZXNzGAEgASgJUg9vd25lck'
    'V0aEFkZHJlc3M=');

@$core.Deprecated('Use getDataNameRegisterResponseDescriptor instead')
const GetDataNameRegisterResponse$json = {
  '1': 'GetDataNameRegisterResponse',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'context', '3': 2, '4': 1, '5': 12, '10': 'context'},
  ],
};

/// Descriptor for `GetDataNameRegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDataNameRegisterResponseDescriptor =
    $convert.base64Decode(
        'ChtHZXREYXRhTmFtZVJlZ2lzdGVyUmVzcG9uc2USEgoEZGF0YRgBIAEoDFIEZGF0YRIYCgdjb2'
        '50ZXh0GAIgASgMUgdjb250ZXh0');

@$core.Deprecated('Use createUserOperationRequestDescriptor instead')
const CreateUserOperationRequest$json = {
  '1': 'CreateUserOperationRequest',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'signedData', '3': 2, '4': 1, '5': 12, '10': 'signedData'},
    {'1': 'context', '3': 3, '4': 1, '5': 12, '10': 'context'},
    {'1': 'ownerEthAddress', '3': 4, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'ownerAnyID', '3': 5, '4': 1, '5': 9, '10': 'ownerAnyID'},
    {'1': 'fullName', '3': 6, '4': 1, '5': 9, '10': 'fullName'},
  ],
};

/// Descriptor for `CreateUserOperationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserOperationRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVVc2VyT3BlcmF0aW9uUmVxdWVzdBISCgRkYXRhGAEgASgMUgRkYXRhEh4KCnNpZ2'
    '5lZERhdGEYAiABKAxSCnNpZ25lZERhdGESGAoHY29udGV4dBgDIAEoDFIHY29udGV4dBIoCg9v'
    'd25lckV0aEFkZHJlc3MYBCABKAlSD293bmVyRXRoQWRkcmVzcxIeCgpvd25lckFueUlEGAUgAS'
    'gJUgpvd25lckFueUlEEhoKCGZ1bGxOYW1lGAYgASgJUghmdWxsTmFtZQ==');

@$core.Deprecated('Use createUserOperationRequestSignedDescriptor instead')
const CreateUserOperationRequestSigned$json = {
  '1': 'CreateUserOperationRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `CreateUserOperationRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserOperationRequestSignedDescriptor =
    $convert.base64Decode(
        'CiBDcmVhdGVVc2VyT3BlcmF0aW9uUmVxdWVzdFNpZ25lZBIYCgdwYXlsb2FkGAEgASgMUgdwYX'
        'lsb2FkEhwKCXNpZ25hdHVyZRgCIAEoDFIJc2lnbmF0dXJl');

@$core.Deprecated('Use nameRegisterRequestDescriptor instead')
const NameRegisterRequest$json = {
  '1': 'NameRegisterRequest',
  '2': [
    {'1': 'fullName', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'ownerAnyAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerAnyAddress'},
    {'1': 'ownerEthAddress', '3': 3, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {
      '1': 'registerToSmartContractWallet',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'registerToSmartContractWallet'
    },
    {
      '1': 'registerPeriodMonths',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'registerPeriodMonths'
    },
  ],
};

/// Descriptor for `NameRegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRegisterRequestDescriptor = $convert.base64Decode(
    'ChNOYW1lUmVnaXN0ZXJSZXF1ZXN0EhoKCGZ1bGxOYW1lGAEgASgJUghmdWxsTmFtZRIoCg9vd2'
    '5lckFueUFkZHJlc3MYAiABKAlSD293bmVyQW55QWRkcmVzcxIoCg9vd25lckV0aEFkZHJlc3MY'
    'AyABKAlSD293bmVyRXRoQWRkcmVzcxJECh1yZWdpc3RlclRvU21hcnRDb250cmFjdFdhbGxldB'
    'gEIAEoCFIdcmVnaXN0ZXJUb1NtYXJ0Q29udHJhY3RXYWxsZXQSMgoUcmVnaXN0ZXJQZXJpb2RN'
    'b250aHMYBSABKA1SFHJlZ2lzdGVyUGVyaW9kTW9udGhz');

@$core.Deprecated('Use nameRegisterRequestSignedDescriptor instead')
const NameRegisterRequestSigned$json = {
  '1': 'NameRegisterRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `NameRegisterRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRegisterRequestSignedDescriptor =
    $convert.base64Decode(
        'ChlOYW1lUmVnaXN0ZXJSZXF1ZXN0U2lnbmVkEhgKB3BheWxvYWQYASABKAxSB3BheWxvYWQSHA'
        'oJc2lnbmF0dXJlGAIgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use nameRenewRequestDescriptor instead')
const NameRenewRequest$json = {
  '1': 'NameRenewRequest',
  '2': [
    {'1': 'fullName', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'ownerAnyAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerAnyAddress'},
    {'1': 'ownerEthAddress', '3': 3, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {
      '1': 'renewToSmartContractWallet',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'renewToSmartContractWallet'
    },
    {
      '1': 'renewPeriodMonths',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'renewPeriodMonths'
    },
  ],
};

/// Descriptor for `NameRenewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRenewRequestDescriptor = $convert.base64Decode(
    'ChBOYW1lUmVuZXdSZXF1ZXN0EhoKCGZ1bGxOYW1lGAEgASgJUghmdWxsTmFtZRIoCg9vd25lck'
    'FueUFkZHJlc3MYAiABKAlSD293bmVyQW55QWRkcmVzcxIoCg9vd25lckV0aEFkZHJlc3MYAyAB'
    'KAlSD293bmVyRXRoQWRkcmVzcxI+ChpyZW5ld1RvU21hcnRDb250cmFjdFdhbGxldBgEIAEoCF'
    'IacmVuZXdUb1NtYXJ0Q29udHJhY3RXYWxsZXQSLAoRcmVuZXdQZXJpb2RNb250aHMYBSABKA1S'
    'EXJlbmV3UGVyaW9kTW9udGhz');

@$core.Deprecated('Use nameRenewRequestSignedDescriptor instead')
const NameRenewRequestSigned$json = {
  '1': 'NameRenewRequestSigned',
  '2': [
    {'1': 'payload', '3': 1, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `NameRenewRequestSigned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRenewRequestSignedDescriptor =
    $convert.base64Decode(
        'ChZOYW1lUmVuZXdSZXF1ZXN0U2lnbmVkEhgKB3BheWxvYWQYASABKAxSB3BheWxvYWQSHAoJc2'
        'lnbmF0dXJlGAIgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use nameRegisterForSpaceRequestDescriptor instead')
const NameRegisterForSpaceRequest$json = {
  '1': 'NameRegisterForSpaceRequest',
  '2': [
    {'1': 'fullName', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'ownerAnyAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerAnyAddress'},
    {'1': 'ownerEthAddress', '3': 3, '4': 1, '5': 9, '10': 'ownerEthAddress'},
    {'1': 'spaceId', '3': 4, '4': 1, '5': 9, '10': 'spaceId'},
    {
      '1': 'registerPeriodMonths',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'registerPeriodMonths'
    },
  ],
};

/// Descriptor for `NameRegisterForSpaceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRegisterForSpaceRequestDescriptor = $convert.base64Decode(
    'ChtOYW1lUmVnaXN0ZXJGb3JTcGFjZVJlcXVlc3QSGgoIZnVsbE5hbWUYASABKAlSCGZ1bGxOYW'
    '1lEigKD293bmVyQW55QWRkcmVzcxgCIAEoCVIPb3duZXJBbnlBZGRyZXNzEigKD293bmVyRXRo'
    'QWRkcmVzcxgDIAEoCVIPb3duZXJFdGhBZGRyZXNzEhgKB3NwYWNlSWQYBCABKAlSB3NwYWNlSW'
    'QSMgoUcmVnaXN0ZXJQZXJpb2RNb250aHMYBSABKA1SFHJlZ2lzdGVyUGVyaW9kTW9udGhz');

@$core.Deprecated('Use getOperationStatusRequestDescriptor instead')
const GetOperationStatusRequest$json = {
  '1': 'GetOperationStatusRequest',
  '2': [
    {'1': 'operationId', '3': 1, '4': 1, '5': 9, '10': 'operationId'},
  ],
};

/// Descriptor for `GetOperationStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOperationStatusRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRPcGVyYXRpb25TdGF0dXNSZXF1ZXN0EiAKC29wZXJhdGlvbklkGAEgASgJUgtvcGVyYX'
        'Rpb25JZA==');

@$core.Deprecated('Use operationResponseDescriptor instead')
const OperationResponse$json = {
  '1': 'OperationResponse',
  '2': [
    {'1': 'operationId', '3': 1, '4': 1, '5': 9, '10': 'operationId'},
    {
      '1': 'operationState',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.OperationState',
      '10': 'operationState'
    },
  ],
};

/// Descriptor for `OperationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List operationResponseDescriptor = $convert.base64Decode(
    'ChFPcGVyYXRpb25SZXNwb25zZRIgCgtvcGVyYXRpb25JZBgBIAEoCVILb3BlcmF0aW9uSWQSNw'
    'oOb3BlcmF0aW9uU3RhdGUYAiABKA4yDy5PcGVyYXRpb25TdGF0ZVIOb3BlcmF0aW9uU3RhdGU=');
