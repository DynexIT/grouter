// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestHistory _$RequestHistoryFromJson(Map<String, dynamic> json) {
  return RequestHistory(
    type: json['type'] as String,
    url: json['url'] as String,
    headers: (json['headers'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    result: json['result'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestHistoryToJson(RequestHistory instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'headers': instance.headers,
      'result': instance.result,
    };
