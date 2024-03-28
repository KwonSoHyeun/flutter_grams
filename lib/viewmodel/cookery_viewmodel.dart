import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_controller.dart';

class CookeryViewModel with ChangeNotifier {
  late final LocalController _cookeryController;

  List<Cookery> _cookeryList = List.empty(growable: true);
  List<Cookery> get cookeryList => _cookeryList;
  late Cookery _currentData ;

  CookeryViewModel() {
    _cookeryController = LocalController();
    _getCookeryList();
  }

  _getCookeryList() {
    _cookeryList = _cookeryController.getAll();
    notifyListeners();
  }

  void setCurrentCookery(Cookery data){
    _currentData = data;
  }

  Cookery getCurrentCookery(){
    return _currentData;
  }

  List<Cookery> getCookeryList() {
    //todo 위에 함수와 기능이 중복인지 확인할것.
    _cookeryList = _cookeryController.getAll();
    // notifyListeners();
    return cookeryList;
  }

  Future<void> addCookery(String title, String desc, List<Ingredient>? items) async{
    Cookery data = Cookery(title:title, desc:desc, ingredients:items) ;
    await _cookeryController.add(data);
    notifyListeners();
  }

  getAtIndex(int index) {
    Cookery? item = _cookeryController.getAtIndex(index);
    return item;
  }

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
