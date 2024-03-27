import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/services/local_controller.dart';

class CookeryViewModel with ChangeNotifier {
  late final LocalController _cookeryController;

  List<Cookery> _cookeryList = List.empty(growable: true);
  List<Cookery> get cookeryList => _cookeryList;

  CookeryViewModel() {
    _cookeryController = LocalController();
    _getCookeryList();
  }

   _getCookeryList(){
    _cookeryList =  _cookeryController.getAll();
    notifyListeners();
  }

    List<Cookery> getCookeryList()  { //todo 위에 함수와 기능이 중복인지 확인할것.
    _cookeryList =  _cookeryController.getAll();
   // notifyListeners();
    return cookeryList;
  }

  Future<void> addCookery(Cookery cookery) async {
    await _cookeryController.add(cookery);
   // _cookeryList.add(cookery);
    notifyListeners();
  }

  getAtIndex(int index) {
    Cookery? item = _cookeryController.getAtIndex(index);
    return item;
  }

  update(int index, Cookery data) {
    _cookeryController.update(index, data);
     notifyListeners();
  }

  delete(int index) {
    _cookeryController.delete(index);
     notifyListeners();
  }

}
