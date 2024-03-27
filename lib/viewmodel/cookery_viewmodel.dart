import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/services/hive_cookery_repository.dart';

class CookeryViewModel with ChangeNotifier {
  late final HiveRepository _cookeryRepository;

  List<Cookery> _cookeryList = List.empty(growable: true);
  List<Cookery> get cookeryList => _cookeryList;

  CookeryViewModel() {
    _cookeryRepository = HiveRepository();
    _getCookeryList();
  }

  Future<void> _getCookeryList() async {
    _cookeryList = await _cookeryRepository.getAll();
    notifyListeners();
  }

    List<Cookery> getCookeryList()  {
    _cookeryList =  _cookeryRepository.getAll();
   // notifyListeners();
    return cookeryList;
  }

  Future<void> addCookery(Cookery cookery) async {
    await _cookeryRepository.add(cookery);
   // _cookeryList.add(cookery);
    notifyListeners();
  }

  Future<Cookery> getAtIndex(int index) async {
    Cookery item = _cookeryRepository.getAtIndex(index);
    return item;
  }

  Future<void> update(int index, Cookery data) async {
    _cookeryRepository.update(index, data);
     notifyListeners();
  }

  delete(int index) {
    _cookeryRepository.delete(index);
     notifyListeners();
  }

/*
  static Future<void> add(Cookery cookery) async {
    cookeryBox.add(cookery);
  }
*/
}
