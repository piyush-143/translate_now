import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextProvider with ChangeNotifier {
  final SpeechToText _leftSpeechToText = SpeechToText();
  SpeechToText get leftSpeechToText => _leftSpeechToText;
  final SpeechToText _rightSpeechToText = SpeechToText();
  SpeechToText get rightSpeechToText => _rightSpeechToText;
  bool leftSpeechEnabled = false;
  bool rightSpeechEnabled = false;

  Future<void> initSpeech() async {
    leftSpeechEnabled = await _leftSpeechToText.initialize();
    rightSpeechEnabled = await _rightSpeechToText.initialize();
    notifyListeners();
  }

  Future<void> startListening({bool isLeft = true}) async {
    isLeft
        ? await _leftSpeechToText.listen(onResult: _onSpeechResult)
        : await _rightSpeechToText.listen(onResult: _onSpeechResult);
    notifyListeners();
  }

  Future<void> stopListening({bool isLeft = true}) async {
    isLeft ? await _leftSpeechToText.stop() : await _rightSpeechToText.stop();
    notifyListeners();
  }

  String _lastWord = "";
  String get lastWord => _lastWord;
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWord = result.recognizedWords;
    notifyListeners();
  }

  List<Map<String, dynamic>> _chatList = [];
  List<Map<String, dynamic>> get conversationList => _chatList;
  void addConversation(Map<String, dynamic> chat) {
    _chatList.add(chat);
    notifyListeners();
  }
}
