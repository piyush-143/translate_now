import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/widgets/custom_buttons.dart';

import '../view_modal/speech_to_text_provider.dart';
import '../view_modal/translation_provider.dart';

class LanguageSelectRow extends StatelessWidget {
  final bool isImg;
  final bool isChat;
  const LanguageSelectRow({super.key, this.isImg = false, this.isChat = false});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<TranslationProvider>();
    final speechToTextProvider = context.watch<SpeechToTextProvider>();

    return Container(
      height: 47,
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors().lightPurple,
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
          Row(
            children: [
              isChat
                  ? CustomButtons().customMicButton(
                    onTap: () async {
                      final sttProvider = context.read<SpeechToTextProvider>();
                      if (sttProvider.leftSpeechToText.isNotListening) {
                        await sttProvider.startListening();
                      } else {
                        await sttProvider.stopListening();
                        if (sttProvider.lastLeftWord.isNotEmpty) {
                          await context
                              .read<TranslationProvider>()
                              .translateText(
                                input: sttProvider.lastLeftWord,
                                isChat: true,
                              );
                          sttProvider.addConversation({
                            "isLeft": true,
                            "source": sttProvider.lastLeftWord,
                            "target": languageProvider.chatOutputText,
                          });
                        }
                      }
                    },
                    icon:
                        speechToTextProvider.isLeftMicActive
                            ? Icons.mic
                            : Icons.mic_off,
                    color: AppColors().darkBlue,
                  )
                  : CircleAvatar(
                    radius: 18,
                    child: CountryFlag.fromLanguageCode(
                      isImg ? "en" : languageProvider.sourceLanguage.bcpCode,
                      shape: const Circle(),
                    ),
                  ),
              isImg
                  ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "english",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: AppColors().darkBlue,
                      ),
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
              isChat
                  ? CustomButtons().customMicButton(
                    onTap: () async {
                      final sttProvider = context.read<SpeechToTextProvider>();
                      if (sttProvider.rightSpeechToText.isNotListening) {
                        await sttProvider.startListening(isLeft: false);
                      } else {
                        await sttProvider.stopListening(isLeft: false);
                        if (sttProvider.lastRightWord.isNotEmpty) {
                          await context
                              .read<TranslationProvider>()
                              .translateText(
                                input: sttProvider.lastRightWord,
                                isChat: true,
                              );
                          sttProvider.addConversation({
                            "isLeft": false,
                            "source": sttProvider.lastRightWord,
                            "target": languageProvider.chatOutputText,
                          });
                        }
                      }
                    },
                    icon:
                        speechToTextProvider.isRightMicActive
                            ? Icons.mic
                            : Icons.mic_off,
                    color: AppColors().darkOrange,
                  )
                  : CircleAvatar(
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
  return DropdownButton<String>(
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
