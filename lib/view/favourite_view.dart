import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/widgets/history_fav_box.dart';

import '../database/local_dataBase/db_helper.dart';
import '../view_modal/db_provider.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DBProvider>(
        builder: (_, DBProvider value, __) {
          if (value.allFavouriteData.isEmpty) {
            return const Center(
              child: Text(
                "No favorite translations yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            itemCount: value.allFavouriteData.length,
            padding: const EdgeInsets.only(bottom: 100, top: 15),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
            itemBuilder: (ctx, index) {
              return HistoryFavBox(
                isFav: true,
                sno: value.allFavouriteData[index][DBHelper.fSno],
                sourceLang: value.allFavouriteData[index][DBHelper.fSourceLang],
                sourceText: value.allFavouriteData[index][DBHelper.fSourceName],
                targetLang: value.allFavouriteData[index][DBHelper.fTargetLang],
                targetText: value.allFavouriteData[index][DBHelper.fTargetName],
              );
            },
          );
        },
      ),
    );
  }
}
