import 'package:json_annotation/json_annotation.dart';
import 'package:rest_client/core/models/request.dart';

part 'endpoint.g.dart';

@JsonSerializable(explicitToJson: true)
class Endpoint{
  String name;
  RequestObject request;

  Endpoint({this.name, this.request});

  factory Endpoint.fromJson(Map<String, dynamic> json) =>
      _$EndpointFromJson(json);

  Map<String, dynamic> toJson() => _$EndpointToJson(this);
}