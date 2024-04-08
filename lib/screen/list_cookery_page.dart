import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class ListCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  ListCookeryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("레시피 목록"),
      ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          cookeryList = provider.getCookeryList();

          return Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SearchBar(
                 // constraints: BoxConstraints(maxHeight: 500),
                  shape: MaterialStateProperty.all(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40))),
                  elevation: MaterialStatePropertyAll(1),
                  //backgroundColor: MaterialStatePropertyAll( Color(0xffeddBd0)),
                  shadowColor: MaterialStatePropertyAll(primaryBgColor),
                  trailing: [Icon(Icons.search ,color: primaryButtonTextColor,)],
                  hintText: "검색어를 입력하세요",
                  onSubmitted: (value) {},
                )),
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
                        leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
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
          ]);
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

  /*Widget buildRecipeCard(Cookery recipe, BuildContext context, int index) {
    return GestureDetector(
        onTap: () => _navigateToCalculateScreen(context, index),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                //Image.asset(recipe.imageUrl!),
                Text(
                  recipe.title!,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, fontFamily: 'palatino'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  recipe.desc!,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100, fontFamily: 'palatino'),
                ),
                Text(
                  recipe.caution!,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100, fontFamily: 'palatino'),
                ),
              ],
            ),
          ),
        ));
  }*/
}
