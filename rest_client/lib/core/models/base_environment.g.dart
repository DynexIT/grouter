// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEnvironment _$BaseEnvironmentFromJson(Map<String, dynamic> json) {
  return BaseEnvironment(
    variables: (json['variables'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$BaseEnvironmentToJson(BaseEnvironment instance) =>
    <String, dynamic>{
      'variables': instance.variables,
    };
