import 'package:flutter/material.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';

class ColumnItemWidget extends StatefulWidget {
  ColumnItemWidget({super.key});

  @override
  State<ColumnItemWidget> createState() => _ColumnItemWidgetState();
}

class _ColumnItemWidgetState extends State<ColumnItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsViewModel>(
        builder: (context, provider, child) => Column(children: <Widget>[
              Column(children: provider.getBoxItems()),
              Row(
                children: <Widget>[
                  SizedBox(
                      child: IconButton(
                    icon: Icon(Icons.add_box_outlined),
                    onPressed: () {
                      provider.addNewWidgetWithController();
                    },
                  ))
                ],
              )
            ]));
  }
}
