import 'package:flutter/material.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';

class ItemObservedWidget extends StatefulWidget {
  
  int boxIndex;
  final TextEditingController nameController;
  final TextEditingController rateController;
  final TextEditingController unitController;

  ItemObservedWidget(this.boxIndex, this.nameController, this.rateController,
      this.unitController,
      {super.key});

  @override
  State<ItemObservedWidget> createState() => _ItemObservedWidgetState();
}

class _ItemObservedWidgetState extends State<ItemObservedWidget> {
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

        ]);
  }
}
