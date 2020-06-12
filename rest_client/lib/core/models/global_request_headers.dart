import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'global_request_headers.g.dart';

@JsonSerializable()
class GlobalRequestHeaders{
  Map<String, String> headers;

  GlobalRequestHeaders({this.headers});

  factory GlobalRequestHeaders.fromJson(Map<String, dynamic> json) =>
      _$GlobalRequestHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalRequestHeadersToJson(this);
}