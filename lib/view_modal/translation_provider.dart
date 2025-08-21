import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationProvider with ChangeNotifier {
  TranslateLanguage _targetLanguage = TranslateLanguage.hindi;
  TranslateLanguage get targetLanguage => _targetLanguage;
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage get sourceLanguage => _sourceLanguage;

  String _recognizedText = "";
  String get recognizedText => _recognizedText;

  String _chatOutputText = '';
  String get chatOutputText => _chatOutputText;

  String _imgOutputText = '';
  String get imgOutputText => _imgOutputText;

  bool _translationDone = false;
  bool get translationDone => _translationDone;

  bool _addedToFav = false;
  bool get addedToFav => _addedToFav;

  void setLanguage(bool isSource, String code) {
    final lang = BCP47Code.fromRawValue(code); // Fixed this line
    if (lang != null) {
      isSource ? _sourceLanguage = lang : _targetLanguage = lang;
      notifyListeners();
    }
  }

  Future<void> translateText({
    required String input,
    bool isImgRecognizer = false,
    bool isChat = false,
  }) async {
    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );

    try {
      final translatedValue = await onDeviceTranslator.translateText(input);
      if (isChat) {
        _chatOutputText = translatedValue;
      } else if (isImgRecognizer) {
        _imgOutputText = translatedValue;
      } else {
        _outputText = translatedValue;
      }
      setTranslationDone(true);
    } catch (e) {
      if (kDebugMode) {
        print('Translation error: $e');
      }
    }
  }

  Future<void> translateImage({required String imgPath}) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(imgPath);
    final recognized = await textRecognizer.processImage(inputImage);
    _recognizedText = recognized.text;
    notifyListeners();
  }

  void resetRecognized() {
    _recognizedText = "";
  }

  void setTranslationDone(bool isDone) {
    _translationDone = isDone;
    notifyListeners();
  }

  void setAddedToFav(bool isAdded) {
    _addedToFav = isAdded;
    notifyListeners();
  }

  String _outputText = '';
  String get outputText => _outputText;
  void resetOutputText() {
    _outputText = "";
    notifyListeners();
  }

  void setChatOutputText(String text) {
    _chatOutputText = text;
    notifyListeners();
  }

  void resetImgOutputText() {
    _imgOutputText = "";
    notifyListeners();
  }
}
