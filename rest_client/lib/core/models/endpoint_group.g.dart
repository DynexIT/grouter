// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndpointGroup _$EndpointGroupFromJson(Map<String, dynamic> json) {
  return EndpointGroup(
    name: json['name'] as String,
    children: (json['children'] as List)
        ?.map((e) =>
            e == null ? null : Endpoint.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EndpointGroupToJson(EndpointGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'children': instance.children?.map((e) => e?.toJson())?.toList(),
    };
