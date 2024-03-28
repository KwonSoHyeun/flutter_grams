import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/screen/list_cookery_page.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'model/cookery.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CookeryAdapter());
  Hive.registerAdapter(IngredientAdapter());
  await Hive.openBox<Cookery>("COOKERY_BOX");
  runApp(const MyApp());
}

@override
void initState() {
  logger.d("ksh first");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemsViewModel>(create: (_) => ItemsViewModel()),
        ChangeNotifierProvider<CookeryViewModel>(create: (BuildContext context) => CookeryViewModel()),
        //Provider<String>.value(value: "Kwon")
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListCookeryPage(title: 'Flutter Demo Home Page C'),
      ),
    );
  }
}
