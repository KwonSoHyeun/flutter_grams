import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_controller.dart';
import 'package:image_picker/image_picker.dart';

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
    print("_getCookeryList()::" + cookeryList.toString());
    notifyListeners();
  }

  setCookeryList({String search = ""}) {
    cookeryList = _cookeryController.getAll(search: search);
    notifyListeners();
  }

  List<Cookery> getCookeryList({String search = ""}) {
    cookeryList = _cookeryController.getAll(search: search);
    return cookeryList;
  }

  setCurrCookery(Cookery? data) {
    data ??= Cookery(title: "", kind: "", img: "", desc: "", caution: "", heart: false, hit: 0, ingredients: List.empty(growable: true));
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

  Future<void> addCookery(String title, String kind, String img, String desc, String caution, bool heart, int hit, List<Ingredient>? items) async {
    //await _cookeryController.add(cookery);

    Cookery data = Cookery(title: title, kind: kind, img: img, desc: desc, caution: caution, heart: heart, hit: hit, ingredients: items);
    await _cookeryController.add(data);

    cookeryList.add(data);
    notifyListeners();
  }

  getAtIndex(int index) {
    //Cookery item = Cookery(title:"test",desc:_cookeryList[index].desc,ingredients:_cookeryList[index].ingredients );
    Cookery item = Cookery(
        title: cookeryList[index].title,
        kind: cookeryList[index].kind,
        img: cookeryList[index].img,
        desc: cookeryList[index].desc,
        caution: cookeryList[index].caution,
        heart: cookeryList[index].heart,
        hit: cookeryList[index].hit,
        ingredients: cookeryList[index].ingredients);
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

  update(String key, String old_img, String title, String kind, String img, String desc, String caution, bool heart, int hit, List<Ingredient>? items) {
    Cookery data = Cookery(title: title, kind: kind, img: img, desc: desc, caution: caution, heart: heart, hit: hit, ingredients: items);

    try {
      if (old_img.isNotEmpty && old_img != img) {
        if (File(old_img).existsSync()) {
          File(old_img).delete();
          print(old_img + " 해당경로 파일 지움");
        }
      }
    } catch (e) {
      print(old_img + " 해당경로 파일 지움 에러발생");
      print(e.toString());
    }

    _cookeryController.update(key, data);
    notifyListeners();
  }

  updateCookeryObject(String key, Cookery data) {
    _cookeryController.update(key, data);
    notifyListeners();
  }

  delete(String key, Cookery data) {
    //이미지 파일 확인 후 제거
    print(data.img + " 해당경로 이미지 ");
    try {
      if (data.img.isNotEmpty) {
        if (File(data.img).existsSync()) {
          File(data.img).delete();
          print(data.img + " 해당경로 파일 지움");
        }
      }
    } catch (e) {
      print(data.img + " 해당경로 파일 지움 에러발생");
      print(e.toString());
    }

    _cookeryController.delete(key);
    notifyListeners();
  }
}
