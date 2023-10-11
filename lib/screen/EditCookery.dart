import 'package:flutter/material.dart';
import 'package:grams/services/HiveRepository.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../services/ItemProvider.dart';
import '../widgets/BoxIngredientItems.dart';

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
  final testController = TextEditingController();

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

  void getListIngredient() {}

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

  var groupWidgetList = <Widget>[];

  // List<Widget> getWidgets() {
  //   //logger.i(set.elementAt(0));
  //   logger.i("변경감지!!");
  //   return groupWidgetList;
  // }

  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<ItemProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("레시피 입력/수정"),
          actions: [
            Visibility(
              visible: widget.index < 0,
              child: IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  onAddPress();
                  // handle the press
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0,
              child: IconButton(
                icon: const Icon(Icons.save_as_sharp),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  onUpdatePress(context); // handle the press
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
                tooltip: 'Open shopping cart',
                onPressed: () {
                  onDeletePress(context); // handle the press
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 50, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text("${consumer.getSize().toString()}"),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  controller: titleController,
                  decoration: const InputDecoration(labelText: '요리명'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: '간단한 설명'),
                  keyboardType: TextInputType.text,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Column(children: consumer.getBoxItems()),
                const SizedBox(
                  width: 60,
                  height: 60,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                        child: IconButton(
                      icon: Icon(Icons.add_box_outlined),
                      onPressed: () {
                        consumer.addNewWidgetWithController();
                        //onAddBoxPress();
                      },
                    ))
                  ],
                )
              ],
            ),
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

  List<TextEditingController> nameControllers = [];
  List<TextEditingController> rateControllers = [];
  List<TextEditingController> unitControllers = [];

  int boxIndex = 0;

  void onAddBoxPress() {
    logger.d("add ingredient1");
    TextEditingController nameController = TextEditingController();
    TextEditingController rateController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    nameControllers.add(nameController);
    rateControllers.add(rateController);
    unitControllers.add(unitController);

    boxIndex++;

    setState(() {
      this.groupWidgetList.add(BoxIngredientItem(
          boxIndex, nameController, rateController, unitController));
    });
  }
}
