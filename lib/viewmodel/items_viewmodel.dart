import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';

import '../widgets/ingrdient_custom_widget.dart';

class ItemsViewModel with ChangeNotifier {
  List<Ingredient> _itemList = List.empty(growable: true);
  List<IngredientCustomWidget> boxItemWidget = List.empty(growable: true);

  int boxIndex = 0;

  List<Ingredient> getItemListAll() {
    return _itemList;
  }

  List<Ingredient> getIngredientList() {
    //저장을 위해서 컨트롤러에 접근하여 재료리스트를 만들어 반환한다.
    List<Ingredient> data = List.empty(growable: true);

    boxItemWidget.forEach((element) {
      data.add(Ingredient(name: element.nameController.text, count: double.parse(element.rateController.text), unit: element.unitController.text));
    });

    return data;
  }

  makeItemWidgetList(List<Ingredient> itemList, bool isEditable) {
    int i = 0;

    if (boxItemWidget.isEmpty){
    _itemList = itemList;
    boxItemWidget.clear();
 
    _itemList.forEach((element) {
      print(element.count);
      
      addNewWidgetWithController(i++, name: element.name, count: element.count, unit: element.unit, isEditable);
    });

    print("makeItemWidgetList called , 위젯길이: " + boxItemWidget.length.toString());
    }
    //notifyListeners(); 
  }

  void addNewWidgetWithController(int index, bool isEditable, {String name = "", double count = 0, String unit = ""}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    nameController.text = name;
    countController.text = count.toStringAsFixed(2);
    unitController.text = unit;

    boxItemWidget.add(IngredientCustomWidget(index, nameController, countController, unitController, isEditable));
  }

//플러스 버튼 눌렀을때 신규 재료 입력 위젯을 추가함.
  void addIngredientWidget() {
    addNewWidgetWithController(boxItemWidget.length, true);
    notifyListeners();
  }

  clearDataItemList() {
    boxItemWidget = List.empty(growable: true);
    boxItemWidget.clear();
    _itemList.clear();
  }

  IngredientCustomWidget getBoxItem(int index) {
    return boxItemWidget[index];
  }

  List<IngredientCustomWidget> getBoxItemWidget() {
    print("boxItemWidget.length : ${boxItemWidget.length}");
    return boxItemWidget;
  }

  int getSize() {
    return boxItemWidget.length;
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
    notifyListeners();
  }

  void _setIngredientName() {
    Ingredient item = Ingredient(name: "", count: 0, unit: "");
    _itemList.add(item);
  }

  bool isListenerEnable = false;

  void reCalculateRate(int index, String val) {
    double changedRate = 0;
    double changedValue = double.parse(val);
    print("reCalculateRate called");

    // if (!isListenerEnable) //!isEditable &&!countController.value.text.isEmpty &&
    //   return;
    //바뀐 비율을 계산하여
    if (changedValue == 0 || _itemList[index].count == null || _itemList[index].count == 0) {
      print("reCalculateRate 수행조건불합");
      return;
    }
    changedRate = (changedValue / _itemList[index].count) as double;
    if (changedRate == 1.00) {
      print("ksh changed Rate: 같은비율 1");
      return;
    }

    //루프를 돌면서 모든 항목값을 계산하여 갱신한후
    print("ksh changed Rate:" + changedRate.toString());

    for (int i = 0; i < boxItemWidget.length; i++) {
      if (i != index) {
        boxItemWidget[i].rateController.text = (_itemList[i].count * changedRate).toStringAsFixed(2);
      }

      _itemList[i].count = _itemList[i].count * changedRate;
    }

    //ui에 반영한다.
    notifyListeners();
  }

  // void clearListener() {
  //   for (int i = 0; i < boxItemWidget.length; i++) {
  //     boxItemWidget[i].rateController.removeListener(() {});
  //   }
  // }
  @override
  void dispose() {
    clearDataItemList();
    super.dispose();
  }
}
