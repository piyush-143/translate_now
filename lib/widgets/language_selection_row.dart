import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';

import '../utils/app_colors.dart';

class LanguageSelectRow extends StatelessWidget {
  final bool isImg;
  const LanguageSelectRow({super.key, this.isImg = false});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<TranslationProvider>();
    return Container(
      height: 47,
      width: 320,
      margin: EdgeInsets.symmetric(horizontal: 15),
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
              CircleAvatar(
                radius: 18,
                child: CountryFlag.fromLanguageCode(
                  isImg ? "en" : languageProvider.sourceLanguage.bcpCode,
                  shape: const Circle(),
                ),
              ),
              isImg
                  ? Text(
                    "english",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: AppColors().darkBlue,
                    ),
                  )
                  : _buildDropDown(
                    isSource: true,
                    languageProvider: languageProvider,
                    context: context,
                  ),
            ],
          ),
          Icon(Icons.swap_horiz_outlined, color: AppColors().darkBlue),
          Row(
            children: [
              _buildDropDown(
                isSource: false,
                languageProvider: languageProvider,
                context: context,
              ),
              CircleAvatar(
                radius: 18,
                child: CountryFlag.fromLanguageCode(
                  languageProvider.targetLanguage.bcpCode,
                  shape: const Circle(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDropDown({
  required bool isSource,
  required TranslationProvider languageProvider,
  required BuildContext context,
}) {
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
      context.read<TranslationProvider>().setTranslationDone(false);
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
