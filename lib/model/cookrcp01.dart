import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cookrcp01.g.dart';
/*
인증키 78939bb854f04bdbb926
(식품의약품 안전처 공공DB)
https://www.foodsafetykorea.go.kr/api/newUserApiAplcDtl.do
*/
@JsonSerializable()
class COOKRCP01 { 
  String RCP_NM; //요리명
  String? RCP_PARTS_DTLS; //재료들
  String? RCP_PAT2; //반찬, ...etc
  String? ATT_FILE_NO_MK; //대표 이미지
  String? MANUAL01;
  String? MANUAL02;
  String? MANUAL03;

  COOKRCP01({
     required this.RCP_NM,
     this.RCP_PARTS_DTLS,
     required this.RCP_PAT2,
     this.ATT_FILE_NO_MK,
     this.MANUAL01,
     this.MANUAL02,
     this.MANUAL03
  });

  factory COOKRCP01.fromJson(Map<String, dynamic> json) =>_$COOKRCP01FromJson(json);

  Map<String, dynamic> toJson() => _$COOKRCP01ToJson(this);

}
