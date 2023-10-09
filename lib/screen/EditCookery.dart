import 'package:flutter/material.dart';
import 'package:grams/services/HiveRepository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/cookery.dart';
import '../model/ingredient.dart';

class EditCookery extends StatefulWidget {
  @override
  _EditCookeryState createState() => _EditCookeryState();
}

class _EditCookeryState extends State<EditCookery> {
  //late HiveRepository _personBox;

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
    Cookery personModel =
        Cookery(title: "title1", desc: "aaaaa", ingredients: null);
    await HiveRepository.add(personModel);
  }

  Future<void> onUpdatePress(BuildContext context) async{
    Cookery item = await HiveRepository.getAtIndex(0);
    if(!mounted) return;
    showDialog(
        context: context,
        barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
        builder: ((context) {
          return AlertDialog(
            title: Text("제목"),
            content: Text(item.title + item.desc),
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
        title: Text("Hive example"),
      ),
      body: Column(
        children: <Widget>[
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
    );
  }
}
