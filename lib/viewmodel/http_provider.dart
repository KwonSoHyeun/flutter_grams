import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/cookrcp01.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class HttpProvider extends ChangeNotifier {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  final int fetchCount = 10;

  //List<COOKRCP01> photos = [];
  //int currentPageNo = 1;
  int fromNo = 1;
  //bool isAdd = false;
  bool isLoading = false;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> started() async {
    isLoading = true;
    await _getCookrcp01(fetchCount);
  }

  Future<void> more(int nextNo) async {
   isLoading = true;

    await _getCookrcp01(nextNo);
  }

  Future<void> _getCookrcp01(int nextNo) async {
    List<COOKRCP01>? _data = await _fetchPost(pageNo: nextNo);
    Cookery data;

    for (int i = 0; i < _data.length; i++) {
      data = Cookery(
          title: _data[i].RCP_NM,
          kind: _data[i].RCP_PAT2!,
          img: _data[i].ATT_FILE_NO_MK!,
          desc: _data[i].MANUAL01!,
          caution: "",
          heart: false,
          hit: 0,
          ingredients: null);
      cookeryList.add(data);
      print(data.title);
    }

    isLoading = false;
    fromNo = nextNo + 1;
    notifyListeners();
  }

  Future<List<COOKRCP01>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(Uri.parse("http://openapi.foodsafetykorea.go.kr/api/78939bb854f04bdbb926/COOKRCP01/json/$fromNo/$pageNo"));
      print("from ~~~ to:::::  $fromNo/$pageNo");

      if (_response.statusCode == 200) {
        List<dynamic> _data = json.decode(_response.body)['COOKRCP01']['row'];
        List<COOKRCP01> _result = _data.map((e) => COOKRCP01.fromJson(e)).toList();

        //logger.i("CCC::" + _result.length.toString());
        return _result;
      } else {
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  buildLoading(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }
}
