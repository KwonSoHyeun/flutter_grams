//import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'ingredient.dart';
part 'cookery.g.dart';


@HiveType(typeId: 1)
class Cookery extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String desc;
  @HiveField(2)
  List<Ingredient>? ingredients;

// Cookery(String title, String desc, List<Ingredient>? ingredients){
//   this.title = title;
//   this.desc = desc;
//   this.ingredients = ingredients;
// }
  Cookery({
    required this.title,
    required this.desc,
    this.ingredients,
  });

   // Cookery.clone(Cookery cookeryObject : this(cookeryObject.));

  @override
  String toString() => '{title:$title, desc:$desc, ingredient:$ingredients}';

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
