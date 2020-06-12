import 'package:json_annotation/json_annotation.dart';

part 'request_history.g.dart';

@JsonSerializable()
class RequestHistory{
  String type;
  String url;
  Map<String, String> headers;
  Map<String, dynamic> result;

  RequestHistory({this.type = "GET", this.url, this.headers, this.result});

  factory RequestHistory.fromJson(Map<String, dynamic> json) =>
      _$RequestHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RequestHistoryToJson(this);
}