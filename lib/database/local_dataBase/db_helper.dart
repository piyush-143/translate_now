import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  static const String historyTableName = "HistoryTable";
  static const String hSno = "HistorySno";
  static const String hSourceName = "SourceText";
  static const String hTargetName = "TargetText";
  static const String hSourceLang = "SourceLanguage";
  static const String hTargetLang = "TargetLanguage";

  static const String favouriteTableName = "FavouriteTable";
  static const String fSno = "FavouriteSno";
  static const String fSourceName = "SourceText";
  static const String fTargetName = "TargetText";
  static const String fSourceLang = "SourceLanguage";
  static const String fTargetLang = "TargetLanguage";

  Database? _myDb;

  Future<Database> getDb() async {
    if (_myDb != null) {
      return _myDb!;
    }
    _myDb = await openDb();
    return _myDb!;
  }

  Future<Database> openDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, "languageTranslatorDb.db");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "create table $historyTableName($hSno integer primary key autoincrement,$hSourceLang text,$hSourceName text,$hTargetLang text,$hTargetName text)",
        );
        db.execute(
          "create table $favouriteTableName($fSno integer primary key autoincrement,$fSourceLang text,$fSourceName text,$fTargetLang text,$fTargetName text)",
        );
      },
      version: 1,
    );
  }

  Future<bool> addData({
    required String sourceLang,
    required String targetLang,
    required String sourceText,
    required String targetText,
    required bool isHistory,
  }) async {
    var db = await getDb();

    int rowEffected =
        isHistory
            ? await db.insert(historyTableName, {
              hSourceLang: sourceLang,
              hSourceName: sourceText,
              hTargetLang: targetLang,
              hTargetName: targetText,
            })
            : await db.insert(favouriteTableName, {
              fSourceLang: sourceLang,
              fSourceName: sourceText,
              fTargetLang: targetLang,
              fTargetName: targetText,
            });
    return rowEffected > 0;
  }

  Future<bool> deleteData({required int sno, required bool isHistory}) async {
    var db = await getDb();

    int rowEffected =
        isHistory
            ? await db.delete(
              historyTableName,
              where: "$hSno=?",
              whereArgs: [sno],
            )
            : await db.delete(
              favouriteTableName,
              where: "$fSno=?",
              whereArgs: [sno],
            );

    return rowEffected > 0;
  }

  Future<bool> clearAllData({required bool isHistory}) async {
    var db = await getDb();

    int rowEffected =
        isHistory
            ? await db.rawDelete("DELETE FROM $historyTableName")
            : await db.rawDelete("DELETE FROM $favouriteTableName");
    return rowEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllData({
    required bool isHistory,
  }) async {
    var db = await getDb();
    List<Map<String, dynamic>> data =
        isHistory
            ? await db.query(historyTableName, orderBy: "$hSno DESC")
            : await db.query(favouriteTableName, orderBy: "$fSno DESC");
    return data;
  }
}
