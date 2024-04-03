import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class ListCookeryPage extends StatelessWidget {
  late List<Cookery> cookeryList;

  ListCookeryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("레시피 목록"),
      ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          cookeryList = provider.getCookeryList();

          return ListView.builder(
            itemCount: cookeryList.length,
            //onPressed:  _navigateToEditScreen(context, index),

            itemBuilder: (context, index) {
              return ListTile(
                title : Text("${cookeryList[index].title}"),
                subtitle : Text("${cookeryList[index].desc} ///*/// ${cookeryList[index].ingredients![0].count}"),
                onTap: (){ _navigateToCalculateScreen(context, index);},
                onLongPress :(){ _navigateToEditScreen(context, index);},
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditScreen(context, -1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void _navigateToCalculateScreen(BuildContext context, int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditCookeryPage(index, false)));
  }


  void _navigateToEditScreen(BuildContext context, int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditCookeryPage(index, true)));
  }
}
