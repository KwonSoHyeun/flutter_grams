import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  String search = "";
  String kind = "";

  ListCookeryPage(this.search, this.kind);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kind.isNotEmpty ? Text(  AppLocalizations.of(context)!.cookType(kind) + " " + AppLocalizations.of(context)!.title_list ) 
        : Text(AppLocalizations.of(context)!.kind_all + " " + AppLocalizations.of(context)!.title_list ),
      ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          print("list_page:search word:" + search);

          //cookeryList = provider.cookeryList;
          cookeryList = provider.getCookeryList();

          if (search.isNotEmpty) {
            cookeryList = cookeryList.where((element) => element.title.contains(search) == true 
            || element.getIngredients().contains(search)).toList();
          } else {
            if (kind.isNotEmpty) {
              cookeryList = cookeryList.where((element) => element.kind == kind).toList();
            }
          }

          return SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              height: 1.0,
              width: 500.0,
              color: AppColor.primaryColor,
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
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite),
                          color: cookeryList[index].heart ? Colors.redAccent : Colors.grey,
                          tooltip: AppLocalizations.of(context)!.hint_save_favotite,
                          onPressed: () {
                            cookeryList[index].heart = !cookeryList[index].heart;
                            provider.updateCookeryObject(cookeryList[index].key, cookeryList[index]); //todo 구현
                          },
                        ),
                       
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
        tooltip: AppLocalizations.of(context)!.button_new,
        child: const Icon(Icons.add),
        backgroundColor: AppColor.primaryButtonColor, //#EDDBD0
        foregroundColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _navigateToCalculateScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: cookeryList[index].key, currCookery: data, isEditable: false)));
  }

  void _navigateToEditScreen(BuildContext context, int index) {
    Cookery data = cookeryList[index].deepCopy();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: cookeryList[index].key, currCookery: data, isEditable: true)));
  }

  void _navigateToNewScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(isEditable: true)));
  }
}
