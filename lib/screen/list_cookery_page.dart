import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/screen/calculate_cookery_page.dart';
import 'package:grams/screen/edit_cookery_page.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class ListCookeryPage extends StatefulWidget {
  const ListCookeryPage({super.key, required this.title});

  final String title;

  @override
  State<ListCookeryPage> createState() => _ListCookeryPageState();
}

class _ListCookeryPageState extends State<ListCookeryPage> {
  late List<Cookery> albumList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<CookeryViewModel>(
        builder: (context, provider, child) {
          albumList = provider.getCookeryList();

          return ListView.builder(
            itemCount: albumList.length,
            //onPressed:  _navigateToEditScreen(context, index),

            itemBuilder: (context, index) {
              return ListTile(
                title : Text("${albumList[index].title}"),
                subtitle : Text("${albumList[index].desc} , ${albumList[index].ingredients!.length}"),
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
        .push(MaterialPageRoute(builder: (context) => CalculateCookeryPage(index)));
  }


  void _navigateToEditScreen(BuildContext context, int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditCookeryPage(index)));
  }
}
