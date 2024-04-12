import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/home_kind_widget.dart';

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
          return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SearchBar(
                  elevation: MaterialStatePropertyAll(1),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: primaryButtonTextColor,
                      onPressed: () {
                        provider.setCookeryList(search: _search_value);
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
                )),
            SingleChildScrollView(
                child: IntrinsicHeight(
                    // added widget
                    child: HomeKindWidget())),

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
            // Expanded(
            //   child: Container(
            //       color: Colors.white,
            //       child: ListView.separated(
            //           itemCount: cookeryList.length,
            //           //onPressed:  _navigateToEditScreen(context, index),
            //           separatorBuilder: (BuildContext context, int index) {
            //             return Divider(thickness: 1);
            //           },
            //           itemBuilder: (context, index) {
            //             //return buildRecipeCard(cookeryList[index], context, index);
            //             return ListTile(
            //               // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
            //               title: Text("${cookeryList[index].title}"),
            //               subtitle: Text("${cookeryList[index].desc} "),
            //               onTap: () {
            //                 _navigateToCalculateScreen(context, index);
            //               },
            //               onLongPress: () {
            //                 _navigateToEditScreen(context, index);
            //               },
            //             );
            //           })),
            // )
          ]));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNewScreen(context, -1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Color(0xffeddBd0), //#EDDBD0
        foregroundColor: Color(0xffd84a09),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
