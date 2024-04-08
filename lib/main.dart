import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/screen/list_cookery_page.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'model/cookery.dart';

const primaryColor = Color(0xffe44805);//ee4e34
//const primaryColor = Color(0xffe44805);//ee4e34
const primaryTextColor = Color(0xffeee0a3);

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(CookeryAdapter());
  Hive.registerAdapter(IngredientAdapter());
  await Hive.openBox<Cookery>("COOKERY_BOX");
  runApp(const MyApp());
  //FlutterNativeSplash.remove();
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

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              backgroundColor: primaryColor,
              foregroundColor: primaryTextColor),
          useMaterial3: true,
        ),
        home: ListCookeryPage(),
      ),
    );
  }
}
