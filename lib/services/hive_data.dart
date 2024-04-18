
import 'package:grams/model/cookery.dart';
import 'package:grams/model/ingredient.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'local_repository.dart';
/*
  await Hive.initFlutter();
  Hive.registerAdapter(CookeryAdapter());
  Hive.registerAdapter(IngredientAdapter());
  await Hive.openBox<Cookery>("COOKERY_BOX");
*/
class HiveData {
  
  static init() async {
    final appDocDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    Hive.registerAdapter(CookeryAdapter());
    Hive.registerAdapter(IngredientAdapter());

    await Hive.openBox<Cookery>(boxName);
  }
}