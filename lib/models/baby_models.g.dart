// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BabyAdapter extends TypeAdapter<Baby> {
  @override
  final int typeId = 1;

  @override
  Baby read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Baby(
      time: fields[0] as DateTime,
      note: fields[1] as String?,
      weight: fields[2] as int,
      height: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Baby obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BabyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
