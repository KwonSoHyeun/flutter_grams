import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeItem {
  String? image;
  String? name;
  String? target;

  HomeItem({
    required this.image,
    required this.name,
    required this.target,
  });

  List<HomeItem> homeItemList = [
    HomeItem(name: "All", image: "assets/photos/dish_all.jpg", target: "all"),
    HomeItem(name: "Main dish", image: "assets/photos/dish_main.jpg", target: "main"),
    HomeItem(name: "Side dish", image: "assets/photos/dish_side.jpg", target: "side"),
    HomeItem(name: "Dessert", image: "assets/photos/dish_cake.jpg", target: "cake"),
    HomeItem(name: "Drint", image: "assets/photos/dish_drint.jpg", target: "drink"),
  ];
}
