import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_controller.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';

class CookeryViewModel with ChangeNotifier {
  late final LocalController _cookeryController;
  late Cookery? _currCookery = null;
  //ItemsViewModel items = ItemsViewModel();

  List<Cookery> cookeryList = List.empty(growable: true);
  // List<Cookery> get cookeryList => _cookeryList;

  CookeryViewModel() {
    _cookeryController = LocalController();
    _getCookeryList();
  }

  _getCookeryList() {
    cookeryList = getCookeryList();
    
    notifyListeners();
  }

  setCookeryList({String search=""}){
    cookeryList = _cookeryController.getAll(search: search);
    notifyListeners();
  }

  List<Cookery> getCookeryList({String search=""}) {
    cookeryList = _cookeryController.getAll(search: search);
    return cookeryList;
  }

  setCurrCookery(Cookery? data) {
    data ??= Cookery(title: "", kind:"", img:"", desc: "", caution:"", heart:false, hit:0, ingredients: List.empty(growable: true));
    _currCookery = data;
  }

  clearCurrCookery() {
    _currCookery = null;
  }

  Cookery? getCurrCookery() {
    return _currCookery;
  }

  // Future<void> addCookery(Cookery cookery) async {
  //   await _cookeryController.add(cookery);
  //  // _cookeryList.add(cookery);
  //   notifyListeners();
  // }

  Future<void> addCookery (String title, String kind, String img, String desc, String caution, bool heart, int hit, List<Ingredient>? items) async {
    //await _cookeryController.add(cookery);
    Cookery data = Cookery(title: title, kind: kind, img: img, desc: desc, caution: caution, heart: heart, hit:hit, ingredients: items);
    await _cookeryController.add(data);
    //_getCookeryList();
    //_cookeryList.add(data);
    cookeryList.add(data);
    notifyListeners();
  }

  getAtIndex(int index) {
    //Cookery item = Cookery(title:"test",desc:_cookeryList[index].desc,ingredients:_cookeryList[index].ingredients );
    Cookery item = Cookery(
        title: cookeryList[index].title, kind:cookeryList[index].kind, img: cookeryList[index].img, desc: cookeryList[index].desc, caution: cookeryList[index].caution, heart:cookeryList[index].heart, hit:cookeryList[index].hit, ingredients: cookeryList[index].ingredients);
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

  update(int index, String title, String kind, String img, String desc, String caution, bool heart, int hit, List<Ingredient>? items) {
    Cookery data = Cookery(title: title, kind: kind, img: img, desc: desc, caution: caution, heart: heart, hit:hit, ingredients: items);
    _cookeryController.update(index, data);
    notifyListeners();
  }

  delete(int index) {
    _cookeryController.delete(index);
    notifyListeners();
  }
}
