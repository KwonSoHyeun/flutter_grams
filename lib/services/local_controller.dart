import 'package:grams/model/ingredient.dart';
import 'package:grams/services/local_repository.dart';

import '../model/cookery.dart';

class LocalController {
  final repo = LocalRepository();

  add(Cookery data) {
    repo.add( data);
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

  addTestData() {
    List<Cookery> list = [
      Cookery( title: '새우볶음밥', kind: 'main', img: '', desc: '1. 크고 맛있는 새우를 산다. ', caution: '익은 새우를 사용할것', heart: false, hit: 0, ingredients: [
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
      repo.add( value);
    }

  }
}
