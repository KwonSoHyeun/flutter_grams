import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grams/screen/widgets/ingrdient_custom_widget.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class EditCookeryPage extends StatefulWidget {
  final String? currKey;
  final Cookery? currCookery;
  final bool isEditable;

  //EditCookeryPage(this.index, this.currCookery, this.isEditable, [Cookery? currcookery]);
  EditCookeryPage({this.currKey = "", this.currCookery, this.isEditable = true});

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
  late String dropDownValue = AppConst.cookingKindList[0];
  bool isFavorit = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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

      itemsViewModel.initItemWidgetList(editCookery!.ingredients!, widget.isEditable);
      isFavorit = editCookery!.heart;
    }

    // if (editCookery == null) {
    //   itemsViewModel.defaultIngredientWidget();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.isEditable ? AppLocalizations.of(context)!.title_edit : AppLocalizations.of(context)!.title_calculate),
          shape: const Border(
            bottom: BorderSide(
              color: AppColor.lineColor2,
              width: 1,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.favorite),
                color: isFavorit ? Colors.red[600] : Colors.grey,
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    isFavorit = !isFavorit;
                    if (widget.currKey!.isNotEmpty) {
                      cookeryViewModel.update(
                          widget.currKey!,
                          widget.currCookery!.img,
                          widget.currCookery!.title,
                          widget.currCookery!.kind,
                          widget.currCookery!.img,
                          widget.currCookery!.desc,
                          widget.currCookery!.caution,
                          isFavorit,
                          widget.currCookery!.hit,
                          widget.currCookery!.ingredients);
                    }
                  });
                }),

