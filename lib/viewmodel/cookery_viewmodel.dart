import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_controller.dart';

class CookeryViewModel with ChangeNotifier {
  late final LocalController _cookeryController;

  List<Cookery> _cookeryList = List.empty(growable: true);
 // List<Cookery> get cookeryList => _cookeryList;

  CookeryViewModel() {
    _cookeryController = LocalController();
    _getCookeryList();
  }

  _getCookeryList() {
    _cookeryList = getCookeryList();
    notifyListeners();
  }

  List<Cookery> getCookeryList() {
    _cookeryList = _cookeryController.getAll();
    // notifyListeners();
    return _cookeryList;
  }

  // Future<void> addCookery(Cookery cookery) async {
  //   await _cookeryController.add(cookery);
  //  // _cookeryList.add(cookery);
  //   notifyListeners();
  // }

  Future<void> addCookery(String title, String desc, List<Ingredient>? items) async{
    //await _cookeryController.add(cookery);
    Cookery data = Cookery(title:title, desc:desc, ingredients:items) ;
    await _cookeryController.add(data);
   //_cookeryList.add(data);
    notifyListeners();
  }

  getAtIndex(int index) {
    //Cookery item = Cookery(title:"test",desc:_cookeryList[index].desc,ingredients:_cookeryList[index].ingredients );
    Cookery item = Cookery(title:_cookeryList[index].title,desc:_cookeryList[index].desc,ingredients:_cookeryList[index].ingredients );
    return item;
  }

  //   getAtIndexDeepCopy(int index) {
  //   Cookery newItem;  
  //   Cookery item = Cookery(title:_cookeryList[index].title,desc:_cookeryList[index].desc,ingredients:_cookeryList[index].ingredients );
  //   newItem = item.
  //   return item;
  // }

  // getAtIndex(int index) {
  //   Cookery? item = _cookeryController.getAtIndex(index);
  //   return item;
  // }

  update(int index, String title, String desc, List<Ingredient>? items) {
    Cookery data = Cookery(title:title, desc:desc, ingredients:items) ;
    _cookeryController.update(index, data);
    notifyListeners();
  }

  delete(int index) {
    _cookeryController.delete(index);
    notifyListeners();
  }
}
