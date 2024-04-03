import 'package:flutter/material.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';

import 'package:grams/widgets/column_item_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../viewmodel/items_viewmodel.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatelessWidget {
  final int index;
  final bool isEditable;
  EditCookeryPage(this.index, this.isEditable, {super.key});

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final testController = TextEditingController();

  late Cookery currCookery;
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;

  var groupWidgetList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    cookeryViewModel = Provider.of<CookeryViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel = Provider.of<ItemsViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.

    // print("isEditable1:" + isEditable.toString());
    itemsViewModel.clearDataItemList();
    if (index >= 0) {
      //초기값을 보여줘햐는 경우이다.
      currCookery = cookeryViewModel.getAtIndex(index);
      titleController.text = currCookery.title + ":" + currCookery.key.toString();
      descController.text = currCookery.desc;

      if (currCookery.ingredients != null) {
        logger.i("재료의 배열 갯수:" + currCookery.ingredients!.length.toString() + " //// " + currCookery.ingredients![0].count.toString());
        itemsViewModel.makeItemWidgetList(currCookery.ingredients!, isEditable);
      } else {
        print("재료의 길이값: 없음");
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("레시피 입력/수정"),
          actions: [
            Visibility(
              visible: index < 0 && isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Save new data',
                onPressed: () {
                  cookeryViewModel.addCookery(titleController.text, descController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: index >= 0 && isEditable,
              child: IconButton(
                icon: const Icon(Icons.save_as_sharp),
                tooltip: 'Update data',
                onPressed: () {
                  cookeryViewModel.update(index, titleController.text, descController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: index >= 0 && isEditable,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
                tooltip: 'Open shopping cart',
                onPressed: () {
                  cookeryViewModel.delete(index);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                ColumnItemWidget(isEditable),
              ],
            ),
          ),
        ));
  }

  void showConfirm(BuildContext context) {
    // if (!mounted) return;
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
}
