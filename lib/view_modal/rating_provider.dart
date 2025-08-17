import 'package:flutter/material.dart';

class RatingProvider with ChangeNotifier {
  double _rating = 0;
  double get rating => _rating;
  void setRating(double rate) {
    _rating = rate;
    notifyListeners();
  }
}
