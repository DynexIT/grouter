import 'dart:core';
import 'package:hive/hive.dart';

part 'base_environment.g.dart';

@HiveType(typeId: 0)
class CurrentEnvironment{
  @HiveField(0)
  Map<String, dynamic> variables;
  @HiveField(1)
  List<String> environments;
  @HiveField(2)
  String currentEnvironment;

  CurrentEnvironment({this.variables,
    this.environments, this.currentEnvironment});
}