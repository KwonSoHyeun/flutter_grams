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
      kind: fields[1] as String,
      img: fields[2] as String,
      desc: fields[3] as String,
      caution: fields[4] as String,
      heart: fields[5] as bool,
      hit: fields[6] as int,
      ingredients: (fields[7] as List?)?.cast<Ingredient>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cookery obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.kind)
      ..writeByte(2)
      ..write(obj.img)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.caution)
      ..writeByte(5)
      ..write(obj.heart)
      ..writeByte(6)
      ..write(obj.hit)
      ..writeByte(7)
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
