// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Endpoint _$EndpointFromJson(Map<String, dynamic> json) {
  return Endpoint(
    name: json['name'] as String,
    request: json['request'] == null
        ? null
        : RequestObject.fromJson(json['request'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EndpointToJson(Endpoint instance) => <String, dynamic>{
      'name': instance.name,
      'request': instance.request?.toJson(),
    };
