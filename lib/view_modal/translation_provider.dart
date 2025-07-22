import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationProvider with ChangeNotifier {
  String _outputText = '';
  String get outputText => _outputText;
  bool loading = false;
  bool _translationDone = false;
  bool get translationDone => _translationDone;
  Future<void> translateText({required String input}) async {
    setLoading(true);
    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.hindi,
    );
    // await Future.delayed(Duration(seconds: 300));
    await onDeviceTranslator.translateText(input).then((value) {
      setLoading(false);
      setTranslationDone(true);
      _outputText = value;
      notifyListeners();
    });
  }

  void setTranslationDone(bool isDone) {
    _translationDone = isDone;
    notifyListeners();
  }

  void setOutputText(String text) {
    _outputText = text;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    loading = isLoading;
    notifyListeners();
  }
}
