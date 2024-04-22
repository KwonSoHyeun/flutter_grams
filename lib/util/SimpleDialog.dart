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
}
