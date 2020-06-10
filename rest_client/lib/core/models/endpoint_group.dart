import 'package:json_annotation/json_annotation.dart';
import 'package:rest_client/core/models/endpoint.dart';

part 'endpoint_group.g.dart';

@JsonSerializable(explicitToJson: true)
class EndpointGroup{
  String name;
  List<Endpoint> children;

  EndpointGroup({this.name, this.children});

  factory EndpointGroup.fromJson(Map<String, dynamic> json) =>
      _$EndpointGroupFromJson(json);

  Map<String, dynamic> toJson() => _$EndpointGroupToJson(this);
}