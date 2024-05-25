import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
//part 'cookrcp01.g.dart';
/*
인증키 78939bb854f04bdbb926
(식품의약품 안전처 공공DB)
https://www.foodsafetykorea.go.kr/api/newUserApiAplcDtl.do
*/
 class BaseCookery extends Cookery {
  BaseCookery({required super.title, required super.kind, required super.img, required super.desc, required super.caution, required super.heart, required super.hit});
  // factory BaseCookery(String name) {
  //   return _cache.putIfAbsent(
  //       // 2번
  //       name,
  //       () => Logger._internal(name));
  // }

  // factory BaseCookery.fromJson(Map<String, dynamic> json) {
  //   return BaseCookery(json['name'].toString());
  // }

  // Map<String, dynamic> toJson();
}
