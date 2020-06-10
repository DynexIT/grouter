// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestObject _$RequestObjectFromJson(Map<String, dynamic> json) {
  return RequestObject(
    type: json['type'] as String,
    url: json['url'] as String,
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    documentation: json['documentation'] as String,
    variableOpts: json['variable_opts'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestObjectToJson(RequestObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'headers': instance.headers,
      'documentation': instance.documentation,
      'variable_opts': instance.variableOpts,
    };
