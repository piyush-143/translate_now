import 'package:flutter/material.dart';

class BottomAppBarProvider with ChangeNotifier {
  int _index = 2;
  int get index => _index;
  void setIndex({required int idx}) {
    _index = idx;
    notifyListeners();
  }
}
