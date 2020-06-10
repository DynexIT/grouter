// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(Map<String, dynamic> json) {
  return Environment(
    name: json['name'] as String,
    color: json['color'] as String,
    data: (json['data'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'data': instance.data,
    };
