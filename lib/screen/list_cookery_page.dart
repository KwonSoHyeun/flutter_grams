import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';

class ListCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  String _search_value = "";
   
  String search_value="";
  String kind="";
  
  ListCookeryPage(this.search_value, this.kind);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: const Text("CookGram"),
       ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          //if (cookeryList.)
          cookeryList = provider.cookeryList;
          return SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              height: 1.0,
              width: 500.0,
              color: primaryColor,
            ),

            Expanded(
                child: ListView.separated(
                    itemCount: cookeryList.length,
                    //onPressed:  _navigateToEditScreen(context, index),
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 1);
                    },
                    itemBuilder: (context, index) {
                      //return buildRecipeCard(cookeryList[index], context, index);
                      return ListTile(
                        // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                        title: Text("${cookeryList[index].title}"),
                        subtitle: Text("${cookeryList[index].desc} "),
                        onTap: () {
                          _navigateToCalculateScreen(context, index);
                        },
                        onLongPress: () {
                          _navigateToEditScreen(context, index);
                        },
                      );
                    })),
          ]));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNewScreen(context, -1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: primaryButtonColor, //#EDDBD0
        foregroundColor: Colors.white,
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

  Widget _searchWidget() {
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
