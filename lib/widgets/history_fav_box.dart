import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/db_provider.dart';
import 'package:translate_now/widgets/custom_buttons.dart';

import '../utils/app_colors.dart';

class HistoryFavBox extends StatelessWidget {
  final bool isFav;
  final int sno;
  final String sourceLang;
  final String sourceText;
  final String targetLang;
  final String targetText;

  const HistoryFavBox({
    required this.sourceLang,
    required this.targetLang,
    required this.sourceText,
    required this.targetText,
    super.key,
    required this.sno,
    this.isFav = false,
  });

  @override
  Widget build(BuildContext context) {
    final dbProvider = context.read<DBProvider>();
    return Container(
      height: 107,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.solid,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChatRow(
              isSource: true,
              lang: sourceLang,
              text: sourceText,
              isFav: isFav,
              dbProvider: dbProvider,
              sno: sno,
            ),
            Divider(color: Colors.grey.shade400, height: 10),
            _buildChatRow(
              isSource: false,
              lang: targetLang,
              text: targetText,
              isFav: isFav,
              dbProvider: dbProvider,
              sno: sno,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatRow({
    required bool isSource,
    required String lang,
    required String text,
    required bool isFav,
    required DBProvider dbProvider,
    required int sno,
  }) {
    return Expanded(
      child: Row(
        children: [
          Text(
            lang,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSource ? AppColors.darkBlue : AppColors.darkOrange,
              ),
            ),
          ),
          if (isSource)
            _buildActionButton(isFav: isFav, dbProvider: dbProvider, sno: sno),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required bool isFav,
    required DBProvider dbProvider,
    required int sno,
  }) {
    if (isFav) {
      return CustomButtons().iconButton(
        onTap: () => dbProvider.deleteData(sno: sno, isHistory: false),
        icon: Icons.star,
        color: AppColors.darkBlue,
      );
    } else {
      return CustomButtons().iconButton(
        onTap: () => dbProvider.deleteData(sno: sno, isHistory: true),
        icon: Icons.delete,
        color: AppColors.darkBlue,
      );
    }
  }
}
