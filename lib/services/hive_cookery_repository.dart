import 'package:hive/hive.dart';

import '../model/cookery.dart';

const String COOKERY_BOX = 'COOKERY_BOX';

class HiveRepository {
  static late final Box<Cookery> cookeryBox;

  static Future openBox() async {
    cookeryBox = await Hive.openBox<Cookery>(COOKERY_BOX);
  }

  add(Cookery cookery) {
    cookeryBox.add(cookery);
  }

  List<Cookery> getAll() {
    return cookeryBox.values.toList();
  }

  Cookery getAtIndex(int index) {
    var item = cookeryBox.getAt(index) as Cookery;
    return item;
  }

 update(int index, Cookery data)  {
    cookeryBox.putAt(index, data);
  }

  delete(int index)  {
    cookeryBox.deleteAt(index);
  }
}
