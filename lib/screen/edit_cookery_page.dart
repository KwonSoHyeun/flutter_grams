import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../model/ingredient.dart';
import '../viewmodel/items_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatefulWidget {
  final int index;
  final Cookery? currCookery;
  final bool isEditable;

  //EditCookeryPage(this.index, this.currCookery, this.isEditable, [Cookery? currcookery]);
  EditCookeryPage({this.index = -1, this.currCookery, this.isEditable = true});

  @override
  State<EditCookeryPage> createState() => _EditCookeryPageState();
}

class _EditCookeryPageState extends State<EditCookeryPage> {
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;
  XFile? _image;
  final picker = ImagePicker();

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final cautionController = TextEditingController();


  @override
  void initState() {
    super.initState();

    cookeryViewModel = Provider.of<CookeryViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel = Provider.of<ItemsViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel.clearDataItemList();
    cookeryViewModel.setCurrCookery(widget.currCookery);
    if (widget.currCookery != null) {
      titleController.text = widget.currCookery!.title;
      descController.text = widget.currCookery!.desc;
      cautionController.text = widget.currCookery!.caution;
      itemsViewModel.makeItemWidgetList(widget.currCookery!.ingredients!, widget.isEditable);
    }
  }

  @override
  Widget build(BuildContext context) {
    //var msg = widget.isEditable?'Calculate mode': 'Edit mode';
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.isEditable ? 'Receipe' : 'Calculating'),
          actions: [
            Visibility(
              visible: widget.index < 0 && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                color: Colors.white70,
                tooltip: 'Save new data',
                onPressed: () {
                  cookeryViewModel.addCookery(titleController.text, descController.text, cautionController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0 && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                color: Colors.white70,
                tooltip: 'Update data',
                onPressed: () {
                  cookeryViewModel.update(widget.index, titleController.text, descController.text, cautionController.text, itemsViewModel.getIngredientList());
                  Navigator.of(context).pop();
                },
              ),
            ),
            Visibility(
              visible: widget.index >= 0 && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.white70,
                tooltip: 'Open shopping cart',
                onPressed: () {
                  cookeryViewModel.delete(widget.index);
                  Navigator.of(context).pop();
                },
              ),
            ),
            PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert),
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: widget.isEditable ? 0 : 1, child: Text(widget.isEditable ? 'save as copy' : 'edit mode')),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  controller: titleController,
                  decoration: const InputDecoration(labelText: '요리명'),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: '레시피 작성'),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30, width: double.infinity),
                    _buildPhotoArea(),
                    SizedBox(height: 20),
                    _buildButton(),
                  ],
                ),
                TextFormField(
                  controller: cautionController,
                  decoration: const InputDecoration(labelText: '주의사항'),
                  keyboardType: TextInputType.text,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Center(child: Consumer<ItemsViewModel>(builder: (context, provider, child) {
                  return Column(children: provider.boxItemWidget);
                })),
                Visibility(
                    visible: widget.isEditable,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                            child: IconButton(
                          icon: Icon(Icons.add_box_outlined),
                          onPressed: () {
                            itemsViewModel.addIngredientWidget();
                          },
                        ))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  void showConfirm(BuildContext context) {
    // if (!mounted) return;
    showDialog(
        context: context,
        barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
        builder: ((context) {
          return AlertDialog(
            title: Text("제목"),
            content: Text('처리 되었습니다.'),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                    Navigator.pop(context);
                  },
                  child: Text("네"),
                ),
              ),
            ],
          );
        }));
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        print("goto edit page");
        Cookery curr_data =
            Cookery(title: titleController.text, desc: descController.text, caution: cautionController.text, ingredients: itemsViewModel.getIngredientList());
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditCookeryPage(index: widget.index, currCookery: curr_data, isEditable: true)));

        break;
    }
  }
    // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource,  imageQuality: 50, maxWidth: 600, maxHeight: 600);
    
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
          },
          child: Text("카메라"),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          child: Text("갤러리"),
        ),
      ],
    );
  }
}
