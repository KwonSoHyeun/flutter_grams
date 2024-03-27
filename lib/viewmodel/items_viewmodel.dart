import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';

import '../widgets/item_widget.dart';

class ItemsViewModel with ChangeNotifier {
  List<ItemWidget> boxItemWidget = List.empty(growable: true);
  final List<Ingredient> _itemList = List.empty(growable: true);

  // List<TextEditingController> nameControllers = [];
  // List<TextEditingController> rateControllers = [];
  // List<TextEditingController> unitControllers = [];

  int boxIndex = 0;

  List<Ingredient> getItemListAll() {
    return _itemList;
  }

  List<ItemWidget> getBoxItems() {
    return boxItemWidget;
  }

   ItemWidget getBoxItem(int index) {
    return boxItemWidget[index];
  }

  int getSize() {
    return boxItemWidget.length;
  }

  void addNewWidgetWithController() {
    TextEditingController nameController = TextEditingController();
    TextEditingController rateController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    // nameControllers.add(nameController);
    // rateControllers.add(rateController);
    // unitControllers.add(unitController);

    boxItemWidget.add(ItemWidget(
        boxIndex++, nameController, rateController, unitController));
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

  void _setIngredientName() async {
    Ingredient item = Ingredient(name: "", count: 0, unit: "");
    _itemList.add(item);
  }
}
