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

    return GridView.builder(
      shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1/2,
              /*
              MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
              */
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8),
          elevation: 8,
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Colors.black26,
              title: const Text('header'),
              //subtitle: Text('Item ${_items[index].target}'),
              subtitle: Text('subHeader'),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black38,
              title: const Text('footer'),
              subtitle: Text('Item'),
            ),
            child: Center(
              child: Text(
                _items[index].name.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      );
  }
}
