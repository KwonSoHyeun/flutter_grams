import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';

class IngredientCustomWidget extends StatefulWidget {

  int boxIndex;
  final TextEditingController nameController;
  final TextEditingController rateController;
  final TextEditingController unitController;
  final bool isObserbed; //위젯값 변경을 감시당하고 있는가?

  IngredientCustomWidget(this.boxIndex, this.nameController, this.rateController,
      this.unitController, this.isObserbed,
      {super.key});

  @override
  State<IngredientCustomWidget> createState() => _IngredientCustomWidgetState();
}

class _IngredientCustomWidgetState extends State<IngredientCustomWidget> {
  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<ItemsViewModel>(context);

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // 커스텀 위젯의 내용
        children: [
          Flexible(
            child: Container(
              height: 50,
              child: TextFormField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: widget.nameController,
                decoration: const InputDecoration(labelText: '재료명'),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 60,
          ),
          Flexible(
            child: Container(
              height: 50,
              child: TextField(
                controller: widget.rateController,
                decoration: const InputDecoration(labelText: '중량 또는 비율'),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
            height: 60,
          ),
          Container(
            width: 60,
            height: 50,
            child: TextField(
              controller: widget.unitController,
              decoration: const InputDecoration(labelText: '단위'),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(
              child: IconButton(
            icon: Icon(Icons.backspace_rounded),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                builder: ((context) {
                  return AlertDialog(
                    title: Text("제목"),
                    content: Text(widget.boxIndex.toString()),
                    actions: <Widget>[
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            consumer.removeIngredientItem(widget.boxIndex);
                            Navigator.of(context).pop(); //창 닫기
                          },
                          child: Text("네"),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ))
        ]);
  }
}
