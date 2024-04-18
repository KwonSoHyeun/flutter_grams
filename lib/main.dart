import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/screen/home_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'model/cookery.dart';
import 'services/hive_data.dart'; 

//const primaryColor = Color(0xffe44805);//ee4e34
//const primaryColor = Color(0xffe44805);//ee4e34
//const primaryTextColor = Color(0xffeee0a3);

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await HiveData.init();

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
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryTextColor),
              backgroundColor: primaryColor,
              foregroundColor: primaryTextColor),
          useMaterial3: true,
        ),
        home: HomeCookeryPage(),
      ),
    );
  }
}
