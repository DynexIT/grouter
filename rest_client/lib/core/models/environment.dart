import 'package:json_annotation/json_annotation.dart';

part 'environment.g.dart';

@JsonSerializable()
class Environment{
  String name;
  String color;
  Map<String, String> data;

  Environment({this.name, this.color, this.data});

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}