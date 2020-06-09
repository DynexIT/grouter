// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_environment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentEnvironmentAdapter extends TypeAdapter<CurrentEnvironment> {
  @override
  final typeId = 0;

  @override
  CurrentEnvironment read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentEnvironment(
      variables: (fields[0] as Map)?.cast<String, dynamic>(),
      environments: (fields[1] as List)?.cast<String>(),
      currentEnvironment: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentEnvironment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.variables)
      ..writeByte(1)
      ..write(obj.environments)
      ..writeByte(2)
      ..write(obj.currentEnvironment);
  }
}
