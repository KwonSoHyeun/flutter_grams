import 'package:hive/hive.dart';

import '../model/cookery.dart';

const String COOKERY_BOX = 'COOKERY_BOX';

class HiveRepository{

  static late final Box<Cookery> cookeryBox;

  static Future openBox() async{
    cookeryBox = await Hive.openBox<Cookery>(COOKERY_BOX);
  }

  static Future<void> add(Cookery cookery) async{
    cookeryBox.add(cookery);
  }

  static List<Cookery> getAll(){
    return cookeryBox.values.toList();
  }

  static Future<Cookery> getAtIndex(int index) async{
    var item = cookeryBox.getAt(index) as Cookery;
    return item;
  }
}