import 'package:flutter/material.dart';

class BoxItems extends StatelessWidget {
  const BoxItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      // 커스텀 위젯의 내용
      child: Text(
        "나는 SizedBox",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
