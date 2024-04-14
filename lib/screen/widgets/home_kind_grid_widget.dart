import 'package:flutter/material.dart';
import 'package:grams/model/home_item.dart';
import 'package:grams/screen/list_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';

class HomeKindGridWidget extends StatelessWidget {
  HomeKindGridWidget({super.key});

  late HomeItem item;

  // final List<HomeItem> _items = item!.getHomeItems();

  //final List<HomeItem> _items
// ['Main dish', 'Side dish', 'Dressing', 'Drink', 'Dessert', 'etc.'];
  final List<HomeItem> _items = [
    HomeItem(name: "Main dish", image: "assets/photos/dish_main.jpg", target: "main"),
    HomeItem(name: "Side dish", image: "assets/photos/dish_side.jpg", target: "side"),
    HomeItem(name: "Sauce", image: "assets/photos/dish_sauce.jpg", target: "sauce"),
    HomeItem(name: "Drink", image: "assets/photos/dish_drink.jpg", target: "drink"),
    HomeItem(name: "Dessert", image: "assets/photos/dish_dessert.jpg", target: "dessert"),
    HomeItem(name: "ETC.", image: "assets/photos/dish_etc.jpg", target: "etc"),
  ];

  @override
  Widget build(BuildContext context) {
    print(_items[0].name);

    return SizedBox(
        child: DecoratedBox(
      decoration: BoxDecoration(color: primaryColor),
      child: GridView.builder(
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1 / .3,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 24, 24),
                image: DecorationImage(
                    image: AssetImage(_items[index].image!),
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover),
              ),
              child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    shape: BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCookeryPage("","")));
                  },
                  child: Text('${_items[index].name!.toUpperCase()}')) //               //subtitle: Text('Item ${_items[index].target}'),

              )),
    ));
  }
}
