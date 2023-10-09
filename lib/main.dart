import 'package:flutter/material.dart';
import 'package:grams/screen/EditCookery.dart';
import 'package:grams/services/HiveRepository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';

import 'model/cookery.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CookeryAdapter());
  await HiveRepository.openBox();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page C'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: HiveRepository.cookeryBox.listenable(),
            builder: (BuildContext context, Box<Cookery> box, Widget? child) {
              List<Cookery> cookerys = HiveRepository.getAll();

              if (cookerys.isEmpty) return const SizedBox();

              return ListView.separated(
                  itemBuilder: (context, index) {
                    Cookery cookery = cookerys[index];
                    return ListTile(
                      title: Text(cookery.title),
                      subtitle: Text(cookery.desc),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: HiveRepository.cookeryBox.length);
            },
          )),
        ],
      )),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditScreen(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditCookery()));
  }
}
