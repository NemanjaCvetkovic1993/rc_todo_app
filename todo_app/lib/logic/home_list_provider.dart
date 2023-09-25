import 'package:flutter/foundation.dart';

import '../data/home_list_data.dart';

class HomeListProvider extends ChangeNotifier {
  String listName = dataHomeList[0].listName;
  Stream stream = dataHomeList[0].stream;

  void updateList({required String newListName, required Stream newStream}) {
    listName = newListName;
    stream = newStream;
    notifyListeners();
  }
}
