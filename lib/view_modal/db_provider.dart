import 'package:flutter/foundation.dart';
import 'package:translate_now/database/local_dataBase/db_helper.dart';

class DBProvider with ChangeNotifier {
  final DBHelper _dbRef = DBHelper.getInstance;

  List<Map<String, dynamic>> _allHistoryData = [];
  List<Map<String, dynamic>> get allHistoryData => _allHistoryData;

  List<Map<String, dynamic>> _allFavouriteData = [];
  List<Map<String, dynamic>> get allFavouriteData => _allFavouriteData;

  Future<void> getData() async {
    _allHistoryData = await _dbRef.getAllData(isHistory: true);
    _allFavouriteData = await _dbRef.getAllData(isHistory: false);
    notifyListeners();
  }

  Future<void> addData({
    required bool isHistory,
    required String sourceLang,
    required String targetLang,
    required String sourceText,
    required String targetText,
  }) async {
    bool check = await _dbRef.addData(
      sourceLang: sourceLang,
      targetLang: targetLang,
      sourceText: sourceText,
      targetText: targetText,
      isHistory: isHistory,
    );
    if (check) {
      isHistory
          ? _allHistoryData = await _dbRef.getAllData(isHistory: true)
          : _allFavouriteData = await _dbRef.getAllData(isHistory: false);
      notifyListeners();
    }
  }

  Future<void> deleteData({required int sno, required bool isHistory}) async {
    bool check = await _dbRef.deleteData(sno: sno, isHistory: isHistory);
    if (check) {
      isHistory
          ? _allHistoryData = await _dbRef.getAllData(isHistory: true)
          : _allFavouriteData = await _dbRef.getAllData(isHistory: false);
      notifyListeners();
    }
  }

  Future<void> clearAllData({required bool isHistory}) async {
    bool check = await _dbRef.clearAllData(isHistory: isHistory);
    if (check) {
      isHistory
          ? _allHistoryData = await _dbRef.getAllData(isHistory: true)
          : _allFavouriteData = await _dbRef.getAllData(isHistory: false);
      notifyListeners();
    }
  }
}
