import 'package:flutter/material.dart';

class BoxIngredientItem extends StatefulWidget {
  final int boxIndex;
  final TextEditingController nameController;
  final TextEditingController rateController;
  final TextEditingController unitController;

  const BoxIngredientItem(this.boxIndex, this.nameController,
      this.rateController, this.unitController,
      {super.key});

  @override
  State<BoxIngredientItem> createState() => _BoxIngredientItemState();
}

class _BoxIngredientItemState extends State<BoxIngredientItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
        // 커스텀 위젯의 내용
        children: [
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(labelText: '재료명'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: widget.rateController,
            decoration: const InputDecoration(labelText: '중량 또는 비율'),
            keyboardType: TextInputType.text,
          ),
          TextField(
            controller: widget.rateController,
            decoration: const InputDecoration(labelText: '단위'),
            keyboardType: TextInputType.text,
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {},
          )
        ]);
  }
}
/*
class _BoxIngredientItemState extends State<BoxIngredientItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 커스텀 위젯의 내용
      child: TextField(
        controller: widget.controller1,
        decoration: const InputDecoration(labelText: '재료명'),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
 */
