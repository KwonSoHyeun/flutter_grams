import 'package:hive/hive.dart';

import '../model/cookery.dart';

const String boxName = 'COOKERY_BOX';

class Boxes{
  static Box<Cookery> getTask() => Hive.box<Cookery>(boxName);
}

class LocalRepository {
  static Box userBox = Boxes.getTask();

  Future<void> add(Cookery data) async {
    String   key = DateTime.now().millisecondsSinceEpoch.toString();
    await userBox.put(key, data);
  }

  List<Cookery> getAll() {
    return  userBox.values.toList() as List<Cookery>;
  }

  Cookery? getAtIndex(int index) {
    Cookery? item = userBox.getAt(index) ;
    return item;
  }

  Future<void> update(String key, Cookery data) async {
    await userBox.put(key, data);
  }

  Future<void> delete(String key) async {
    userBox.delete(key);
  }
}
