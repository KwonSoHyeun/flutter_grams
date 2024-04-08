import 'package:grams/services/local_repository.dart';

import '../model/cookery.dart';

class LocalController{
  final repo = LocalRepository();

  add(Cookery data) {
    repo.add(data);
  }

  List<Cookery> getAll({String search=""})  {

    List<Cookery> originalList = repo.getAll();

    List<Cookery> filteredlList = originalList.where((i) => i.title.contains(search)).toList();
//List<Cookery> filteredlList = originalList.where((element) { return element.title.contains(search) ;});

    return filteredlList;

  }



  Cookery? getAtIndex(int index) {
    return repo.getAtIndex(index);
  }

  update(int index, Cookery data) {
    repo.update(index, data);
  }

  delete(int id) {
    repo.delete(id);
  }
}
