import 'package:flutter/material.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';


class ColumnItemWidget extends StatelessWidget {
  final bool isEditable;
  const ColumnItemWidget( this.isEditable, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsViewModel>(
        builder: (context, provider, child) => Column(children: <Widget>[
              Column(children: provider.getBoxItems()),
              Visibility(
                visible: isEditable,
                child: Row(
                children: <Widget>[
                  SizedBox(
                      child: IconButton(
                    icon: Icon(Icons.add_box_outlined),
                    onPressed: () {
                      provider.addIngredientWidget();
                    },
                  ))
                ],
              ))
              
            ]));
  }
}
