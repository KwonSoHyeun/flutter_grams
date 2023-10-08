import 'package:hive/hive.dart';

import '../model/cookery.dart';

const String COOKERY_BOX = 'COOKERY_BOX';

class HiveRepository{

  static Box<Cookery>? cookeryBox;

  static Future openBox() async{
    cookeryBox = await Hive.openBox(COOKERY_BOX);
  }
}