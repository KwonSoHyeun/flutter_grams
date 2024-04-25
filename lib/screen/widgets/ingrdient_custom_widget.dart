import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IngredientCustomWidget extends StatelessWidget {
  IngredientCustomWidget(this.boxIndex, this.nameController, this.rateController, this.unitController, this.isEditable, {super.key});

  int boxIndex;
  final TextEditingController nameController;
  final TextEditingController rateController;
  final TextEditingController unitController;
  final bool isEditable; //위젯값 변경을 감시당하고 있는가?

  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<ItemsViewModel>(context);

    return Row(

        // 커스텀 위젯의 내용
        children: [
          Flexible(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              //color: Colors.amber,
              height: 50,
              width: double.infinity,
              child: isEditable
                  ? TextFormField(
                      // enabled: isEditable,
                      readOnly: !isEditable,
                      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      controller: nameController,
                      decoration: InputDecoration(
                          // labelText: AppLocalizations.of(context)!.hint_ingredient_title,
                          // labelStyle: TextStyle(fontSize: 14),
                          enabledBorder: UnderlineInputBorder(borderSide: isEditable ? BorderSide(width: 1) : BorderSide.none)),
                      keyboardType: TextInputType.text,
                    )
                  : Text(nameController.text, style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 60,
          ),
          Flexible(
            flex: 6,
            child: Container(
              height: 50,
              child: TextField(
                maxLines: 1,
                controller: rateController,
                // decoration: InputDecoration(
                // labelText: AppLocalizations.of(context)!.hint_ingredient_rate, 
                // labelStyle: TextStyle(fontSize: 14)),
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter(
                    RegExp('[0-9 | .]'),
                    allow: true,
                  )
                ],
                onTap: () => rateController.selection = TextSelection(baseOffset: 0, extentOffset: rateController.value.text.length),

                onSubmitted: (String val) {
                  if (!isEditable) consumer.reCalculateRate(boxIndex, val);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 60,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: 60,
            height: 50,
            child: isEditable
                ? TextField(
                    readOnly: !isEditable,
                    controller: unitController,
                    decoration: InputDecoration(
                       // labelText: AppLocalizations.of(context)!.hint_ingredient_unit,
                       // labelStyle: TextStyle(fontSize: 14),
                        enabledBorder: UnderlineInputBorder(borderSide: isEditable ? BorderSide(width: 1) : BorderSide.none)),
                    keyboardType: TextInputType.text,
                  )
                : Text(unitController.text, style: TextStyle(fontSize: 14)),
          ),
          Visibility(
              visible: isEditable,
              child: SizedBox(
                  child: IconButton(
                icon: Icon(Icons.backspace_rounded),
                color: Colors.red.shade400,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.dialog_msg_delete_confirm),
                      content: Text(AppLocalizations.of(context)!.dialog_msg_delete),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              consumer.removeIngredientItem(boxIndex);
                              Navigator.of(context).pop();
                              //Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.dialog_button_ok)),
                        ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.dialog_button_cancel)),
                      ],
                    ),
                  );

                },
              )))
        ]);
  }
}
