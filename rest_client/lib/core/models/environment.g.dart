// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvironmentObject _$EnvironmentObjectFromJson(Map<String, dynamic> json) {
  return EnvironmentObject(
    name: json['name'] as String,
    color: json['color'] as String,
    data: (json['data'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$EnvironmentObjectToJson(EnvironmentObject instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'data': instance.data,
    };
