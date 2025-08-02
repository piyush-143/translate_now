import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
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
    return Container(
      width: width,
      height: 246,
      decoration: BoxDecoration(
        color: AppColors().lightPurple,
        borderRadius: BorderRadius.circular(16),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 15,
                  children: [
                    Text(
                      isSource
                          ? translationProvider.sourceLanguage.name
                          : translationProvider.targetLanguage.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors().darkBlue,
                      ),
                    ),
                    customIconButton(
                      onTap: () {},
                      icon: Icons.volume_up_outlined,
                      color: AppColors().darkBlue,
                    ),
                  ],
                ),
                customIconButton(
                  onTap:
                      isSource
                          ? () {
                            textController!.clear();
                          }
                          : isImgRecognizer
                          ? () {
                            translationProvider.setImgOutputText("");
                            translationProvider.setTranslationDone(false);
                          }
                          : () {
                            translationProvider.setOutputText("");
                            translationProvider.setTranslationDone(false);
                          },
                  icon: Icons.cancel_outlined,
                  color: AppColors().darkBlue,
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
                          style: TextStyle(fontSize: 15, height: 1.1),
                        ),
                      ),
                    )
                    : TextFormField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      maxLines: 7,
                      style: TextStyle(fontSize: 14, height: 1.2),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Enter text here...",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
                      style: TextStyle(fontSize: 15, height: 1.1),
                    ),
                  ),
                ),

            isSource
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isImgRecognizer
                        ? Text("")
                        : InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors().darkBlue,
                            child: Icon(Icons.mic, size: 28),
                          ),
                        ),
                    InkWell(
                      onTap: () {
                        translationProvider.translateText(
                          input:
                              isImgRecognizer
                                  ? translationProvider.recognizedText
                                  : textController!.text.toString(),
                          isImgRecognizer: isImgRecognizer,
                        );
                      },
                      child: Container(
                        width: 108,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors().darkOrange,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
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
                : Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customIconButton(
                      onTap: () async {
                        await FlutterClipboard.copy(
                          isImgRecognizer
                              ? translationProvider.recognizedText
                              : translationProvider.outputText,
                        );
                      },
                      icon: Icons.copy_rounded,
                      color: AppColors().darkBlue,
                    ),
                    customIconButton(
                      onTap: () {},
                      icon: Icons.share,
                      color: AppColors().darkBlue,
                    ),
                    customIconButton(
                      onTap: () {},
                      icon: Icons.star_border,
                      color: AppColors().darkBlue,
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
