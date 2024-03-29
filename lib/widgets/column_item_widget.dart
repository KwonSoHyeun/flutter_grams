import 'package:flutter/material.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:provider/provider.dart';

import 'package:grams/viewmodel/items_viewmodel.dart';

class ColumnItemWidget extends StatefulWidget {

//const ListCookeryPage({super.key, required this.title});
  ColumnItemWidget({super.key});

  @override
  State<ColumnItemWidget> createState() => _ColumnItemWidgetState();
}

class _ColumnItemWidgetState extends State<ColumnItemWidget> {
  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<ItemsViewModel>(context);

    return Column(children: consumer.getBoxItems());
  }
}
