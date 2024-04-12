import 'package:flutter/material.dart';
import 'package:grams/model/home_item.dart';
import 'package:grams/util/colorvalue.dart';

class HomeKindGridWidget extends StatelessWidget {
  HomeKindGridWidget({super.key});

  late HomeItem item;

  // final List<HomeItem> _items = item!.getHomeItems();

  //final List<HomeItem> _items

  final List<HomeItem> _items = [
    HomeItem(name: "All", image: "assets/photos/dish_all.jpg", target: "all"),
    HomeItem(name: "Main dish", image: "assets/photos/dish_main.jpg", target: "main"),
    HomeItem(name: "Side dish", image: "assets/photos/dish_side.jpg", target: "side"),
    HomeItem(name: "Dessert", image: "assets/photos/dish_cake.jpg", target: "cake"),
    HomeItem(name: "Drint", image: "assets/photos/dish_drint.jpg", target: "drink"),
  ];

  @override
  Widget build(BuildContext context) {
    print(_items[0].name);

    return SizedBox( child:GridView.builder(
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / .3,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) => TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
                foregroundColor: Colors.white,
                backgroundColor: ButtonTextBGColor,
                shape: BeveledRectangleBorder(),
              ),
              onPressed: () {},
              child: Text('${_items[index].target}')) //               //subtitle: Text('Item ${_items[index].target}'),

          ),
    );
  }
}
