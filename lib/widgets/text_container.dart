import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view_modal/db_provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';
import 'package:translate_now/widgets/custom_icon_button.dart';

class TextContainer extends StatelessWidget {
  final bool isSource;
  final double width;
  final bool isImgRecognizer;
  final TextEditingController? textController;
  const TextContainer({
    super.key,
    this.isSource = false,
    this.isImgRecognizer = false,
    this.width = 340,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    final translationProvider = context.read<TranslationProvider>();
    final dbProvider = context.read<DBProvider>();
    final appColors = AppColors();

    return Container(
      width: width,
      height: 246,
      decoration: BoxDecoration(
        color: appColors.lightPurple,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      isSource
                          ? translationProvider.sourceLanguage.name
                          : translationProvider.targetLanguage.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: appColors.darkBlue,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // customIconButton(
                    //   onTap: () {},
                    //   icon: Icons.volume_up_outlined,
                    //   color: appColors.darkBlue,
                    // ),
                  ],
                ),
                customIconButton(
                  onTap:
                      isSource
                          ? () {
                            textController?.clear();
                            translationProvider.setAddedToFav(false);
                          }
                          : isImgRecognizer
                          ? () {
                            translationProvider.setImgOutputText("");
                            translationProvider.setTranslationDone(false);
                            translationProvider.setAddedToFav(false);
                          }
                          : () {
                            translationProvider.setOutputText("");
                            translationProvider.setTranslationDone(false);
                          },
                  icon: Icons.cancel_outlined,
                  color: appColors.darkBlue,
                ),
              ],
            ),
            isSource
                ? isImgRecognizer
                    ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          context.watch<TranslationProvider>().recognizedText,
                          softWrap: true,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, height: 1.1),
                        ),
                      ),
                    )
                    : Expanded(
                      child: TextFormField(
                        controller: textController,
                        keyboardType: TextInputType.text,
                        maxLines: 7,
                        style: const TextStyle(fontSize: 14, height: 1.2),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter text here...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      isImgRecognizer
                          ? context.watch<TranslationProvider>().imgOutputText
                          : context.watch<TranslationProvider>().outputText,
                      softWrap: true,
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, height: 1.1),
                    ),
                  ),
                ),
            if (isSource)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      final input =
                          isImgRecognizer
                              ? translationProvider.recognizedText
                              : textController?.text.toString() ?? '';
                      if (input.isNotEmpty) {
                        translationProvider
                            .translateText(
                              input: input,
                              isImgRecognizer: isImgRecognizer,
                            )
                            .whenComplete(() {
                              dbProvider.addData(
                                isHistory: true,
                                sourceLang:
                                    isImgRecognizer
                                        ? "en"
                                        : translationProvider
                                            .sourceLanguage
                                            .bcpCode,
                                targetLang:
                                    translationProvider.targetLanguage.bcpCode,
                                sourceText: input,
                                targetText:
                                    isImgRecognizer
                                        ? translationProvider.imgOutputText
                                            .toString()
                                        : translationProvider.outputText
                                            .toString(),
                              );
                            });
                        translationProvider.setAddedToFav(false);
                      }
                    },
                    child: Container(
                      width: 108,
                      height: 40,
                      decoration: BoxDecoration(
                        color: appColors.darkOrange,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                        child: Text(
                          "Translate",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customIconButton(
                    onTap: () async {
                      await FlutterClipboard.copy(
                        isImgRecognizer
                            ? translationProvider.imgOutputText
                            : translationProvider.outputText,
                      );
                    },
                    icon: Icons.copy_rounded,
                    color: appColors.darkBlue,
                  ),
                  const SizedBox(width: 20),
                  customIconButton(
                    onTap: () async {
                      final textToShare =
                          isImgRecognizer
                              ? translationProvider.imgOutputText
                              : translationProvider.outputText;
                      if (textToShare.isNotEmpty) {
                        await SharePlus.instance.share(
                          ShareParams(text: textToShare),
                        );
                      }
                    },
                    icon: Icons.share,
                    color: appColors.darkBlue,
                  ),
                  const SizedBox(width: 20),
                  customIconButton(
                    onTap: () {
                      dbProvider.addData(
                        isHistory: false,
                        sourceLang:
                            isImgRecognizer
                                ? "en"
                                : translationProvider.sourceLanguage.bcpCode,
                        targetLang: translationProvider.targetLanguage.bcpCode,
                        sourceText:
                            isImgRecognizer
                                ? translationProvider.recognizedText
                                : textController?.text.toString() ?? '',
                        targetText:
                            isImgRecognizer
                                ? translationProvider.imgOutputText.toString()
                                : translationProvider.outputText.toString(),
                      );
                      translationProvider.setAddedToFav(true);
                    },
                    icon:
                        context.watch<TranslationProvider>().addedToFav
                            ? Icons.star
                            : Icons.star_border,
                    color: appColors.darkBlue,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
