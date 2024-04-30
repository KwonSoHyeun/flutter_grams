import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';
import 'package:intl/intl.dart';

import '../screen/widgets/ingrdient_custom_widget.dart';

class ItemsViewModel with ChangeNotifier {
  var f = NumberFormat("0.##");

  var log_i = 0;

  List<Ingredient> _itemList = List.empty(growable: true); // 현재 ingredient 목록값인데, 변경될수 있다. 왜냐하면 비율을 여러번 변경시 rate 계산의 기준값이 필요하기 때문.
  List<IngredientCustomWidget> boxItemWidget = List.empty(growable: true); //UI 위젯 목록값
  int boxIndex = 0;

  List<Ingredient> getIngredientList() {
    //저장을 위해서 컨트롤러에 접근하여 재료리스트를 만들어 반환한다.
    List<Ingredient> data = List.empty(growable: true);

    boxItemWidget.forEach((element) {
      if (element.rateController.text.isEmpty) element.rateController.text = "0";
      data.add(Ingredient(name: element.nameController.text, count: double.parse(element.rateController.text), unit: element.unitController.text));
    });
    return data;
  }

  initItemWidgetList(List<Ingredient> itemList, bool isEditable) {
    int i = 0;

    clearDataItemList();
    _itemList = itemList;

    _itemList.forEach((element) {
      addNewWidgetWithController(i++, name: element.name, count: element.count, unit: element.unit, isEditable);
    });
  }

  void addNewWidgetWithController(int index, bool isEditable, {String name = "", double count = 0, String unit = ""}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    nameController.text = name;
    countController.text = f.format(count);
    unitController.text = unit;

    countController.addListener(() {
      //print("value " + rateController.value.toString());
      if (!isEditable && isListenerEnable) {
        reCalculateRate(index, countController.value.text);
      }
    });

    boxItemWidget.add(IngredientCustomWidget(index, nameController, countController, unitController, isEditable));
  }

//플러스 버튼 눌렀을때 신규 재료 입력 위젯을 추가함.
  void addIngredientWidget() {
    addNewWidgetWithController(boxItemWidget.length, true);
    notifyListeners();
  }

  void defaultIngredientWidget() {
    clearDataItemList();
    addNewWidgetWithController(0, true);
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
    return boxItemWidget;
  }

  int getSize() {
    return boxItemWidget.length;
  }

  void removeIngredientItem(int index) {
    boxItemWidget.removeAt(index);
    for (int i = index; i < boxItemWidget.length; i++) {
      boxItemWidget[i].boxIndex--;
    }
    --boxIndex;
    notifyListeners();
  }

  bool isListenerEnable = true;

  void reCalculateRate(int index, String val) {
    print("reCalculate call with index:" + index.toString() + ": val:" + val);
    double changedRate = 0;
    double changedValue = 0;

    if (!val.isEmpty) {
      try {
        changedValue = double.parse(val);
      } catch (e) {
        print("KSH error1");
        return;
      }

      isListenerEnable = false;
      changedRate = (changedValue / _itemList[index].count) as double;
      //print("log_i" + (log_i++).toString());

      for (int i = 0; i < boxItemWidget.length; i++) {
        if (i != index) {
          boxItemWidget[i].rateController.text = f.format(_itemList[i].count * changedRate);
        }
      }
    } else {
      print("!!! val is empty");
      for (int i = 0; i < boxItemWidget.length; i++) {
        if (i != index) {
          boxItemWidget[i].rateController.text = "";
        }
      }
    }

    notifyListeners();
    isListenerEnable = true;
  }
}
