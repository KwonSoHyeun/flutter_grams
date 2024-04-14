import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/home_kind_grid_widget.dart';

class HomeCookeryPage2 extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  HomeCookeryPage2({super.key});
  String _search_value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("레시피 목록"),
      ),
      backgroundColor: primaryColor,
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          cookeryList = provider.cookeryList;
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: primaryColor),
                  child: _searchWidget(),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height // 전체 화면 높이
                    -
                    View.of(context).padding.top / View.of(context).devicePixelRatio //MediaQuery.of(context).padding.top // 상태바 높이
                    -
                    AppBar().preferredSize.height // 앱바 높이 :Scaffold.of(context).appBarMaxHeight!.toInt() , _appBar.preferredSize.height
                    -
                    50,
                child: ListView(
                  children: setListViewItems(context),
                ))
          ]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("kToolbarHeight" + kToolbarHeight.toString() + ":" + Scaffold.of(context).appBarMaxHeight!.toString()+":" + AppBar().preferredSize.height.toString());
          print("kToolbarHeight" + kToolbarHeight.toString() + ":" + AppBar().preferredSize.height.toString());
          _navigateToNewScreen(context, -1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: primaryButtonColor, //#EDDBD0
        foregroundColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _searchWidget() {
    return SearchBar(
      elevation: MaterialStatePropertyAll(1),
      constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
      trailing: [
        IconButton(
          icon: const Icon(Icons.search),
          color: primaryButtonTextColor,
          onPressed: () {
            // provider.setCookeryList(search: _search_value);
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

  List<Widget> cardWidgets = List.empty(growable: true);

  List<Widget> setListViewItems(BuildContext context) {
    cardWidgets.add(SizedBox(height: 8, child: DecoratedBox(decoration: BoxDecoration(color: primaryColor))));
    cardWidgets.add(HomeKindGridWidget());
    cardWidgets.add(SizedBox(height: 8, child: DecoratedBox(decoration: BoxDecoration(color: primaryColor))));

    int i = 0;
    for (Cookery value in cookeryList) {
      if (i++ > 4) break;
      cardWidgets.add( BigCard(context,value));
    }
    ;
    return cardWidgets;
  }

  Card BigCard(BuildContext context, Cookery data) {
    return Card(
      // Define the shape of the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // Define the child widget of the card

      child: InkWell(
          onTap: () {
            print("onpress" + data.key.toString());
            _navigateToCalculateScreen(context, data.key);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Add padding around the row widget
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
                    // Add some spacing between the image and the text
                    Container(width: 20),
                    // Add an expanded widget to take up the remaining horizontal space
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Add some spacing between the top of the card and the title
                          Container(height: 5),
                          // Add a title widget
                          Text(data.title),
                          // Add some spacing between the title and the subtitle
                          Container(height: 5),
                          // Add a subtitle widget
                          Text(
                            data.kind,
                          ),
                          // Add some spacing between the subtitle and the text
                          Container(height: 10),
                          // Add a text widget to display some text
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

  void _navigateToCalculateScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(index: index, currCookery: data, isEditable: false)));
  }

  void _navigateToEditScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(index: index, currCookery: data, isEditable: true)));
  }

  void _navigateToNewScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(index: index, isEditable: true)));
  }
}
