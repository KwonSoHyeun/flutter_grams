import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grams/model/cookery.dart';
import 'package:grams/model/cookrcp01.dart';
import 'package:grams/model/ingredient.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

abstract class HttpPublicData {
  Future<void> makeCookeryList(int nextNo);

  Future<List<Object>> fetchPost({
    required int pageNo,
  }) ;
  
  List<Ingredient> splitIngredient(String data) ;
}