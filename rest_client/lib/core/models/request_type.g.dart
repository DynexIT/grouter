// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestTypeAdapter extends TypeAdapter<RequestType> {
  @override
  final typeId = 3;

  @override
  RequestType read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestType(
      currentRequestType: fields[0] as String,
      requestTypes: (fields[1] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RequestType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currentRequestType)
      ..writeByte(1)
      ..write(obj.requestTypes);
  }
}
