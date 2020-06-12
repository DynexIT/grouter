// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_request_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalRequestHeaders _$GlobalRequestHeadersFromJson(Map<String, dynamic> json) {
  return GlobalRequestHeaders(
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$GlobalRequestHeadersToJson(
        GlobalRequestHeaders instance) =>
    <String, dynamic>{
      'headers': instance.headers,
    };
