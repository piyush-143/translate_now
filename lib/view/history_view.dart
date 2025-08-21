import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/database/local_dataBase/db_helper.dart';
import 'package:translate_now/view_modal/db_provider.dart';
import 'package:translate_now/widgets/history_fav_box.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DBProvider>(
        builder: (context, DBProvider value, _) {
          if (value.allHistoryData.isEmpty) {
            return const Center(
              child: Text(
                "No history available !\nDo some translation",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            itemCount: value.allHistoryData.length,
            padding: const EdgeInsets.only(bottom: 100, top: 15),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
            itemBuilder: (context, index) {
              return HistoryFavBox(
                sno: value.allHistoryData[index][DBHelper.hSno],
                sourceLang: value.allHistoryData[index][DBHelper.hSourceLang],
                sourceText: value.allHistoryData[index][DBHelper.hSourceName],
                targetLang: value.allHistoryData[index][DBHelper.hTargetLang],
                targetText: value.allHistoryData[index][DBHelper.hTargetName],
              );
            },
          );
        },
      ),
    );
  }
}
