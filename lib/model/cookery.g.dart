// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookery.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CookeryAdapter extends TypeAdapter<Cookery> {
  @override
  final int typeId = 1;

  @override
  Cookery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cookery(
      title: fields[0] as String,
      desc: fields[1] as String,
      ingredients: (fields[2] as HiveList?)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Cookery obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookeryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
