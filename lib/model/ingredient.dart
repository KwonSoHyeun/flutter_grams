import 'package:hive/hive.dart';
part 'ingredient.g.dart';

@HiveType(typeId: 2) 
class Ingredient extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  double count;
  @HiveField(2)
  String unit;
  @HiveField(3)
  bool isdesc;

  Ingredient({
    required this.name,
    required this.count,
    required this.unit,
    this.isdesc = false
  });


  @override
  String toString() => '{name:$name, count:$count, unit:$unit, isdesc:$isdesc}';

  Ingredient deepCopy() => Ingredient(name: name, count: count, unit: unit, isdesc: isdesc);
}