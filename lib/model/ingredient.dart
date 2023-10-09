//import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@HiveType(typeId: 2)
class Ingredient extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int count;
  @HiveField(2)
  String unit;

  Ingredient({
    required this.name,
    required this.count,
    required this.unit,
  });
}