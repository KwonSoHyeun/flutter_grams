//import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'ingredient.dart';
part 'cookery.g.dart';

@HiveType(typeId: 1)
class Cookery extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String kind;
  @HiveField(2)
  String img;
  @HiveField(3)
  String desc;
  @HiveField(4)
  String caution;
  @HiveField(5)
  bool heart;
  @HiveField(6)
  int hit;
  @HiveField(7)
  List<Ingredient>? ingredients;

  Cookery({
    required this.title,
    required this.kind,
    required this.img,
    required this.desc,
    required this.caution,
    required this.heart,
    required this.hit,
    this.ingredients,
  });

  Cookery deepCopy() =>
      Cookery(title: title, kind: kind, img: img, desc: desc, caution: caution, heart: heart, hit:hit, ingredients: ingredients!.map((e) => e.deepCopy()).toList());

  @override
  String toString() => '{title:$title, kind:$kind, img:$img, desc:$desc, caution:$caution, heart:$heart,hit:$hit, ingredient:$ingredients}';

  String getIngredients() {
    var ret = '';

    if (ingredients != null) {
      for (var item in ingredients!) {
        ret = '$ret${item.name}';
      }
    }
    return ret;
  }
}
