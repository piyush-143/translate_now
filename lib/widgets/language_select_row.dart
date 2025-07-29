import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';

import '../utils/app_colors.dart';

class LanguageSelectRow extends StatelessWidget {
  const LanguageSelectRow({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<TranslationProvider>();
    return Container(
      height: 47,
      width: 320,
      decoration: BoxDecoration(
        color: AppColors().lightPurple,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.solid,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 18),

              _buildDropDown(true, languageProvider, context),
            ],
          ),
          Icon(Icons.swap_horiz_outlined, color: AppColors().darkBlue),
          Row(
            children: [
              _buildDropDown(false, languageProvider, context),
              CircleAvatar(radius: 18),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDropDown(
  bool isSource,
  TranslationProvider languageProvider,
  BuildContext context,
) {
  return DropdownButton(
    value:
        (isSource
                ? languageProvider.sourceLanguage
                : languageProvider.targetLanguage)
            .bcpCode,
    iconSize: 0,
    menuMaxHeight: 650,
    alignment: Alignment.center,
    underline: Container(height: 1, color: AppColors().darkBlue),
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: AppColors().darkBlue,
    ),
    onChanged: (value) {
      context.read<TranslationProvider>().setLanguage(isSource, value);
    },

    items:
        TranslateLanguage.values.map<DropdownMenuItem>((lang) {
          return DropdownMenuItem<String>(
            value: lang.bcpCode,
            child: Text(lang.name),
          );
        }).toList(),
  );
}
