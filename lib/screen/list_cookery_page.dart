import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class ListCookeryPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  List<Cookery> cookeryListB = List.empty(growable: true);
  late Cookery currCookery;
  ListCookeryPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("레시피 목록") ,
      ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          cookeryList = provider.getCookeryList();

          return ListView.builder(
            itemCount: cookeryList.length,
            //onPressed:  _navigateToEditScreen(context, index),

            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${cookeryList[index].title}"),
                subtitle: Text("${cookeryList[index].desc} "),
                onTap: () {
                  _navigateToCalculateScreen(context, index);
                },
                onLongPress: () {
                  _navigateToEditScreen(context, index);
                },
              );
            },
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        
        onPressed: () {
          _navigateToNewScreen(context, -1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Color(0xffeddBd0),//#EDDBD0 
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
