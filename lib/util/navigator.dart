import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/screen/list_cookery_page.dart';

class AppNavigator {
  
  static void navigateToListScreen(BuildContext context, String search, String kind) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCookeryPage(search, kind)));
  }

  static void navigateToCalculateScreen(BuildContext context, Cookery data) {
    Cookery dataCopy = data.deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: data.key, currCookery: dataCopy, isEditable: false)));
  }

  static void navigateToEditScreen(BuildContext context, int index, Cookery data) {
    Cookery copyData = data.deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: data.key, currCookery: copyData, isEditable: true)));
  }

  static void navigateToNewScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(isEditable: true)));
  }
  
}
