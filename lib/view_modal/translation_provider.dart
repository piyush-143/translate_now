import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationProvider with ChangeNotifier {
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

  String _recognizedText = "";
  String get recognizedText => _recognizedText;
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

  bool _translationDone = false;
  bool get translationDone => _translationDone;
  void setTranslationDone(bool isDone) {
    _translationDone = isDone;
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
  void resetOutputText() {
    _outputText = "";
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
  void resetImgOutputText() {
    _imgOutputText = "";
    notifyListeners();
  }

  TranslateLanguage _targetLanguage = TranslateLanguage.hindi;
  TranslateLanguage get targetLanguage => _targetLanguage;
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage get sourceLanguage => _sourceLanguage;

  void setLanguage(bool isSource, String code) {
    final lang = BCP47Code.fromRawValue(code); // Fixed this line
    if (lang != null) {
      isSource ? _sourceLanguage = lang : _targetLanguage = lang;
      notifyListeners();
    }
  }
}
