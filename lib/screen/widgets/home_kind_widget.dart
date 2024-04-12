import 'package:flutter/material.dart';
import 'package:grams/util/colorvalue.dart';

class HomeKindWidget extends StatelessWidget {
  HomeKindWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //  final consumer = Provider.of<ItemsViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
            width: double.infinity,
            height: 100,
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/photos/dish_all.jpg'), fit: BoxFit.cover)),
                      //child:Text("slkjflskdjf"),

                      child: TextButton(
                          
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 40, color: Colors.white),
                            foregroundColor: Colors.white,
                            backgroundColor: ButtonTextBGColor,
                            shape:BeveledRectangleBorder(),
                          ),
                          onPressed: () {},
                          child: const Text('ALL'))
                          )),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/photos/dish_side.jpg'), fit: BoxFit.fill),
                  )))
            ])),
        Container(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            width: double.infinity,
            height: 100,
           
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/photos/dish_source.jpg'), fit: BoxFit.cover),
                  ))),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/photos/dish_cake.jpg'), fit: BoxFit.cover),
                  )))
            ])),
        Container(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 8),
            width: double.infinity,
            height: 100,
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/photos/dish_drink.jpg'), fit: BoxFit.cover),
                  ))),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/photos/dish_cake.jpg'), fit: BoxFit.cover),
                  )))
            ])),
      ],
    );
  }
}
