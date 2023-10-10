import 'package:flutter/material.dart';
import 'package:grams/services/HiveRepository.dart';
import 'package:logger/logger.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../widgets/BoxItems.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookery extends StatefulWidget {
  final int index;

  const EditCookery(this.index, {super.key});

  @override
  State<EditCookery> createState() => _EditCookeryState();
}

class _EditCookeryState extends State<EditCookery> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  late Cookery editCookery;

  @override
  void initState() {
    print("ksh test");
    // TODO: implement initState
    super.initState();
    _openBox();
  }

  Future _openBox() async {
    //await Hive.initFlutter();
    //Hive.registerAdapter(CookeryAdapter());
    //await HiveRepository.openBox();

    if (widget.index >= 0) {
      editCookery = await HiveRepository.getAtIndex(widget.index);
      titleController.text = editCookery.title;
      descController.text = editCookery.desc;
    }
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
    editCookery.title = titleController.text;
    editCookery.desc = descController.text;
    HiveRepository.update(widget.index, editCookery);
    showConfirm(context);
  }

  Future<void> onDeletePress(BuildContext context) async {
    HiveRepository.delete(widget.index);
    showConfirm(context);
  }

  Column someColumn = Column(
    children: [BoxItems(), BoxItems()],
  );

  var groupWidgets = <Widget>[];
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
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '요리명'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: '간단한 설명'),
                keyboardType: TextInputType.text,
              ),
              const Padding(padding: EdgeInsets.all(50)),
              Column(
                children: this.groupWidgets,
              ),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: widget.index < 0,
                    child: Column(
                      children: [
                        TextButton(
                          child: Text("Add item "),
                          onPressed: () {
                            onAddPress();
                          },
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: widget.index >= 0,
                      child: Column(
                        children: [
                          TextButton(
                            child: Text("Delete item "),
                            onPressed: () {
                              onDeletePress(context);
                            },
                          ),
                          TextButton(
                            child: Text("Update item "),
                            onPressed: () {
                              onUpdatePress(context);
                            },
                          ),
                          TextButton(
                            child: Text("test "),
                            onPressed: () {
                              onAddBoxPress();
                            },
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
        ));
  }

  void showConfirm(BuildContext context) {
    if (!mounted) return;
    showDialog(
        context: context,
        barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
        builder: ((context) {
          return AlertDialog(
            title: Text("제목"),
            content: Text('처리 되었습니다.'),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                    Navigator.pop(context);
                  },
                  child: Text("네"),
                ),
              ),
            ],
          );
        }));
  }

  void onAddBoxPress() {
    setState(() {
      this.groupWidgets.add(BoxItems());
    });
  }
}
