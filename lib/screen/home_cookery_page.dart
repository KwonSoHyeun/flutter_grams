import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/screen/list_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';

//import 'package:flutter_localizations/flutter_localizations.dart'; // Add this line
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  HomeCookeryPage({super.key});
  String _search_value = "";
  List<Cookery> favoriteList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgHome,
      // appBar: AppBar(
      //   title: const Text("CookGram"),
      // ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          //cookeryList = provider.cookeryList;
          cookeryList = provider.getCookeryList();
          favoriteList = cookeryList.where((element) {
            return element.heart == true;
          }).toList();

          return SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              height: 1.0,
              width: 500.0,
              color: AppColor.lineColor2,
            ),
            Container(
                //height: 150,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 8),
                alignment: Alignment(0.0, 0.0),
                decoration: const BoxDecoration(
                  color: AppColor.bgHomeTitle,
                ),
                child: Column(children: <Widget>[
                  Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppLocalizations.of(context)!.app_title,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, fontFamily: 'palatino', color: AppColor.textHome1), //Color(0xff303C7B)
                      ),
                      Text(
                        AppLocalizations.of(context)!.app_sub_title,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'palatino', color: AppColor.primaryTextColor), //Color(0xff303C7B)
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  _searchWidget(context),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_all),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "main");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_main),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "side");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_side),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "sauce");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_sauce),
                    ),
                  ]),
                  Row(children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "dessert");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_dessert),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "drink");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_drink),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "etc");
                      },
                      child: Text(AppLocalizations.of(context)!.kind_etc),
                    ),
                    Spacer(),
                  ]),
                ])),
            Container(
              height: 1.0,
              width: 500.0,
              color: AppColor.lineColor2,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.favorite, color: AppColor.AccentColor), SizedBox(width: 4), Text(AppLocalizations.of(context)!.title_myfavorite)])),
            Expanded(
                child: ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: const EdgeInsets.all(10), child: BigCard(context, favoriteList[index]));
                    }))
          ]));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNewScreen(context, -1);
        },
        tooltip: 'New Receipy',
        child: const Icon(Icons.add),
        backgroundColor: AppColor.primaryButtonColor, //#EDDBD0
        foregroundColor: AppColor.textHome1,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Card BigCard(BuildContext context, Cookery data) {
    XFile? _image;
    String _imageFilePath = "";
    late FileImage fileImage;
    print("ksh1");

    try {
      if (data.img.isNotEmpty) {
        _imageFilePath = data.img;
        _image = XFile(_imageFilePath); //가져온 이미지를 _image에 저장
        fileImage = FileImage(File(_image!.path));
        if (!File(_image!.path).existsSync()) {
          _imageFilePath = "";
        }
      }
    } catch (e) {
      _imageFilePath = "";
      print(e.toString());
    }
    print("ksh2");

    return Card(
      color: Color(0xffF9F1E7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
          onTap: () {
            print("list_page: card on press : key:" + data.key.toString());
            _navigateToCalculateScreen(context, data);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add an image widget to display an image
                    Visibility(
                      visible: true,
                      //child: PhotoAreaWidget(_image),
                      child: _imageFilePath.isNotEmpty
                          ? Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: fileImage, fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.amber[400],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: _getDefaultIcon(data.kind)),
                    ),

                    Container(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 5),
                          Text(data.title, style: TextStyle(fontSize: 16, color: Colors.black87)),
                          Container(height: 0),
                          Text(AppLocalizations.of(context)!.cookType(data.kind, ), style: TextStyle(fontSize: 14, color: AppColor.lineColor1)),
                          Container(height: 5),
                          Text(
                            data.desc,
                            maxLines: 2,
                            style: TextStyle(fontSize: 14, color: Colors.black87)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _navigateToListScreen(BuildContext context, String search, String kind) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCookeryPage(search, kind)));
  }

  void _navigateToCalculateScreen(BuildContext context, Cookery data) {
    // Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: data.key, currCookery: data, isEditable: false)));
  }

  void _navigateToEditScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: data.key, currCookery: data, isEditable: true)));
  }

  void _navigateToNewScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(isEditable: true)));
  }

  Container _getDefaultIcon(String kind) {
    var _color = Colors.amber[400];
    IconData _icon = Icons.dinner_dining;
    Container ret;

    if (kind == 'main') {
    } else if (kind == 'side') {
      _icon = Icons.kebab_dining;
      _color = Colors.green[300];
    } else if (kind == 'sauce') {
      _icon = Icons.science;
      _color = Colors.pink[300];
    } else if (kind == 'dessert') {
      _icon = Icons.bakery_dining;
      _color = Colors.orange[700]; //amberAccent[700];
    } else if (kind == 'drink') {
      _icon = Icons.local_cafe;
      _color = Colors.lightBlue[200];
    } else if (kind == 'etc') {
      _icon = Icons.local_dining;
      _color = Colors.grey[600];
    }

    ret = Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          size: 50,
          color: Colors.white,
          _icon,
        ));

    return ret;
  }

  Widget _searchWidget(BuildContext context) {
    return SearchBar(
      //backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStateProperty.all(BorderSide(color: AppColor.textHome1, width: 1)),
      elevation: MaterialStatePropertyAll(1),
      constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          color: AppColor.textHome1,
          onPressed: () {
            // provider.setCookeryList(search: _search_value);
            _navigateToListScreen(context, _search_value, "");
          },
        ),
      ], //trailing: [Icon(Icons.search ,color: primaryButtonTextColor,)],
      hintText: AppLocalizations.of(context)!.hint_search,

      //  hintStyle: MaterialStateProperty.all(TextStyle(
      //     color: AppColor.textHome1, )),

      onChanged: (value) {
        _search_value = value;
      },
      onSubmitted: (value) {
        _navigateToListScreen(context, _search_value, "");
      },
    );
  }
}
