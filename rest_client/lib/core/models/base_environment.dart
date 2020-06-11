import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'base_environment.g.dart';

@JsonSerializable()
class BaseEnvironment{
  Map<String, dynamic> variables;

  BaseEnvironment({this.variables});

  factory BaseEnvironment.fromJson(Map<String, dynamic> json) =>
      _$BaseEnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$BaseEnvironmentToJson(this);
}