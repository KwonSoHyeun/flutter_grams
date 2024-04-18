import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/screen/list_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
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
      backgroundColor: Color(0xffD5DFDF),
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

          print("다시 부름 홈, " + favoriteList.length.toString());
          return SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              height: 1.0,
              width: 500.0,
              color: primaryColor,
            ),
            Container(
                //height: 150,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 8),
                alignment: Alignment(0.0, 0.0),
                decoration: const BoxDecoration(
                  color: Color(0xff94C4C7),
                  image: DecorationImage(
                      image: AssetImage('assets/photos/bg_kitchen5.jpg'), //0xffB1BDA9
                      // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      fit: BoxFit.cover),
                ),
                child: Column(children: <Widget>[
                  const Text(
                    "CookGram",
                    //"CookGram is an easy ratio calculator to use with cooking recipes. ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'palatino', color: Colors.white), //Color(0xff303C7B)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _searchWidget(context),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "");
                      },
                      child: Text("All"),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "main");
                      },
                      child: Text("Main"),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "side");
                      },
                      child: Text("Side"),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "sauce");
                      },
                      child: Text("Sauce"),
                    ),
                  ]),
                  Row(children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "dessert");
                      },
                      child: Text("Dessert"),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "drink");
                      },
                      child: Text("Drink"),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ButtonKindBGColor)),
                      onPressed: () {
                        _navigateToListScreen(context, "", "etc");
                      },
                      child: Text("ETC"),
                    ),
                    Spacer(),
                  ]),
                ])),
            Container(
              height: 1.0,
              width: 500.0,
              color: primaryColor,
            ),
            SizedBox(
                height: 50,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.favorite, color: AccentColor), Text(" 내가 좋아하는 레시피")])),
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
        backgroundColor: primaryButtonColor, //#EDDBD0
        foregroundColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //List<Widget> cardWidgets = List.empty(growable: true);

  // List<Widget> setListViewItems(BuildContext context) {
  //   favoriteList = cookeryList.where((element) {
  //     return element.heart == true;
  //   }).toList();

  //   for (Cookery value in favoriteList) {
  //     cardWidgets.add(BigCard(context, value));
  //   }
  //   ;
  //   return cardWidgets;
  // }

  Card BigCard(BuildContext context, Cookery data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
          onTap: () {
            //final pIndex = favoriteList.indexWhere((element) => element.id == data.id);
            print("onpress" + data.key.toString());
            //print("onpress" + index.toString());

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
                    Image.asset(
                      "assets/photos/ic_dish.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),

                    Container(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 5),
                          Text("*" + data.title),
                          Container(height: 5),
                          Text(
                            data.kind,
                          ),
                          Container(height: 10),
                          Text(
                            data.desc,
                            maxLines: 2,
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey:data.key, currCookery: data, isEditable: false)));
  }

  void _navigateToEditScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey:data.key, currCookery: data, isEditable: true)));
  }

  void _navigateToNewScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage( isEditable: true)));
  }

  Widget _searchWidget(BuildContext context) {
    return SearchBar(
      //backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStateProperty.all(BorderSide(color: Colors.black, width: 1)),
      elevation: MaterialStatePropertyAll(1),
      constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          color: primaryButtonTextColor,
          onPressed: () {
            // provider.setCookeryList(search: _search_value);
            _navigateToListScreen(context, _search_value, "");
          },
        ),
      ], //trailing: [Icon(Icons.search ,color: primaryButtonTextColor,)],
      hintText: "검색어를 입력하세요",
      onChanged: (value) {
        _search_value = value;
      },
      onSubmitted: (value) {
        print(value);
      },
    );
  }
}
