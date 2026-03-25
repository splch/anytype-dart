// This is a generated file - do not edit.
//
// Generated from paymentservice_tiers.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PeriodType extends $pb.ProtobufEnum {
  static const PeriodType PeriodTypeUnknown =
      PeriodType._(0, _omitEnumNames ? '' : 'PeriodTypeUnknown');
  static const PeriodType PeriodTypeUnlimited =
      PeriodType._(1, _omitEnumNames ? '' : 'PeriodTypeUnlimited');
  static const PeriodType PeriodTypeDays =
      PeriodType._(2, _omitEnumNames ? '' : 'PeriodTypeDays');
  static const PeriodType PeriodTypeWeeks =
      PeriodType._(3, _omitEnumNames ? '' : 'PeriodTypeWeeks');
  static const PeriodType PeriodTypeMonths =
      PeriodType._(4, _omitEnumNames ? '' : 'PeriodTypeMonths');
  static const PeriodType PeriodTypeYears =
      PeriodType._(5, _omitEnumNames ? '' : 'PeriodTypeYears');

  static const $core.List<PeriodType> values = <PeriodType>[
    PeriodTypeUnknown,
    PeriodTypeUnlimited,
    PeriodTypeDays,
    PeriodTypeWeeks,
    PeriodTypeMonths,
    PeriodTypeYears,
  ];

  static final $core.List<PeriodType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static PeriodType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PeriodType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
