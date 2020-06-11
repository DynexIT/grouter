import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable()
class RequestObject{
  String type;
  String url;
  Map<String, String> headers;
  String body;
  String documentation;
  @JsonKey(name: "variable_opts")
  Map<String, dynamic> variableOpts;

  RequestObject({this.type = "GET", this.url, this.headers, this.body,
    this.documentation, this.variableOpts});

  factory RequestObject.fromJson(Map<String, dynamic> json) =>
      _$RequestObjectFromJson(json);

  Map<String, dynamic> toJson() => _$RequestObjectToJson(this);
}