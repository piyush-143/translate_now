import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextProvider with ChangeNotifier {
  final SpeechToText _leftSpeechToText = SpeechToText();
  final SpeechToText _rightSpeechToText = SpeechToText();

  SpeechToText get leftSpeechToText => _leftSpeechToText;
  SpeechToText get rightSpeechToText => _rightSpeechToText;

  bool leftSpeechEnabled = false;
  bool rightSpeechEnabled = false;

  bool _isLeftMicActive = false;
  bool get isLeftMicActive => _isLeftMicActive;

  bool _isRightMicActive = false;
  bool get isRightMicActive => _isRightMicActive;

  String _lastLeftWord = "";
  String get lastLeftWord => _lastLeftWord;

  String _lastRightWord = "";
  String get lastRightWord => _lastRightWord;

  List<Map<String, dynamic>> _chatList = [];
  List<Map<String, dynamic>> get conversationList => _chatList;

  Future<void> initSpeech() async {
    leftSpeechEnabled = await _leftSpeechToText.initialize();
    rightSpeechEnabled = await _rightSpeechToText.initialize();
    notifyListeners();
  }

  Future<void> startListening({bool isLeft = true}) async {
    if (isLeft) {
      _isLeftMicActive = true;
      notifyListeners();
      await _leftSpeechToText
          .listen(
            onResult: (result) {
              _lastLeftWord = result.recognizedWords;
              notifyListeners(); // Update UI for left mic only
            },
          )
          .whenComplete(() {
            _isLeftMicActive = false;
            notifyListeners();
          });
    } else {
      _isRightMicActive = true;
      notifyListeners();
      await _rightSpeechToText.listen(
        onResult: (result) {
          _lastRightWord = result.recognizedWords;
          _isRightMicActive = false;
          notifyListeners(); // Update UI for right mic only
        },
      );
    }
  }

  Future<void> stopListening({bool isLeft = true}) async {
    if (isLeft) {
      await _leftSpeechToText.stop();
    } else {
      await _rightSpeechToText.stop();
    }
    notifyListeners();
  }

  void addConversation(Map<String, dynamic> chat) {
    _chatList.add(chat);
    notifyListeners();
  }
}
