import 'package:flutter/material.dart';
import 'package:grams/util/colorvalue.dart';

class SelectKindWidget extends StatelessWidget {
 //final VoidCallback callback;
  //final String selectedItem="";
  //SelectKindWidget( this.callback, {Key? key}) : super(key: key);

  final Function(String) callback;
  
  final String init;
  const SelectKindWidget({Key? key, required this.callback, required this.init}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownList = cookingKindList;
    String _init = cookingKindList[0];
    if (!init.isEmpty) {
      _init = init;
    }

    return DropdownButton(
      value: _init, //초기 선택값
      items: dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

      onChanged: (String? value) {
        // 드롭다운의 값을 선택했을 경우
        // setState(() {
        //   dropDownValue = value!;
        //   print(dropDownValue);
        // });
        callback(value!);
      },
    );
  }
}
