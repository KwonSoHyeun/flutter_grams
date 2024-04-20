import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grams/screen/widgets/select_kind_widget.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:grams/viewmodel/cookery_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../model/cookery.dart';
import '../viewmodel/items_viewmodel.dart';
import 'widgets/photo_area_widget.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatefulWidget {
  final String? currKey;
  final Cookery? currCookery;
  final bool isEditable;


  //EditCookeryPage(this.index, this.currCookery, this.isEditable, [Cookery? currcookery]);
  EditCookeryPage({
    this.currKey, this.currCookery, this.isEditable = true}
    );

  @override
  State<EditCookeryPage> createState() => _EditCookeryPageState();
}

class _EditCookeryPageState extends State<EditCookeryPage> {
  late CookeryViewModel cookeryViewModel;
  late ItemsViewModel itemsViewModel;
  Cookery? editCookery = null;
  XFile? _image;
  String _imageFilePath = "";
  final picker = ImagePicker();
  // List<String> dropDownList = ['1', '2', '3'];

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final cautionController = TextEditingController();
  late String dropDownValue = cookingKindList[0];
  bool isFavorit = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("1:edit_page:initState:");
    
    cookeryViewModel = Provider.of<CookeryViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel = Provider.of<ItemsViewModel>(context, listen: false); //초기 데이타 기본값을을 널어주기 위함.
    itemsViewModel.clearDataItemList();
    cookeryViewModel.setCurrCookery(editCookery);
    if (widget.currCookery != null) {
      editCookery = widget.currCookery!.deepCopy();
      titleController.text = editCookery!.title;

      if (editCookery!.img.isNotEmpty) {
        _imageFilePath = editCookery!.img;
        _image = XFile(_imageFilePath); //가져온 이미지를 _image에 저장
      }

      dropDownValue = editCookery!.kind;
      descController.text = editCookery!.desc;
      cautionController.text = editCookery!.caution;

      itemsViewModel.makeItemWidgetList(editCookery!.ingredients!, widget.isEditable);
      isFavorit = editCookery!.heart;
    }

    if (editCookery == null) {
      itemsViewModel.defaultIngredientWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    //var msg = widget.isEditable?'Calculate mode': 'Edit mode';
    print("2:edit_page:build:");
    print("2:edit_page:build:currkey" + widget.currKey.toString());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.isEditable ? 'Recipe' : 'Calculating'),
          actions: [
//앱바 : 신규저장
            Visibility(
              visible: editCookery == null && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                color: Colors.white70,
                tooltip: 'Save new data',
                onPressed: () {
                  final formKeyState = _formKey.currentState!;
                  if (formKeyState.validate()) {
                    cookeryViewModel.addCookery(titleController.text, dropDownValue, _imageFilePath, descController.text, cautionController.text, isFavorit, 0,
                        itemsViewModel.getIngredientList()); //todo 구현
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
//앱바: 업데이트 저장
            Visibility(
              visible: editCookery != null && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                color: Colors.white70,
                tooltip: 'Update data',
                onPressed: () {
                  final formKeyState = _formKey.currentState!;
                  if (formKeyState.validate()) {
                    cookeryViewModel.update(widget.currKey!, titleController.text, dropDownValue, _imageFilePath, descController.text, cautionController.text, isFavorit, 0,
                        itemsViewModel.getIngredientList()); //todo 구현
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
//앱바: 삭제
            Visibility(
              visible: editCookery != null && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.white70,
                tooltip: 'Delete',
                onPressed: () {
                  cookeryViewModel.delete(widget.currKey!);
                  Navigator.of(context).pop();
                },
              ),
            ),
//앱바: 에디트 모드로 이동
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: widget.isEditable
                            ? TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return '3자 이상 입력해 주세요';
                                  else
                                    return null;
                                },
                                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                controller: titleController,
                                decoration: const InputDecoration(labelText: '요리명'),
                                maxLength: 100,
                                keyboardType: TextInputType.text,
                              )
                            : Text(editCookery!.title),
                      ),
                      widget.isEditable
                          ? SelectKindWidget(
                              callback: (value) => setState(() {
                                dropDownValue = value;
                              //  print(value);
                              }),
                              init: dropDownValue,
                            )
                          : Text(editCookery!.kind),
                    ]),
                    widget.isEditable
                        ? TextFormField(
                            validator: (value) {
                              if (value!.isEmpty)
                                return '10자 이상 입력해 주세요';
                              else
                                return null;
                            },
                            controller: descController,
                            decoration: const InputDecoration(labelText: '레시피 작성'),
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLength: 500,
                            maxLines: null,
                          )
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 20, 10, 30),
                            // alignment: Alignment(0.0, 0.0),
                            child: Text(editCookery!.desc, textAlign: TextAlign.left),
                          ),
