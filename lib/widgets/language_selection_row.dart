import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';

import '../utils/app_colors.dart';

class LanguageSelectRow extends StatelessWidget {
  final bool isScript;
  const LanguageSelectRow({super.key, this.isScript = false});

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
              isScript
                  ? _buildDropDown(
                    isSource: false,
                    isScript: true,
                    languageProvider: languageProvider,
                    context: context,
                  )
                  : _buildDropDown(
                    isSource: true,
                    isScript: false,
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
                isScript: false,
                languageProvider: languageProvider,
                context: context,
              ),
              CircleAvatar(radius: 18),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDropDown({
  required bool isSource,
  required bool isScript,
  required TranslationProvider languageProvider,
  required BuildContext context,
}) {
  return DropdownButton(
    value:
        isScript
            ? languageProvider.script
            : (isSource
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
      isScript
          ? context.read<TranslationProvider>().setScript(value)
          : context.read<TranslationProvider>().setLanguage(isSource, value);
    },

    items:
        isScript
            ? TextRecognitionScript.values.map<DropdownMenuItem>((script) {
              return DropdownMenuItem<TextRecognitionScript>(
                value: script,
                child: Text(script.name),
              );
            }).toList()
            : TranslateLanguage.values.map<DropdownMenuItem>((lang) {
              return DropdownMenuItem<String>(
                value: lang.bcpCode,
                child: Text(lang.name),
              );
            }).toList(),
  );
}

Widget _buildScriptDropDown(
  TranslationProvider languageProvider,
  BuildContext context,
) {
  return DropdownButton(
    value: languageProvider.script,
    iconSize: 20,

    underline: Container(height: 1, color: AppColors().darkBlue),
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: AppColors().darkBlue,
    ),
    onChanged: (value) {
      context.read<TranslationProvider>().setScript(value);
    },
    items:
        TextRecognitionScript.values.map<DropdownMenuItem>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
  );
}
