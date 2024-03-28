import 'package:flutter/material.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../viewmodel/items_viewmodel.dart';
import '../widgets/item_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatefulWidget {
  final int index;
  const EditCookeryPage(this.index, {super.key});

  @override
  State<EditCookeryPage> createState() => _EditCookeryPageState();
}

class _EditCookeryPageState extends State<EditCookeryPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final testController = TextEditingController();

  late Cookery editCookery;
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;

  @override
  void initState() {
    print("ksh test");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cookeryViewModel = Provider.of<CookeryViewModel>(context);
    itemsViewModel = Provider.of<ItemsViewModel>(context);

    if (widget.index >= 0) {
      editCookery = cookeryViewModel.getAtIndex(widget.index);
      titleController.text = editCookery.title;
      descController.text = editCookery.desc;

      print("재료의 길이값:" + editCookery.ingredients!.length.toString());
      itemsViewModel.setItemList(editCookery.ingredients!);
    }
  }

  var groupWidgetList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    //final itemConsumer = Provider.of<ItemProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("레시피 입력/수정"),
          actions: [
            Visibility(
              visible: widget.index < 0,
              child: IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Save new data',
                onPressed: () {
                  cookeryViewModel.addCookery(
                      titleController.text, descController.text, null);
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0,
              child: IconButton(
                icon: const Icon(Icons.save_as_sharp),
                tooltip: 'Update data',
                onPressed: () {
                  cookeryViewModel.update(widget.index, titleController.text,
                      descController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
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
                  cookeryViewModel.delete(widget.index);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
        body: Consumer<ItemsViewModel>(
            builder: (_, itemProvider, __) => SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: 50,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text("${itemProvider.getSize().toString()}"),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          controller: titleController,
                          decoration: const InputDecoration(labelText: '요리명'),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller: descController,
                          decoration:
                              const InputDecoration(labelText: '간단한 설명'),
                          keyboardType: TextInputType.text,
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Column(children: itemProvider.getBoxItems()),
                        const SizedBox(
                          width: 60,
                          height: 60,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                            color: Colors.red,
                          )),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                                child: IconButton(
                              icon: Icon(Icons.add_box_outlined),
                              onPressed: () {
                                itemProvider.addNewWidgetWithController();
                                //onAddBoxPress();
                              },
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                )));
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
