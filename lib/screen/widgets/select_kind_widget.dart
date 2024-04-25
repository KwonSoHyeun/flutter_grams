import 'package:flutter/material.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectKindWidget extends StatelessWidget {
 //final VoidCallback callback;
  //final String selectedItem="";
  //SelectKindWidget( this.callback, {Key? key}) : super(key: key);

  final Function(String) callback;
  
  final String init;
  const SelectKindWidget({Key? key, required this.callback, required this.init}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dropDownList = AppConst.cookingKindList;
    String _init = AppConst.cookingKindList[0];
    if (!init.isEmpty) {
      _init = init;
    }

    return DropdownButton(
      underline: SizedBox(),
      value: _init, //초기 선택값
      items: dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(AppLocalizations.of(context)!.cookType(value)),
        );
      }).toList(),

      onChanged: (String? value) {
        callback(value!);
      },
    );
  }
}
