import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationProvider with ChangeNotifier {
  Future<void> translateText({
    required String input,
    bool isImgRecognizer = false,
    bool isChat = false,
  }) async {
    setLoading(true);
    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
    await Future.delayed(Duration(seconds: 1));
    await onDeviceTranslator.translateText(input).then((value) {
      setLoading(false);
      setTranslationDone(true);
      isChat
          ? _chatOutputText = value
          : isImgRecognizer
          ? _imgOutputText = value
          : _outputText = value;
      notifyListeners();
    });
  }

  String _recognizedText = "";
  String get recognizedText => _recognizedText;
  Future<void> translateImage({required String imgPath}) async {
    var recognized = await TextRecognizer(
      script: TextRecognitionScript.latin,
    ).processImage(InputImage.fromFilePath(imgPath));
    _recognizedText = recognized.text;
    notifyListeners();
  }

  bool _translationDone = false;
  bool get translationDone => _translationDone;
  void setTranslationDone(bool isDone) {
    _translationDone = isDone;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  bool _addedToFav = false;
  bool get addedToFav => _addedToFav;
  void setAddedToFav(bool isAdded) {
    _addedToFav = isAdded;
    notifyListeners();
  }

  String _outputText = '';
  String get outputText => _outputText;
  void setOutputText(String text) {
    _outputText = text;
    notifyListeners();
  }

  String _chatOutputText = '';
  String get chatOutputText => _chatOutputText;
  void setChatOutputText(String text) {
    _chatOutputText = text;
    notifyListeners();
  }

  String _imgOutputText = '';
  String get imgOutputText => _imgOutputText;
  void setImgOutputText(String text) {
    _imgOutputText = text;
    notifyListeners();
  }

  TranslateLanguage _targetLanguage = TranslateLanguage.hindi;
  TranslateLanguage get targetLanguage => _targetLanguage;
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage get sourceLanguage => _sourceLanguage;
  void setLanguage(bool isSource, String code) {
    final lang = BCP47Code.fromRawValue(code);
    if (lang != null) {
      isSource ? _sourceLanguage = lang : _targetLanguage = lang;
      notifyListeners();
    }
  }
}
