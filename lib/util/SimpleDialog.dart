import 'package:flutter/material.dart';

class Utility {
  void showConfirm(BuildContext context, String title, String message) {
    // if (!mounted) return;
    showDialog(
        context: context,
        barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
        builder: ((context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ),
            ],
          );
        }));
  }
/*
showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("파일을 어떤형식으로 다운로드하시겠습니까?"),
            children: [
              TextButton(
                child: Text("다운로드"),
                onPressed: () async {
                  // 다운로드 선택 시 콜백
                  // 행위 등록
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("공유하기"),
                onPressed: () async {
                  // 공유하기 선택 시 콜백
                  // 행위 등록
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
*/

}
