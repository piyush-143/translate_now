import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationProvider with ChangeNotifier {
  Future<void> translateText({required String input}) async {
    setLoading(true);
    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );
    // await Future.delayed(Duration(seconds: 300));
    await onDeviceTranslator.translateText(input).then((value) {
      setLoading(false);
      setTranslationDone(true);
      _outputText = value;
      notifyListeners();
    });
  }

  String _recognizedText = "";
  String get recognizedText => _recognizedText;

  Future<void> translateImage({required String imgPath}) async {
    var recognized = await TextRecognizer(
      script: _script,
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

  String _outputText = '';
  String get outputText => _outputText;
  void setOutputText(String text) {
    _outputText = text;
    notifyListeners();
  }

  bool loading = false;
  void setLoading(bool isLoading) {
    loading = isLoading;
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

  TextRecognitionScript _script = TextRecognitionScript.latin;
  TextRecognitionScript get script => _script;
  void setScript(TextRecognitionScript scrpt) {
    _script = scrpt;
    notifyListeners();
  }
}