//앱바 : 신규저장
            Visibility(
              visible: editCookery == null && widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.save),
                color: AppColor.primaryMenuColor,
                tooltip: 'Save new data',
                onPressed: () {
                  final formKeyState = _formKey.currentState!;
                  if (formKeyState.validate()) {
                    cookeryViewModel.addCookery(titleController.text, dropDownValue, _imageFilePath, descController.text, cautionController.text, isFavorit, 0,
                        itemsViewModel.getIngredientList());
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
                color: AppColor.primaryMenuColor,
                tooltip: 'Update data',
                onPressed: () {
                  final formKeyState = _formKey.currentState!;
                  if (formKeyState.validate()) {
                    cookeryViewModel.update(widget.currKey!, widget.currCookery!.img, titleController.text, dropDownValue, _imageFilePath, descController.text,
                        cautionController.text, isFavorit, 0, itemsViewModel.getIngredientList());
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
//앱바: 삭제
            Visibility(
              visible: widget.isEditable ,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: widget.currKey !=null && widget.currKey!.isNotEmpty ? AppColor.AccentColor : Colors.grey[400],
                tooltip: 'Delete',
                onPressed: widget.currKey !=null && widget.currKey!.isEmpty
                    ? null
                    : () {
                        _showdialog(context);
                      },
              ),
            ),
//앱바: 에디트 모드로 이동
            Visibility(
              visible: editCookery != null && !widget.isEditable,
              child: IconButton(
                icon: const Icon(Icons.edit),
                color: AppColor.primaryMenuColor,
                tooltip: 'Go to edit mode',
                onPressed: () {
                  handleClick(1);
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            reverse: false,
            padding: EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(children: <Widget>[
                              Flexible(
                                  flex: 13,
                                  child: Container(
                                    width: double.infinity,
                                    child: widget.isEditable
                                        ? TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty)
                                                return AppLocalizations.of(context)!.validation_msg1;
                                              else
                                                return null;
                                            },
                                            scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                            controller: titleController,
                                            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.hint_title),
                                            maxLength: 100,
                                            keyboardType: TextInputType.text,
                                          )
                                        : Text(
                                            editCookery!.title,
                                            style: TextStyle(fontSize: 16, color: AppColor.primaryTextColor),
                                          ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                  )),
                              Flexible(
                                flex: 5,
                                child: Container(
                                    width: double.infinity,
                                    child: widget.isEditable
                                        ? SelectKindWidget(
                                            callback: (value) => setState(() {
                                              dropDownValue = value;
                                            }),
                                            init: dropDownValue,
                                          )
                                        : Text(AppLocalizations.of(context)!.hint_kind + ":" + AppLocalizations.of(context)!.cookType(editCookery!.kind),
                                            style: const TextStyle(
                                                fontSize: 16, // 폰트 크기
                                                color: AppColor.primaryTextColor))), // TextStyle
                              )
                            ]),
                            widget.isEditable
                                ? TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return AppLocalizations.of(context)!.validation_msg2;
                                      else
                                        return null;
                                    },
                                    controller: descController,
                                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.hint_desc),
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
                                  visible: widget.isEditable || !widget.isEditable && _imageFilePath.isNotEmpty,
                                  //child: PhotoAreaWidget(_image),
                                  child: _image != null
                                      ? _image!.path != AppConst.sampleFileName
                                          ? Container(
                                              width: 150,
                                              height: 150,
                                              //child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(image: FileImage(File(_image!.path)), fit: BoxFit.cover),
                                              ),
                                            )
                                          : Container(
                                              //for sample data
                                              width: 150,
                                              height: 150,

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(image: AssetImage(_image!.path), fit: BoxFit.cover),
                                              ),
                                            )
                                      : Container(
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          alignment: Alignment.center,
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(image: AssetImage('assets/photos/cook_icon1.png'), fit: BoxFit.cover),
                                          ),
                                        ),
                                ),
                                SizedBox(height: 10),
                                widget.isEditable ? _buildButton() : Text(""),
                              ],
                            ),
                            widget.isEditable
                                ? TextFormField(
                                    controller: cautionController,
                                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.hint_caution),
                                    maxLength: 200,
                                    keyboardType: TextInputType.text,
                                  )
                                : Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    // alignment: Alignment(0.0, 0.0),
                                    child: Text(editCookery!.caution, textAlign: TextAlign.left),
                                  ),
                          ],
                        )),

                    //const Padding(padding: EdgeInsets.all(10)),
                    //재료명, 중량, 단위를 다수개 등록

                    showIngredientTitle(context),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                        child: Consumer<ItemsViewModel>(builder: (context, provider, child) {
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

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )));
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        widget.currCookery!.ingredients = itemsViewModel.getIngredientList();
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditCookeryPage(currKey: widget.currKey!, currCookery: widget.currCookery, isEditable: true)));
        break;
    }
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource, imageQuality: 50, maxWidth: 600, maxHeight: 600);
    if (pickedFile == null) return;

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

  Future<dynamic> _showdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.dialog_msg_delete_confirm),
        content: Text(AppLocalizations.of(context)!.dialog_msg_delete),
        actions: [
          ElevatedButton(
              onPressed: () async {
                cookeryViewModel.delete(widget.currKey!, widget.currCookery!);
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.dialog_button_ok)),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.dialog_button_cancel)),
        ],
      ),
    );
  }

  Widget showIngredientTitle(BuildContext context) {
    return Container(
        color: AppColor.bgHome,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                // 커스텀 위젯의 내용
                children: [
                  Text(AppLocalizations.of(context)!.hint_ingredient_title, style: TextStyle(fontSize: 14, color: AppColor.lineColor1)),
                  const SizedBox(
                    width: 8,
                    height: 40,
                  ),
                  Text(AppLocalizations.of(context)!.hint_ingredient_rate, style: TextStyle(fontSize: 14, color: AppColor.lineColor1)),
                  const SizedBox(
                    width: 8,
                    height: 40,
                  ),
                  Text(AppLocalizations.of(context)!.hint_ingredient_unit, style: TextStyle(fontSize: 14, color: AppColor.lineColor1)),
                  const SizedBox(
                    width: 8,
                    height: 40,
                  ),
                ]),
            Visibility(
                visible: !widget.isEditable,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
                  height: 30,
                  child: Text(
                    AppLocalizations.of(context)!.description_msg1,
                    style: TextStyle(fontSize: 14, color: AppColor.primaryTextColor2),
                  ),
                )),
          ],
        ));
  }
}
