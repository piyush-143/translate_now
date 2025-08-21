import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider with ChangeNotifier {
  String _imagePath = '';
  String get imagePath => _imagePath;

  File? _image;
  File? get image => _image;

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      _imagePath = image.path;
      _image = File(_imagePath);
      notifyListeners();
    }
  }

  void resetImg() {
    _image = null;
    _imagePath = "";
    notifyListeners();
  }
}
