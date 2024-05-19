import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/cookrcp01.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class HttpProvider extends ChangeNotifier {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;

  List<COOKRCP01> photos = [];
  int currentPageNo = 1;
  bool isAdd = false;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> started() async {
    await _getCookrcp01();
  }

  Future<void> _getCookrcp01() async {

    List<COOKRCP01>? _data = await _fetchPost(pageNo: currentPageNo);
    photos = _data;

    Cookery data ;

    for (int i = 0; i < photos.length; i++) {
      data = Cookery(title: photos[i].RCP_NM, kind:photos[i].RCP_PAT2! ,  img:photos[i].ATT_FILE_NO_MK!, 
      desc: photos[i].MANUAL01!, caution: "", heart: false, hit: 0, ingredients: null);
      cookeryList.add(data);
      logger.i(cookeryList[i].title);
    }
    //currentPageNo = 2;
    //logger.e(currentPageNo);
    notifyListeners();
  }

/*
    final url = Uri.parse(
      'http://openapi.foodsafetykorea.go.kr/api/78939bb854f04bdbb926/COOKRCP01/xml/1/5',
    );

    final response = await http.get(url);
*/
  Future<List<COOKRCP01>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(Uri.parse("http://openapi.foodsafetykorea.go.kr/api/78939bb854f04bdbb926/COOKRCP01/json/1/5"));
      //Uri.parse("http://openapi.foodsafetykorea.go.kr/api/78939bb854f04bdbb926/COOKRCP01/json/1/$pageNo"));
      if (_response.statusCode == 200) {
        //logger.i("AAA:::" + _response.body);
        logger.i("-----------#############----------------");
        //logger.i("BBB:::" + json.decode(_response.body)['COOKRCP01']['row'].toString());

        List<dynamic> _data = json.decode(_response.body)['COOKRCP01']['row'];
        List<COOKRCP01> _result = _data.map((e) => COOKRCP01.fromJson(e)).toList();

        logger.i("CCC::" + _result.length.toString());
        return _result;
      } else {
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }
}
