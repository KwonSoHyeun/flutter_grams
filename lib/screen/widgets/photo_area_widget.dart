import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAreaWidget extends StatelessWidget {
   XFile? image;

  PhotoAreaWidget(XFile? image, {super.key});

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Container(
            width: 100,
            height: 100,
            child: Image.file(File(image!.path)), //가져온 이미지를 화면에 띄워주는 코드
            decoration: BoxDecoration(
              image: DecorationImage(image: FileImage( File(image!.path)), fit: BoxFit.cover),
            ),
          )
        : Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/photos/ic_cupcake.png'), fit: BoxFit.cover),
            ),
          );
    //: Container(width: 200, height: 200, child: Image.asset("assets/photos/ic_cupcake.png"));
  }
}
