import 'package:flutter/material.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/screen/home_cookery_page.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:grams/viewmodel/http_provider.dart';
import 'package:grams/viewmodel/items_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'model/cookery.dart';
import 'services/hive_data.dart'; 
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this line
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemsViewModel>(create: (_) => ItemsViewModel()),
        ChangeNotifierProvider<CookeryViewModel>(create: (BuildContext context) => CookeryViewModel()),
        ChangeNotifierProvider<HttpProvider>(create: (_) => HttpProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate, // Add this line
        GlobalWidgetsLocalizations.delegate, // Add this line
        GlobalCupertinoLocalizations.delegate, // Add this line
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],

        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.primaryTextColor),
              backgroundColor: AppColor.primaryColor,
              foregroundColor: AppColor.primaryTextColor),
          useMaterial3: true,
        ),
        home: HomeCookeryPage(),
      ),
    );
  }
}
