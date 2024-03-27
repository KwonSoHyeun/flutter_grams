import 'package:grams/services/local_repository.dart';

import '../model/cookery.dart';

class LocalController{
  final repo = LocalRepository();

  add(Cookery data) {
    repo.add(data);
  }

  List<Cookery> getAll()  {
    return repo.getAll();
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