//사진등록
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Text('사진경로: $_imageFilePath'),
                        //   SizedBox(height: 30, width: double.infinity),
                        Visibility(
                          visible: _imageFilePath.isNotEmpty,
                          //child: PhotoAreaWidget(_image),
                          child: _image != null
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  //child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: FileImage(File(_image!.path)), fit: BoxFit.cover),
                                  ),
                                )
                              : Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/photos/ic_cupcake.png'), fit: BoxFit.cover),
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        widget.isEditable ? _buildButton() : Text(""),
                      ],
                    ),
                    widget.isEditable
                        ? TextFormField(
                            controller: cautionController,
                            decoration: const InputDecoration(labelText: '주의사항'),
                            maxLength: 200,
                            keyboardType: TextInputType.text,
                          )
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(0, 20, 10, 30),
                            // alignment: Alignment(0.0, 0.0),
                            child: Text(editCookery!.caution, textAlign: TextAlign.left),
                          ),
//사진등록
                    const Padding(padding: EdgeInsets.all(10)),
                    //재료명, 중량, 단위를 다수개 등록
                    Center(child: Consumer<ItemsViewModel>(builder: (context, provider, child) {
                      print("3:edit_page:consumer:called");
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
                        )),
                    IconButton(
                        icon: Icon(Icons.favorite),
                        color: isFavorit ? Colors.red[600] : Colors.grey,
                        iconSize: 30,
                        onPressed: () {
                          if (editCookery?.ingredients == null){
                             print("4:edit_page:ingredient empty");                       
                          } else {
                             print("4:edit_page:ingredient length:" + editCookery!.ingredients!.length.toString());
                          }
                         
                          setState(() {
                            isFavorit = !isFavorit;
                            cookeryViewModel.update(
                                widget.currKey!,
                                widget.currCookery!.title,
                                widget.currCookery!.kind,
                                widget.currCookery!.img,
                                widget.currCookery!.desc,
                                widget.currCookery!.caution,
                                isFavorit,
                                widget.currCookery!.hit,
                                widget.currCookery!.ingredients); //todo 구현
                          });
                        })
                  ],
                ),
              ),
            )));
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
        Cookery? data = Cookery(
            title: titleController.text,
            kind: dropDownValue,
            img: _imageFilePath,
            desc: descController.text,
            caution: cautionController.text,
            heart: isFavorit,
            hit: 0,
            ingredients: itemsViewModel.getIngredientList());

        //print("goto edit page" + data.title + data.key.toString());
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: widget.currKey!, currCookery: widget.currCookery, isEditable: true)));

        break;
    }
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50, maxWidth: 600, maxHeight: 600);

    //새로 담길 파일 준비
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final now = DateTime.now();
    final newname = "KSH" + now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.microsecond.toString();
    final extension = pickedFile!.path.split('.').last;

    await pickedFile.saveTo('${documentDirectory.path}/$newname.$extension');

    File newFile = File('${documentDirectory.path}/$newname.$extension');
    if (newFile != null) {
      setState(() {
        _image = XFile(newFile.path); //가져온 이미지를 _image에 저장
        _imageFilePath = newFile.path;
        print("edit_page: Img New path: $_imageFilePath");
      });
    }
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
