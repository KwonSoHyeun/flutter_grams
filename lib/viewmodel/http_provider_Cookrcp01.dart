import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/cookrcp01.dart';
import 'package:grams/model/ingredient.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/abstract_http_data.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class HttpProviderCookrcp01 extends ChangeNotifier implements HttpPublicData {
  List<Cookery> cookeryList = List.empty(growable: true);
  late Cookery currCookery;
  int fromNo = 1;
  bool isLoading = false;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> started() async {
    cookeryList = List.empty(growable: true);
    fromNo = 1;
    isLoading = true;
    await makeCookeryList(AppConst.fetchDefaultCount);
  }

  Future<void> more(int nextNo) async {
    isLoading = true;
    await makeCookeryList(nextNo);
  }

  @override
  Future<void> makeCookeryList(int nextNo) async {
    List<COOKRCP01>? _data = await fetchPost(pageNo: nextNo);
    Cookery data;

    for (int i = 0; i < 2; i++) {
      //  for (int i = 0; i < _data.length; i++) {
      data = Cookery(
          title: _data[i].RCP_NM,
          kind: _data[i].RCP_PAT2!,
          img: _data[i].ATT_FILE_NO_MK!,
          desc: _data[i].MANUAL01! + "\n" + _data[i].MANUAL02! + "\n" + _data[i].MANUAL03!,
          caution: _data[i].RCP_NA_TIP!,
          heart: false,
          hit: 0,
          ingredients: splitIngredient(_data[i].RCP_PARTS_DTLS));
      cookeryList.add(data);
      print(data.title);
    }

    isLoading = false;
    fromNo = nextNo + 1;
    notifyListeners();
  }

  @override
  Future<List<COOKRCP01>> fetchPost({
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

  @override
  List<Ingredient> splitIngredient(String? data) {
    List<Ingredient> ingrDataList = List.empty(growable: true);

    RegExpMatch? match1;
    String tempStr = "";
    String ingr_name = "";
    double ingr_count = 0;
    String ingr_unit = "";
    RegExp regex;
    List<String> str1;
    String rateBlock = "";

    if (data != null) {
      //1. split
      regex = new RegExp(r'\[|\]|\,|\:|\·');
      List<String> parts = data.split(regex);

      for (int i = 0; i < parts.length; i++) {
        ingr_name = "";
        ingr_count = 0;
        ingr_unit = "";

        rateBlock = "";
        tempStr = "";

        print("순서 $i) :" + parts[i]);
        try {
          //2. 소괄호 내용 무시
          if (parts[i].contains('(')) {
            tempStr = parts[i].substring(0, parts[i].indexOf('(')).trim();
          } else {
            tempStr = parts[i];
          }
          print("tempStr=" + tempStr);

          ingr_name = tempStr.substring(0, tempStr.lastIndexOf(" ")).trim();
          rateBlock = tempStr.substring(tempStr.lastIndexOf(" "), tempStr.length).trim();
          print("ingr_name=" + ingr_name);
          print("rateBlock=" + rateBlock);

          // rateBlock 에 숫자가 있는지?
          // 숫자가 없으면 해당값을 이름쪽으로 붙여주고
          // 숫자가 있으면 count, unit 으로 파싱한다.
          regex = new RegExp(r'[0-9]');
          if (!rateBlock.contains(regex)) {
            print("A");
            ingr_name = ingr_name + rateBlock;
            ingr_count = 0;
            ingr_unit = "";
          } else {
            print("B");
            regex = new RegExp(r'^[0-9|\.]*'); // //r'/[^0-9]/g')
            match1 = regex.firstMatch(rateBlock);
            if (match1 != null && match1.start != null) {
              ingr_count = double.parse(rateBlock.substring(match1.start, match1.end));
              ingr_unit = rateBlock.substring(match1.end, rateBlock.length);
            }
          }
          ingrDataList.add(Ingredient(name: ingr_name, count: ingr_count, unit: ingr_unit));
          print("-----------------------------");


        } catch (e) {}
      }
      print("Org is " + data.toString());
      print("All ingrDataList is " + ingrDataList.toString());
      return ingrDataList;
    } else {
      return List.empty(growable: true);
    }
  }
}
