import 'package:flutter/material.dart';
import 'package:grams/services/HiveRepository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';

class EditCookery extends StatefulWidget {
  const EditCookery({super.key});

  @override
  State<EditCookery> createState() => _EditCookeryState();
}

class _EditCookeryState extends State<EditCookery> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openBox();
  }

  Future _openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CookeryAdapter());
    await HiveRepository.openBox();
    return;
  }

  Future<void> onAddPress() async {
    Ingredient ing = Ingredient(name: "name", count: 1, unit: "gram");
    Cookery personModel = Cookery(
        title: titleController.text,
        desc: descController.text,
        ingredients: null);
    await HiveRepository.add(personModel);
  }

  Future<void> onUpdatePress(BuildContext context) async {
    Cookery item = await HiveRepository.getAtIndex(1);
    int size = await HiveRepository.getAll().length;
    if (!mounted) return;
    showDialog(
        context: context,
        barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
        builder: ((context) {
          return AlertDialog(
            title: Text("제목"),
            content: Text(item.title + item.desc + " size:" + size.toString()),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                  },
                  child: Text("네"),
                ),
              ),
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("레시피 입력/수정"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: '요리명'),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: '간단한 설명'),
                    keyboardType: TextInputType.text,
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.all(50)),
              Row(
                children: <Widget>[
                  TextButton(
                    child: Text("Add item "),
                    onPressed: () {
                      onAddPress();
                    },
                  ),
                  TextButton(
                    child: Text("Delete item "),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text("Update item "),
                    onPressed: () {
                      onUpdatePress(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
