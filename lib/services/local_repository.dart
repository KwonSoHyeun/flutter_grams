import 'package:hive/hive.dart';

import '../model/cookery.dart';

const String boxName = 'COOKERY_BOX';

class LocalRepository {

  Future<void> add(Cookery data) async {
    await Hive.box<Cookery>(boxName).add(data);
  }

  List<Cookery> getAll() {
    return Hive.box<Cookery>(boxName).values.toList();
  }

  Cookery? getAtIndex(int index) {
    var item = Hive.box<Cookery>(boxName).getAt(index) ;
    return item;
  }

  Future<void> update(int index, Cookery data) async {
    await Hive.box<Cookery>(boxName).putAt(index, data);
  }

  Future<void> delete(int id) async {
    Hive.box<Cookery>(boxName).deleteAt(id);
  }
}
