import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';

import '../widgets/item_widget.dart';

class ItemsViewModel with ChangeNotifier {
  List<ItemWidget> boxItemWidget = List.empty(growable: true);
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

  setItemList(List<Ingredient> itemList) {
    boxItemWidget = List.empty(growable: true);
    _itemList = List.empty(growable: true);

    int i = 0;
    this._itemList = itemList;
    itemList.forEach((element) {
      TextEditingController nameController = TextEditingController();
      TextEditingController rateController = TextEditingController();
      TextEditingController unitController = TextEditingController();

      nameController.text = element.name;
      rateController.text = element.count.toString();
      unitController.text = element.unit;

      boxItemWidget.add(ItemWidget(i++, nameController, rateController, unitController));
      print(nameController.text);
    });
    //notifyListeners();
    //return boxItemWidget;
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

    boxItemWidget.add(
        ItemWidget(boxIndex++, nameController, rateController, unitController));
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
