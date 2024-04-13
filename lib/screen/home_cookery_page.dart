import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/home_kind_grid_widget.dart';
import 'widgets/home_kind_widget.dart';
import 'dart:ui';

/*

*/
class HomeCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  HomeCookeryPage({super.key});
  String _search_value = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("레시피 목록"),
      ),
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
                child: ListView(children: [
                  SizedBox(height: 4, child: DecoratedBox(decoration: BoxDecoration(color: primaryColor))),
                  HomeKindGridWidget(),
                  SizedBox(height: 4, child: DecoratedBox(decoration: BoxDecoration(color: primaryColor))),
                  
                  ListTile(
                      // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                      title: Text("${cookeryList[0].title}"),
                      subtitle: Text("${cookeryList[0].desc} ")),
                  ListTile(
                      // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                      title: Text("${cookeryList[1].title}"),
                      subtitle: Text("${cookeryList[1].desc} ")),
                  ListTile(
                      // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                      title: Text("${cookeryList[1].title}"),
                      subtitle: Text("${cookeryList[1].desc} ")),
                  ListTile(
                      // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                      title: Text("${cookeryList[1].title}"),
                      subtitle: Text("${cookeryList[1].desc} ")),
                  ListTile(
                      // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                      title: Text("${cookeryList[1].title}"),
                      subtitle: Text("${cookeryList[1].desc} "))
                ]))
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
        backgroundColor: Color(0xffeddBd0), //#EDDBD0
        foregroundColor: Color(0xffd84a09),
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
