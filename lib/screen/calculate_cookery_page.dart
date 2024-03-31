import 'package:flutter/material.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:grams/widgets/column_item_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../viewmodel/items_viewmodel.dart';
import '../widgets/item_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class CalculateCookeryPage extends StatefulWidget {
  final int index;
  const CalculateCookeryPage(this.index, {super.key});

  @override
  State<CalculateCookeryPage> createState() => _CalculateCookeryPageState();
}

class _CalculateCookeryPageState extends State<CalculateCookeryPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final testController = TextEditingController();

  late Cookery currCookery;
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;

  var groupWidgetList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    cookeryViewModel = Provider.of<CookeryViewModel>(context,
        listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel = Provider.of<ItemsViewModel>(context,
        listen: false); //초기 데이타 기본값을을 널어주기 위함.


    if (widget.index >= 0) {
      //진입시 1회만 수행된다.
      currCookery = cookeryViewModel.getAtIndex(widget.index);
      titleController.text = currCookery.title + ":"+ currCookery.key.toString();
      descController.text = currCookery.desc;

       print("widget.index:" + widget.index.toString());
      if (currCookery.ingredients != null) {
        print("재료의 길이값:" + currCookery.ingredients!.length.toString());
        itemsViewModel.setDataItemList(currCookery.ingredients!);
      } else {
        print("재료의 길이값: null" );
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("레시피 계산"),
          actions: [
          IconButton(
                icon: const Icon(Icons.edit_rounded),
                tooltip: 'Save new data',
                onPressed: () {
                  cookeryViewModel.addCookery(
                      titleController.text, descController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                }
              ),
            
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: 50, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  currCookery.title
                ),
                Text(
                  currCookery.desc
                ),
                const Padding(padding: EdgeInsets.all(10)),
                ColumnItemWidget(),
              ],
            ),
          ),
        ));
  }

}
