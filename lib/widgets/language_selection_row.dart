import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../view_modal/speech_to_text_provider.dart';
import '../view_modal/translation_provider.dart';
import '../widgets/custom_buttons.dart';

class LanguageSelectRow extends StatelessWidget {
  final bool isImg;
  final bool isChat;

  const LanguageSelectRow({super.key, this.isImg = false, this.isChat = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.lightPurple,
        borderRadius: BorderRadius.circular(50),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSourceSelector(context),
          Icon(Icons.swap_horiz_outlined, color: AppColors.darkBlue),
          _buildTargetSelector(context),
        ],
      ),
    );
  }

  Widget _buildSourceSelector(BuildContext context) {
    final languageProvider = context.watch<TranslationProvider>();
    final speechToTextProvider = context.watch<SpeechToTextProvider>();

    if (isChat) {
      return _buildChatMicAndDropdown(
        context: context,
        isSource: true,
        languageProvider: languageProvider,
        speechToTextProvider: speechToTextProvider,
      );
    } else {
      return Row(
        children: [
          _buildFlagOrText(
            isSource: true,
            isImg: isImg,
            languageProvider: languageProvider,
          ),
          _buildLanguageNameOrDropdown(
            isSource: true,
            isImg: isImg,
            languageProvider: languageProvider,
            context: context,
          ),
        ],
      );
    }
  }

  Widget _buildTargetSelector(BuildContext context) {
    final languageProvider = context.watch<TranslationProvider>();
    final speechToTextProvider = context.watch<SpeechToTextProvider>();

    if (isChat) {
      return _buildChatMicAndDropdown(
        context: context,
        isSource: false,
        languageProvider: languageProvider,
        speechToTextProvider: speechToTextProvider,
      );
    } else {
      return Row(
        children: [
          _buildLanguageNameOrDropdown(
            isSource: false,
            isImg: isImg,
            languageProvider: languageProvider,
            context: context,
          ),
          _buildFlagOrText(
            isSource: false,
            isImg: isImg,
            languageProvider: languageProvider,
          ),
        ],
      );
    }
  }

  Widget _buildChatMicAndDropdown({
    required BuildContext context,
    required bool isSource,
    required TranslationProvider languageProvider,
    required SpeechToTextProvider speechToTextProvider,
  }) {
    return Row(
      children: [
        if (isSource)
          _buildChatButton(
            context,
            isLeft: true,
            speechToTextProvider: speechToTextProvider,
            languageProvider: languageProvider,
          )
        else
          _buildDropdown(
            isSource: isSource,
            languageProvider: languageProvider,
            context: context,
          ),
        if (isSource)
          _buildDropdown(
            isSource: isSource,
            languageProvider: languageProvider,
            context: context,
          )
        else
          _buildChatButton(
            context,
            isLeft: false,
            speechToTextProvider: speechToTextProvider,
            languageProvider: languageProvider,
          ),
      ],
    );
  }

  Widget _buildChatButton(
    BuildContext context, {
    required bool isLeft,
    required SpeechToTextProvider speechToTextProvider,
    required TranslationProvider languageProvider,
  }) {
    final bool isMicActive =
        isLeft
            ? speechToTextProvider.isLeftMicActive
            : speechToTextProvider.isRightMicActive;
    final iconColor = isLeft ? AppColors.darkBlue : AppColors.darkOrange;

    return CustomButtons().micButton(
      onTap: () async {
        if (isMicActive) {
          await speechToTextProvider.stopListening(isLeft: isLeft);
          final lastWord =
              isLeft
                  ? speechToTextProvider.lastLeftWord
                  : speechToTextProvider.lastRightWord;
          if (lastWord.isNotEmpty) {
            await languageProvider.translateText(input: lastWord, isChat: true);
            speechToTextProvider.addConversation({
              "isLeft": isLeft,
              "source": lastWord,
              "target": languageProvider.chatOutputText,
            });
          }
        } else {
          await speechToTextProvider.startListening(isLeft: isLeft);
        }
      },
      icon: isMicActive ? Icons.mic : Icons.mic_off,
      color: iconColor,
    );
  }

  Widget _buildFlagOrText({
    required bool isSource,
    required bool isImg,
    required TranslationProvider languageProvider,
  }) {
    if (isImg) {
      return CircleAvatar(
        radius: 18,
        child: CountryFlag.fromLanguageCode(
          isSource ? "en" : languageProvider.targetLanguage.bcpCode,
          shape: const Circle(),
        ),
      );
    } else {
      return CircleAvatar(
        radius: 18,
        child: CountryFlag.fromLanguageCode(
          (isSource
                  ? languageProvider.sourceLanguage
                  : languageProvider.targetLanguage)
              .bcpCode,
          shape: const Circle(),
        ),
      );
    }
  }

  Widget _buildLanguageNameOrDropdown({
    required bool isSource,
    required bool isImg,
    required TranslationProvider languageProvider,
    required BuildContext context,
  }) {
    if (isImg && isSource) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "english",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: AppColors.darkBlue,
          ),
        ),
      );
    } else {
      return _buildDropdown(
        isSource: isSource,
        languageProvider: languageProvider,
        context: context,
      );
    }
  }

  Widget _buildDropdown({
    required bool isSource,
    required TranslationProvider languageProvider,
    required BuildContext context,
  }) {
    final language =
        isSource
            ? languageProvider.sourceLanguage
            : languageProvider.targetLanguage;
    final color = isSource ? AppColors.darkBlue : AppColors.darkOrange;
    return DropdownButton<String>(
      value: language.bcpCode,
      iconSize: 0,
      menuMaxHeight: 650,
      alignment: Alignment.center,
      underline: Container(height: 1, color: color),
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: color),
      onChanged: (String? value) {
        if (value != null) {
          context.read<TranslationProvider>().setLanguage(isSource, value);
          context.read<TranslationProvider>().setTranslationDone(false);
        }
      },
      items:
          TranslateLanguage.values.map<DropdownMenuItem<String>>((lang) {
            return DropdownMenuItem<String>(
              value: lang.bcpCode,
              child: Text(lang.name),
            );
          }).toList(),
    );
  }
}
