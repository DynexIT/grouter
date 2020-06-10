import 'package:json_annotation/json_annotation.dart';

part 'environment.g.dart';

@JsonSerializable()
class EnvironmentObject{
  String name;
  String color;
  Map<String, String> data;

  EnvironmentObject({this.name, this.color, this.data});

  factory EnvironmentObject.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentObjectFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentObjectToJson(this);
}