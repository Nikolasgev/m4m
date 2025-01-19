// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckinModelAdapter extends TypeAdapter<CheckinModel> {
  @override
  final int typeId = 1;

  @override
  CheckinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckinModel(
      mood: fields[0] as String,
      energy: fields[1] as String,
      stress: fields[2] as String,
      notes: fields[3] as String?,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CheckinModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.mood)
      ..writeByte(1)
      ..write(obj.energy)
      ..writeByte(2)
      ..write(obj.stress)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
