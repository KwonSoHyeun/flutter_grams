import 'dart:ui';

import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_repository.dart';
import 'package:grams/util/colorvalue.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:grams/util/colorvalue.dart';
import '../model/cookery.dart';

class LocalController {
  final repo = LocalRepository();

  add(Cookery data) {
    repo.add(data);
  }

  List<Cookery> getAll({String search = ""}) {
    //addTestData();
    List<Cookery> originalList = repo.getAll();
    List<Cookery> filteredlList = originalList.where((i) => i.title.contains(search)).toList();
    return filteredlList;
  }

  Cookery? getAtIndex(int index) {
    return repo.getAtIndex(index);
  }

  update(String key, Cookery data) {
    repo.update(key, data);
  }

  delete(String key) {
    repo.delete(key);
  }

  addTestData1_en() {
    List<Cookery> list = [
      Cookery(
          title: 'Pumpkin Soup(Sample)',
          kind: 'side',
          img: AppConst.sampleFileName,
          desc:
              '1.Prepare the sweet pumpkin by removing the seeds, cutting it into large pieces and cooking it on the stove or in a steamer. \n2.Add boiled pumpkin flesh and sauteed onion to a blender and milk and grind finely. \n3.Stir with a spatula and bring to a boil.. Add a little salt.',
          caution: 'It tastes better with croutons',
          heart: false,
          hit: 0,
          ingredients: [
            Ingredient(name: 'sweet pumpkin', count: 1.0, unit: 'kg'),
            Ingredient(name: 'onion', count: 150, unit: 'g'),
            Ingredient(name: 'milk', count: 600, unit: 'ml'),
            Ingredient(name: 'olive oil', count: 1.0, unit: 'tbsp'),
            Ingredient(name: 'salt', count: 1.0, unit: 'g')
          ])
    ];
    for (Cookery value in list) {
      repo.add(value);
    }
  }

  addTestData1_ko() {
    List<Cookery> list = [
      Cookery(
          title: '단호박 스프(샘플)',
          kind: 'main',
          img: AppConst.sampleFileName,
          desc: '1.단호박을 껍질 벗겨서 푹 익힙니다.전기 밥솥이나 전자레인지도 사용가능 \n2.익힌 단호박, 우유, 노랗게 잘 볶은 양파와 함께 곱게 갈아줍니다.  \n3.분량의 소금을 넣고 저으면서 추가로 5분간 더 익혀줍니다 ',
          caution: '단호박은 압력솥에 익히는것이 맛있었음',
          heart: false,
          hit: 0,
          ingredients: [
            Ingredient(name: '단호박', count: 1.0, unit: 'kg'),
            Ingredient(name: '양파', count: 150, unit: 'g'),
            Ingredient(name: '우유', count: 600, unit: 'ml'),
            Ingredient(name: '올리브오일', count: 1.0, unit: 'tbsp'),
            Ingredient(name: '소금', count: 1.0, unit: 'g')
          ])
    ];

    for (Cookery value in list) {
      repo.add(value);
    }
  }

  addTestData2() {
    List<Cookery> list = [
      Cookery(title: '새우볶음밥', kind: 'main', img: '', desc: '1. 크고 맛있는 새우를 산다. ', caution: '익은 새우를 사용할것', heart: false, hit: 0, ingredients: [
        Ingredient(name: '새우', count: 200.0, unit: 'g'),
        Ingredient(name: '새우젓', count: 1.0, unit: '스푼'),
        Ingredient(name: '양파', count: 50.0, unit: 'g'),
        Ingredient(name: '정종', count: 800.0, unit: 'ml'),
        Ingredient(name: '설탕', count: 25.0, unit: 'g')
      ]),
      Cookery(title: '초고추장', kind: 'sauce', img: '', desc: '시판용 고추장으로 맛있게 만들어 먹자 ', caution: '청정원 고추장과 사이다가 키 포인트', heart: false, hit: 0, ingredients: [
        Ingredient(name: '김치', count: 200.0, unit: 'g'),
        Ingredient(name: '고춧가루', count: 1.0, unit: '스푼'),
        Ingredient(name: '새우젓', count: 1.0, unit: '스푼'),
        Ingredient(name: '돼지앞다리살', count: 200.0, unit: 'g'),
        Ingredient(name: '양파', count: 50.0, unit: 'g'),
        Ingredient(name: '물', count: 800.0, unit: 'ml'),
        Ingredient(name: '설탕', count: 25.0, unit: 'g')
      ]),
      Cookery(
          title: '김치찌개1',
          kind: 'side',
          img: '',
          desc: '1. 익은김치를 잘게썬다 2. 물과함께 끓인후 돼지고기를 넣는다. 3.새우젓으로 간를 맞춘다,',
          caution: '익은 김치릉 사용할것',
          heart: true,
          hit: 0,
          ingredients: [
            Ingredient(name: '김치', count: 200.0, unit: 'g'),
            Ingredient(name: '고춧가루', count: 1.0, unit: '스푼'),
            Ingredient(name: '새우젓', count: 1.0, unit: '스푼'),
            Ingredient(name: '돼지앞다리살', count: 200.0, unit: 'g'),
            Ingredient(name: '양파', count: 50.0, unit: 'g'),
            Ingredient(name: '물', count: 800.0, unit: 'ml'),
            Ingredient(name: '설탕', count: 25.0, unit: 'g')
          ]),
      Cookery(
          title: '잡채밥1',
          kind: 'main',
          img: '',
          desc: '1. 당면을 물에 불린다. 2. 간장양념을 만들어 끓인후 불린당면을 넣어 같이 볶는다 . 볶은 야채를 같이 넣고 버무린다. 4. 참기름과 간장으로 마무리',
          caution: '미온수에 당면을 불리면 1시간 걸림',
          hit: 2,
          heart: true,
          ingredients: [
            Ingredient(name: '당면', count: 1200.0, unit: 'g'),
            Ingredient(name: '간장양념', count: 100.0, unit: 'g'),
            Ingredient(name: '참기름', count: 1.0, unit: '스푼')
          ]),
      Cookery(
          title: '된장찌개',
          kind: 'side',
          img: '',
          desc: '1. 갖은 야채를 한입크기로 썬다. 2. 서산 된장을 풀어 간을 맞춘다.',
          caution: '된장에 따라 맛이 다름.',
          hit: 2,
          heart: true,
          ingredients: [
            Ingredient(name: '된장', count: 1200.0, unit: 'g'),
            Ingredient(name: '마늘', count: 100.0, unit: 'g'),
            Ingredient(name: '파', count: 1.0, unit: '스푼')
          ])
    ];

    for (Cookery value in list) {
      repo.add(value);
    }
  }

  init() async {
    //샘플데이타
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isExist = prefs.getBool('sample') ?? false;
    if (!isExist) {
      if (PlatformDispatcher.instance.locale.languageCode == "ko") {
        addTestData1_ko();
      } else {
        addTestData1_en();
      }
      prefs.setBool("sample", true);
    }
  }
}
