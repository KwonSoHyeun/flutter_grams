import 'package:flutter/material.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../viewmodel/items_viewmodel.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatefulWidget {
  final int index;
  final Cookery? currCookery;
  final bool isEditable;

  //EditCookeryPage(this.index, this.currCookery, this.isEditable, [Cookery? currcookery]);
  EditCookeryPage({this.index=-1, this.currCookery,  this.isEditable=true});

  @override
  State<EditCookeryPage> createState() => _EditCookeryPageState();
}

class _EditCookeryPageState extends State<EditCookeryPage> {
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;
  late Cookery? _currCookery;

  final titleController = TextEditingController();
  final descController = TextEditingController();

   @override
  void initState() {
    super.initState();
    _currCookery = widget.currCookery;
    if (_currCookery !=null){
    titleController.text = _currCookery!.title;
    descController.text = _currCookery!.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    cookeryViewModel = Provider.of<CookeryViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel = Provider.of<ItemsViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.

     if (widget.currCookery !=null && widget.currCookery?.ingredients != null) {
    //   logger.i("재료의 배열 갯수:" + widget.currCookery.ingredients!.length.toString() + " :: " + widget.currCookery.ingredients![0].count.toString());
       //itemsViewModel.makeItemWidgetList(widget.currCookery.ingredients!, widget.isEditable);
       itemsViewModel.makeItemWidgetList(_currCookery!.ingredients!, widget.isEditable);
    // } else {
    //   print("재료의 길이값: 없음");
     }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("레시피 입력/수정"),
          actions: [
            Visibility(
              visible: widget.index < 0 && widget.isEditable,
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
              visible: widget.index >= 0 && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save_as_sharp),
                tooltip: 'Update data',
                onPressed: () {
                  cookeryViewModel.update(widget.index, titleController.text, descController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0 && widget.isEditable,
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
                TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: '간단한 설명'),
                  keyboardType: TextInputType.text,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Column(children: itemsViewModel.getBoxItemWidget()),
                Visibility(
                    visible: widget.isEditable,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                            child: IconButton(
                          icon: Icon(Icons.add_box_outlined),
                          onPressed: () {
                            itemsViewModel.addIngredientWidget();
                          },
                        ))
                      ],
                    ))
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


  @override
  void deactivate() {
    print("edit page dispose 불림");
    Provider.of<CookeryViewModel>(context, listen: false).clearCurrCookery();
    Provider.of<ItemsViewModel>(context, listen: false).clearDataItemList();
    //_currCookery = null;
    super.deactivate();
  }
}
