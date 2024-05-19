import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/viewmodel/http_provider.dart';
import 'package:http/http.dart' as http;
import 'package:grams/util/colorvalue.dart';
import 'package:grams/util/navigator.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListApiPage extends StatelessWidget {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  String search = "";
  String kind = "";

  //ListApiPage(this.search, this.kind);

  @override
  Widget build(BuildContext context) {
    HttpProvider httpViewModel = Provider.of<HttpProvider>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    httpViewModel.started();

    return Scaffold(
      appBar: AppBar(
        title: kind.isNotEmpty ? Text(AppLocalizations.of(context)!.cookType(kind).toUpperCase()) : Text(AppLocalizations.of(context)!.kind_all.toUpperCase()),
        shape: const Border(
          bottom: BorderSide(
            color: AppColor.lineColor2,
            width: 1,
          ),
        ),
      ),
      body: Consumer<HttpProvider>(
        builder: (context, provider, child) {
          print("list_page:search word:" + search);

          //cookeryList = provider.cookeryList;
          //cookeryList = provider.getCookeryList();

          cookeryList = provider.cookeryList;

          return SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            cookeryList.length <= 1
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    alignment: Alignment.topCenter,
                    child: Text(style: TextStyle(color: Colors.blue[700], fontSize: 20), AppLocalizations.of(context)!.description_msg3),
                  )
                : SizedBox(),
            Expanded(
                child: ListView.separated(
                    itemCount: cookeryList.length,
                    //onPressed:  _navigateToEditScreen(context, index),
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 1,
                        color: AppColor.lineColor2,
                      );
                    },
                    itemBuilder: (context, index) {
                      //return buildRecipeCard(cookeryList[index], context, index);
                      return ListTile(
                        // leading: CircleAvatar(child: Text('C')), //CircleAvatar(child: Text('C')),
                        title: Text("${cookeryList[index].title}"),
                        subtitle: Text(maxLines: 3, "${cookeryList[index].desc} "),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite),
                          color: cookeryList[index].heart ? Colors.redAccent : Colors.grey,
                          tooltip: AppLocalizations.of(context)!.hint_save_favotite,
                          onPressed: () {
                            //cookeryList[index].heart = !cookeryList[index].heart;
                            //provider.updateCookeryObject(cookeryList[index].key, cookeryList[index]);
                          },
                        ),

                        onTap: () {
                          AppNavigator.navigateToCalculateScreen(context, cookeryList[index]);
                        },
                        onLongPress: () {
                          AppNavigator.navigateToEditScreen(context, index, cookeryList[index]);
                        },
                      );
                    })),
          ]));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.navigateToNewScreen(context, -1);
        },
        tooltip: AppLocalizations.of(context)!.button_new,
        child: const Icon(Icons.add),
        backgroundColor: AppColor.primaryButtonColor, //#EDDBD0
        foregroundColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future getApiData() async {
    final url = Uri.parse(
      'http://openapi.foodsafetykorea.go.kr/api/78939bb854f04bdbb926/COOKRCP01/xml/1/5',
    );

    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
