// This is a generated file - do not edit.
//
// Generated from paymentservice2.proto.

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

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2$json = {
  '1': 'MembershipV2',
  '3': [
    MembershipV2_Amount$json,
    MembershipV2_Features$json,
    MembershipV2_Product$json,
    MembershipV2_PurchaseInfo$json,
    MembershipV2_ProductStatus$json,
    MembershipV2_PurchasedProduct$json,
    MembershipV2_CartProduct$json,
    MembershipV2_Invoice$json,
    MembershipV2_Cart$json,
    MembershipV2_GetProductsRequest$json,
    MembershipV2_GetProductsResponse$json,
    MembershipV2_GetStatusRequest$json,
    MembershipV2_GetStatusResponse$json,
    MembershipV2_StoreCartGetRequest$json,
    MembershipV2_StoreCartGetResponse$json,
    MembershipV2_StoreCartPromocodeApplyRequest$json,
    MembershipV2_StoreCartCheckoutRequest$json,
    MembershipV2_StoreCartCheckoutResponse$json,
    MembershipV2_StoreCartUpdateRequest$json,
    MembershipV2_StoreCartUpdateResponse$json,
    MembershipV2_StoreCartClearRequest$json,
    MembershipV2_WebAuthRequest$json,
    MembershipV2_WebAuthResponse$json,
    MembershipV2_AnyNameIsValidRequest$json,
    MembershipV2_AnyNameIsValidResponse$json,
    MembershipV2_AnyNameAllocateRequest$json,
    MembershipV2_AnyNameAllocateResponse$json,
    MembershipV2_SubscribeToUpdatesRequest$json,
    MembershipV2_SubscribeToUpdatesResponse$json
  ],
  '4': [
    MembershipV2_PaymentProvider$json,
    MembershipV2_Period$json,
    MembershipV2_Platform$json
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Amount$json = {
  '1': 'Amount',
  '2': [
    {'1': 'currency', '3': 1, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'amountCents', '3': 2, '4': 1, '5': 3, '10': 'amountCents'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Features$json = {
  '1': 'Features',
  '2': [
    {'1': 'storageBytes', '3': 1, '4': 1, '5': 4, '10': 'storageBytes'},
    {'1': 'spaceReaders', '3': 2, '4': 1, '5': 13, '10': 'spaceReaders'},
    {'1': 'spaceWriters', '3': 3, '4': 1, '5': 13, '10': 'spaceWriters'},
    {'1': 'sharedSpaces', '3': 4, '4': 1, '5': 13, '10': 'sharedSpaces'},
    {'1': 'teamSeats', '3': 5, '4': 1, '5': 13, '10': 'teamSeats'},
    {'1': 'anyNameCount', '3': 6, '4': 1, '5': 13, '10': 'anyNameCount'},
    {'1': 'anyNameMinLen', '3': 7, '4': 1, '5': 13, '10': 'anyNameMinLen'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Product$json = {
  '1': 'Product',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'isTopLevel', '3': 4, '4': 1, '5': 8, '10': 'isTopLevel'},
    {'1': 'isHidden', '3': 5, '4': 1, '5': 8, '10': 'isHidden'},
    {'1': 'isIntro', '3': 6, '4': 1, '5': 8, '10': 'isIntro'},
    {'1': 'isUpgradeable', '3': 7, '4': 1, '5': 8, '10': 'isUpgradeable'},
    {
      '1': 'pricesYearly',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.Amount',
      '10': 'pricesYearly'
    },
    {
      '1': 'pricesMonthly',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.Amount',
      '10': 'pricesMonthly'
    },
    {'1': 'colorStr', '3': 10, '4': 1, '5': 9, '10': 'colorStr'},
    {'1': 'offer', '3': 11, '4': 1, '5': 9, '10': 'offer'},
    {
      '1': 'features',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Features',
      '10': 'features'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_PurchaseInfo$json = {
  '1': 'PurchaseInfo',
  '2': [
    {'1': 'dateStarted', '3': 1, '4': 1, '5': 4, '10': 'dateStarted'},
    {'1': 'dateEnds', '3': 2, '4': 1, '5': 4, '10': 'dateEnds'},
    {'1': 'isAutoRenew', '3': 3, '4': 1, '5': 8, '10': 'isAutoRenew'},
    {
      '1': 'period',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.Period',
      '10': 'period'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_ProductStatus$json = {
  '1': 'ProductStatus',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.ProductStatus.Status',
      '10': 'status'
    },
  ],
  '4': [MembershipV2_ProductStatus_Status$json],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_ProductStatus_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'StatusUnknown', '2': 0},
    {'1': 'StatusPending', '2': 1},
    {'1': 'StatusActive', '2': 2},
    {'1': 'StatusPendingRequiresFinalization', '2': 3},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_PurchasedProduct$json = {
  '1': 'PurchasedProduct',
  '2': [
    {
      '1': 'product',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Product',
      '10': 'product'
    },
    {
      '1': 'purchaseInfo',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.PurchaseInfo',
      '10': 'purchaseInfo'
    },
    {
      '1': 'productStatus',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.ProductStatus',
      '10': 'productStatus'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_CartProduct$json = {
  '1': 'CartProduct',
  '2': [
    {
      '1': 'product',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Product',
      '10': 'product'
    },
    {'1': 'isYearly', '3': 2, '4': 1, '5': 8, '10': 'isYearly'},
    {'1': 'remove', '3': 3, '4': 1, '5': 8, '10': 'remove'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Invoice$json = {
  '1': 'Invoice',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'date', '3': 2, '4': 1, '5': 4, '10': 'date'},
    {
      '1': 'total',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Amount',
      '10': 'total'
    },
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.Invoice.Status',
      '10': 'status'
    },
  ],
  '4': [MembershipV2_Invoice_Status$json],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Invoice_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'Unpaid', '2': 0},
    {'1': 'Paid', '2': 1},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Cart$json = {
  '1': 'Cart',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.CartProduct',
      '10': 'products'
    },
    {
      '1': 'total',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Amount',
      '10': 'total'
    },
    {
      '1': 'totalNextInvoice',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Amount',
      '10': 'totalNextInvoice'
    },
    {'1': 'nextInvoiceDate', '3': 4, '4': 1, '5': 4, '10': 'nextInvoiceDate'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_GetProductsRequest$json = {
  '1': 'GetProductsRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_GetProductsResponse$json = {
  '1': 'GetProductsResponse',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.Product',
      '10': 'products'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_GetStatusRequest$json = {
  '1': 'GetStatusRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_GetStatusResponse$json = {
  '1': 'GetStatusResponse',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.PurchasedProduct',
      '10': 'products'
    },
    {
      '1': 'nextInvoice',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Invoice',
      '10': 'nextInvoice'
    },
    {'1': 'teamOwnerID', '3': 3, '4': 1, '5': 9, '10': 'teamOwnerID'},
    {
      '1': 'paymentProvider',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.PaymentProvider',
      '10': 'paymentProvider'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartGetRequest$json = {
  '1': 'StoreCartGetRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartGetResponse$json = {
  '1': 'StoreCartGetResponse',
  '2': [
    {
      '1': 'cart',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Cart',
      '10': 'cart'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartPromocodeApplyRequest$json = {
  '1': 'StoreCartPromocodeApplyRequest',
  '2': [
    {'1': 'promocode', '3': 1, '4': 1, '5': 9, '10': 'promocode'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartCheckoutRequest$json = {
  '1': 'StoreCartCheckoutRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartCheckoutResponse$json = {
  '1': 'StoreCartCheckoutResponse',
  '2': [
    {'1': 'paymentUrl', '3': 1, '4': 1, '5': 9, '10': 'paymentUrl'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartUpdateRequest$json = {
  '1': 'StoreCartUpdateRequest',
  '2': [
    {
      '1': 'products',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.MembershipV2.CartProduct',
      '10': 'products'
    },
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartUpdateResponse$json = {
  '1': 'StoreCartUpdateResponse',
  '2': [
    {
      '1': 'cart',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.MembershipV2.Cart',
      '10': 'cart'
    },
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_StoreCartClearRequest$json = {
  '1': 'StoreCartClearRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_WebAuthRequest$json = {
  '1': 'WebAuthRequest',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_WebAuthResponse$json = {
  '1': 'WebAuthResponse',
  '2': [
    {'1': 'jwt', '3': 1, '4': 1, '5': 9, '10': 'jwt'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_AnyNameIsValidRequest$json = {
  '1': 'AnyNameIsValidRequest',
  '2': [
    {'1': 'requestedAnyName', '3': 1, '4': 1, '5': 9, '10': 'requestedAnyName'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_AnyNameIsValidResponse$json = {
  '1': 'AnyNameIsValidResponse',
  '2': [
    {
      '1': 'code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.AnyNameIsValidResponse.Code',
      '10': 'code'
    },
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
  ],
  '4': [MembershipV2_AnyNameIsValidResponse_Code$json],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_AnyNameIsValidResponse_Code$json = {
  '1': 'Code',
  '2': [
    {'1': 'Valid', '2': 0},
    {'1': 'NoDotAny', '2': 1},
    {'1': 'TooShort', '2': 2},
    {'1': 'TooLong', '2': 3},
    {'1': 'HasInvalidChars', '2': 4},
    {'1': 'AccountHasNoName', '2': 5},
    {'1': 'CanNotReserve', '2': 6},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_AnyNameAllocateRequest$json = {
  '1': 'AnyNameAllocateRequest',
  '2': [
    {'1': 'requestedAnyName', '3': 1, '4': 1, '5': 9, '10': 'requestedAnyName'},
    {'1': 'ownerEthAddress', '3': 2, '4': 1, '5': 9, '10': 'ownerEthAddress'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_AnyNameAllocateResponse$json = {
  '1': 'AnyNameAllocateResponse',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_SubscribeToUpdatesRequest$json = {
  '1': 'SubscribeToUpdatesRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'platform',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.MembershipV2.Platform',
      '10': 'platform'
    },
    {'1': 'subscribe', '3': 3, '4': 1, '5': 8, '10': 'subscribe'},
    {'1': 'context', '3': 4, '4': 1, '5': 9, '10': 'context'},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_SubscribeToUpdatesResponse$json = {
  '1': 'SubscribeToUpdatesResponse',
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_PaymentProvider$json = {
  '1': 'PaymentProvider',
  '2': [
    {'1': 'None', '2': 0},
    {'1': 'Stripe', '2': 1},
    {'1': 'Crypto', '2': 2},
    {'1': 'BillingPortal', '2': 3},
    {'1': 'AppStore', '2': 4},
    {'1': 'GooglePlay', '2': 5},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Period$json = {
  '1': 'Period',
  '2': [
    {'1': 'Unlimited', '2': 0},
    {'1': 'Monthly', '2': 1},
    {'1': 'Yearly', '2': 2},
    {'1': 'ThreeYears', '2': 3},
  ],
};

@$core.Deprecated('Use membershipV2Descriptor instead')
const MembershipV2_Platform$json = {
  '1': 'Platform',
  '2': [
    {'1': 'Unknown', '2': 0},
    {'1': 'Desktop', '2': 1},
    {'1': 'MobileIOS', '2': 2},
    {'1': 'MobileAndroid', '2': 3},
    {'1': 'Web', '2': 4},
  ],
};

/// Descriptor for `MembershipV2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List membershipV2Descriptor = $convert.base64Decode(
    'CgxNZW1iZXJzaGlwVjIaRgoGQW1vdW50EhoKCGN1cnJlbmN5GAEgASgJUghjdXJyZW5jeRIgCg'
    'thbW91bnRDZW50cxgCIAEoA1ILYW1vdW50Q2VudHMaggIKCEZlYXR1cmVzEiIKDHN0b3JhZ2VC'
    'eXRlcxgBIAEoBFIMc3RvcmFnZUJ5dGVzEiIKDHNwYWNlUmVhZGVycxgCIAEoDVIMc3BhY2VSZW'
    'FkZXJzEiIKDHNwYWNlV3JpdGVycxgDIAEoDVIMc3BhY2VXcml0ZXJzEiIKDHNoYXJlZFNwYWNl'
    'cxgEIAEoDVIMc2hhcmVkU3BhY2VzEhwKCXRlYW1TZWF0cxgFIAEoDVIJdGVhbVNlYXRzEiIKDG'
    'FueU5hbWVDb3VudBgGIAEoDVIMYW55TmFtZUNvdW50EiQKDWFueU5hbWVNaW5MZW4YByABKA1S'
    'DWFueU5hbWVNaW5MZW4apwMKB1Byb2R1Y3QSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKA'
    'lSBG5hbWUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh4KCmlzVG9wTGV2ZWwY'
    'BCABKAhSCmlzVG9wTGV2ZWwSGgoIaXNIaWRkZW4YBSABKAhSCGlzSGlkZGVuEhgKB2lzSW50cm'
    '8YBiABKAhSB2lzSW50cm8SJAoNaXNVcGdyYWRlYWJsZRgHIAEoCFINaXNVcGdyYWRlYWJsZRI4'
    'CgxwcmljZXNZZWFybHkYCCADKAsyFC5NZW1iZXJzaGlwVjIuQW1vdW50UgxwcmljZXNZZWFybH'
    'kSOgoNcHJpY2VzTW9udGhseRgJIAMoCzIULk1lbWJlcnNoaXBWMi5BbW91bnRSDXByaWNlc01v'
    'bnRobHkSGgoIY29sb3JTdHIYCiABKAlSCGNvbG9yU3RyEhQKBW9mZmVyGAsgASgJUgVvZmZlch'
    'IyCghmZWF0dXJlcxgMIAEoCzIWLk1lbWJlcnNoaXBWMi5GZWF0dXJlc1IIZmVhdHVyZXManAEK'
    'DFB1cmNoYXNlSW5mbxIgCgtkYXRlU3RhcnRlZBgBIAEoBFILZGF0ZVN0YXJ0ZWQSGgoIZGF0ZU'
    'VuZHMYAiABKARSCGRhdGVFbmRzEiAKC2lzQXV0b1JlbmV3GAMgASgIUgtpc0F1dG9SZW5ldxIs'
    'CgZwZXJpb2QYBCABKA4yFC5NZW1iZXJzaGlwVjIuUGVyaW9kUgZwZXJpb2QatAEKDVByb2R1Y3'
    'RTdGF0dXMSOgoGc3RhdHVzGAEgASgOMiIuTWVtYmVyc2hpcFYyLlByb2R1Y3RTdGF0dXMuU3Rh'
    'dHVzUgZzdGF0dXMiZwoGU3RhdHVzEhEKDVN0YXR1c1Vua25vd24QABIRCg1TdGF0dXNQZW5kaW'
    '5nEAESEAoMU3RhdHVzQWN0aXZlEAISJQohU3RhdHVzUGVuZGluZ1JlcXVpcmVzRmluYWxpemF0'
    'aW9uEAMaxgEKEFB1cmNoYXNlZFByb2R1Y3QSLwoHcHJvZHVjdBgBIAEoCzIVLk1lbWJlcnNoaX'
    'BWMi5Qcm9kdWN0Ugdwcm9kdWN0Ej4KDHB1cmNoYXNlSW5mbxgCIAEoCzIaLk1lbWJlcnNoaXBW'
    'Mi5QdXJjaGFzZUluZm9SDHB1cmNoYXNlSW5mbxJBCg1wcm9kdWN0U3RhdHVzGAMgASgLMhsuTW'
    'VtYmVyc2hpcFYyLlByb2R1Y3RTdGF0dXNSDXByb2R1Y3RTdGF0dXMacgoLQ2FydFByb2R1Y3QS'
    'LwoHcHJvZHVjdBgBIAEoCzIVLk1lbWJlcnNoaXBWMi5Qcm9kdWN0Ugdwcm9kdWN0EhoKCGlzWW'
    'Vhcmx5GAIgASgIUghpc1llYXJseRIWCgZyZW1vdmUYAyABKAhSBnJlbW92ZRqvAQoHSW52b2lj'
    'ZRIOCgJpZBgBIAEoCVICaWQSEgoEZGF0ZRgCIAEoBFIEZGF0ZRIqCgV0b3RhbBgDIAEoCzIULk'
    '1lbWJlcnNoaXBWMi5BbW91bnRSBXRvdGFsEjQKBnN0YXR1cxgEIAEoDjIcLk1lbWJlcnNoaXBW'
    'Mi5JbnZvaWNlLlN0YXR1c1IGc3RhdHVzIh4KBlN0YXR1cxIKCgZVbnBhaWQQABIICgRQYWlkEA'
    'Ea1QEKBENhcnQSNQoIcHJvZHVjdHMYASADKAsyGS5NZW1iZXJzaGlwVjIuQ2FydFByb2R1Y3RS'
    'CHByb2R1Y3RzEioKBXRvdGFsGAIgASgLMhQuTWVtYmVyc2hpcFYyLkFtb3VudFIFdG90YWwSQA'
    'oQdG90YWxOZXh0SW52b2ljZRgDIAEoCzIULk1lbWJlcnNoaXBWMi5BbW91bnRSEHRvdGFsTmV4'
    'dEludm9pY2USKAoPbmV4dEludm9pY2VEYXRlGAQgASgEUg9uZXh0SW52b2ljZURhdGUaFAoSR2'
    'V0UHJvZHVjdHNSZXF1ZXN0GkgKE0dldFByb2R1Y3RzUmVzcG9uc2USMQoIcHJvZHVjdHMYASAD'
    'KAsyFS5NZW1iZXJzaGlwVjIuUHJvZHVjdFIIcHJvZHVjdHMaEgoQR2V0U3RhdHVzUmVxdWVzdB'
    'rzAQoRR2V0U3RhdHVzUmVzcG9uc2USOgoIcHJvZHVjdHMYASADKAsyHi5NZW1iZXJzaGlwVjIu'
    'UHVyY2hhc2VkUHJvZHVjdFIIcHJvZHVjdHMSNwoLbmV4dEludm9pY2UYAiABKAsyFS5NZW1iZX'
    'JzaGlwVjIuSW52b2ljZVILbmV4dEludm9pY2USIAoLdGVhbU93bmVySUQYAyABKAlSC3RlYW1P'
    'd25lcklEEkcKD3BheW1lbnRQcm92aWRlchgEIAEoDjIdLk1lbWJlcnNoaXBWMi5QYXltZW50UH'
    'JvdmlkZXJSD3BheW1lbnRQcm92aWRlchoVChNTdG9yZUNhcnRHZXRSZXF1ZXN0Gj4KFFN0b3Jl'
    'Q2FydEdldFJlc3BvbnNlEiYKBGNhcnQYASABKAsyEi5NZW1iZXJzaGlwVjIuQ2FydFIEY2FydB'
    'o+Ch5TdG9yZUNhcnRQcm9tb2NvZGVBcHBseVJlcXVlc3QSHAoJcHJvbW9jb2RlGAEgASgJUglw'
    'cm9tb2NvZGUaGgoYU3RvcmVDYXJ0Q2hlY2tvdXRSZXF1ZXN0GjsKGVN0b3JlQ2FydENoZWNrb3'
    'V0UmVzcG9uc2USHgoKcGF5bWVudFVybBgBIAEoCVIKcGF5bWVudFVybBp5ChZTdG9yZUNhcnRV'
    'cGRhdGVSZXF1ZXN0EjUKCHByb2R1Y3RzGAEgAygLMhkuTWVtYmVyc2hpcFYyLkNhcnRQcm9kdW'
    'N0Ughwcm9kdWN0cxIoCg9vd25lckV0aEFkZHJlc3MYAiABKAlSD293bmVyRXRoQWRkcmVzcxpB'
    'ChdTdG9yZUNhcnRVcGRhdGVSZXNwb25zZRImCgRjYXJ0GAEgASgLMhIuTWVtYmVyc2hpcFYyLk'
    'NhcnRSBGNhcnQaFwoVU3RvcmVDYXJ0Q2xlYXJSZXF1ZXN0GhAKDldlYkF1dGhSZXF1ZXN0GjUK'
    'D1dlYkF1dGhSZXNwb25zZRIQCgNqd3QYASABKAlSA2p3dBIQCgN1cmwYAiABKAlSA3VybBpDCh'
    'VBbnlOYW1lSXNWYWxpZFJlcXVlc3QSKgoQcmVxdWVzdGVkQW55TmFtZRgBIAEoCVIQcmVxdWVz'
    'dGVkQW55TmFtZRrzAQoWQW55TmFtZUlzVmFsaWRSZXNwb25zZRI9CgRjb2RlGAEgASgOMikuTW'
    'VtYmVyc2hpcFYyLkFueU5hbWVJc1ZhbGlkUmVzcG9uc2UuQ29kZVIEY29kZRIgCgtkZXNjcmlw'
    'dGlvbhgCIAEoCVILZGVzY3JpcHRpb24ieAoEQ29kZRIJCgVWYWxpZBAAEgwKCE5vRG90QW55EA'
    'ESDAoIVG9vU2hvcnQQAhILCgdUb29Mb25nEAMSEwoPSGFzSW52YWxpZENoYXJzEAQSFAoQQWNj'
    'b3VudEhhc05vTmFtZRAFEhEKDUNhbk5vdFJlc2VydmUQBhpuChZBbnlOYW1lQWxsb2NhdGVSZX'
    'F1ZXN0EioKEHJlcXVlc3RlZEFueU5hbWUYASABKAlSEHJlcXVlc3RlZEFueU5hbWUSKAoPb3du'
    'ZXJFdGhBZGRyZXNzGAIgASgJUg9vd25lckV0aEFkZHJlc3MaGQoXQW55TmFtZUFsbG9jYXRlUm'
    'VzcG9uc2UanQEKGVN1YnNjcmliZVRvVXBkYXRlc1JlcXVlc3QSFAoFZW1haWwYASABKAlSBWVt'
    'YWlsEjIKCHBsYXRmb3JtGAIgASgOMhYuTWVtYmVyc2hpcFYyLlBsYXRmb3JtUghwbGF0Zm9ybR'
    'IcCglzdWJzY3JpYmUYAyABKAhSCXN1YnNjcmliZRIYCgdjb250ZXh0GAQgASgJUgdjb250ZXh0'
    'GhwKGlN1YnNjcmliZVRvVXBkYXRlc1Jlc3BvbnNlImQKD1BheW1lbnRQcm92aWRlchIICgROb2'
    '5lEAASCgoGU3RyaXBlEAESCgoGQ3J5cHRvEAISEQoNQmlsbGluZ1BvcnRhbBADEgwKCEFwcFN0'
    'b3JlEAQSDgoKR29vZ2xlUGxheRAFIkAKBlBlcmlvZBINCglVbmxpbWl0ZWQQABILCgdNb250aG'
    'x5EAESCgoGWWVhcmx5EAISDgoKVGhyZWVZZWFycxADIk8KCFBsYXRmb3JtEgsKB1Vua25vd24Q'
    'ABILCgdEZXNrdG9wEAESDQoJTW9iaWxlSU9TEAISEQoNTW9iaWxlQW5kcm9pZBADEgcKA1dlYh'
    'AE');
