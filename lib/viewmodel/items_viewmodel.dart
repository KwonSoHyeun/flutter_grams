import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';

import '../widgets/item_widget.dart';

class ItemsViewModel with ChangeNotifier {
  List<IngredientCustomWidget> boxItemWidget = List.empty(growable: true);
  List<Ingredient> _itemList = List.empty(growable: true);

  int boxIndex = 0;

  List<Ingredient> getItemListAll() {
    return _itemList;
  }

  List<Ingredient> getIngredientList() {
    List<Ingredient> data = List.empty(growable: true);

    boxItemWidget.forEach((element) {
      data.add(Ingredient(
          name: element.nameController.text,
          count: int.parse(element.rateController.text),
          unit: element.unitController.text));

      print(element.nameController.text);
    });

    return data;
  }

  setDataItemList(List<Ingredient> itemList) {
    clearDataItemList();

    int i = 0;
    _itemList = List.from(itemList);
    _itemList.forEach((element) {
      addNewWidgetWithController(i++,
          name: element.name, rate: element.count, unit: element.unit);
    });
  }

  clearDataItemList() {
    boxItemWidget.clear();
    _itemList.clear();
  }

  List<IngredientCustomWidget> getBoxItems() {
    return boxItemWidget;
  }

  IngredientCustomWidget getBoxItem(int index) {
    return boxItemWidget[index];
  }

  int getSize() {
    return boxItemWidget.length;
  }

  void addNewWidgetWithController(int index,
      {String name = "", int rate = 0, String unit = ""}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController rateController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    nameController.text = name;
    rateController.text = rate.toString();
    unitController.text = unit;

    boxItemWidget.add(IngredientCustomWidget(
        index, nameController, rateController, unitController, false));
  }

  void addIngredientWidget() {
    addNewWidgetWithController(boxItemWidget.length);
    notifyListeners();
  }

  void addIngredientEmpty() {
    Ingredient item = Ingredient(name: "", count: 0, unit: "");
    _itemList.add(item);
    notifyListeners();
  }

  void removeIngredientItem(int index) {
    boxItemWidget.removeAt(index);
    for (int i = index; i < boxItemWidget.length; i++) {
      boxItemWidget[i].boxIndex--;
    }

    --boxIndex;
    print("ksh index" + index.toString());
    notifyListeners();
  }

  void _setIngredientName() {
    Ingredient item = Ingredient(name: "", count: 0, unit: "");
    _itemList.add(item);
  }
}
