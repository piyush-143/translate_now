import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/app_colors.dart';
import '../view_modal/db_provider.dart';
import '../view_modal/image_provider.dart';
import '../view_modal/translation_provider.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_dialog.dart';

class TextContainer extends StatelessWidget {
  final bool isSource;
  final double width;
  final bool isImgRecognizer;
  final TextEditingController? textController;
  final FocusNode? focus;

  const TextContainer({
    super.key,
    this.isSource = false,
    this.isImgRecognizer = false,
    this.width = 340,
    this.textController,
    this.focus,
  });

  @override
  Widget build(BuildContext context) {
    final translationProvider = context.read<TranslationProvider>();
    final dbProvider = context.read<DBProvider>();

    return Container(
      width: width,
      height: 246,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, translationProvider, dbProvider),
            _buildContent(context),
            _buildFooter(context, translationProvider, dbProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    TranslationProvider translationProvider,

    DBProvider dbProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isSource
              ? translationProvider.sourceLanguage.name
              : translationProvider.targetLanguage.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBlue,
          ),
        ),
        CustomButtons().iconButton(
          onTap: () => _handleClearButtonTap(context, translationProvider),
          icon: Icons.cancel_outlined,
          color: AppColors.darkBlue,
        ),
      ],
    );
  }

  void _handleClearButtonTap(
    BuildContext context,
    TranslationProvider translationProvider,
  ) {
    if (isSource) {
      if (isImgRecognizer) {
        translationProvider.resetRecognized();
        context.read<ImgProvider>().resetImg();
      } else {
        textController?.clear();
      }
    } else {
      if (isImgRecognizer) {
        translationProvider.resetImgOutputText();
      } else {
        translationProvider.resetOutputText();
      }
    }
    translationProvider.setTranslationDone(false);
    translationProvider.setAddedToFav(false);
  }

  Widget _buildContent(BuildContext context) {
    if (isSource) {
      if (isImgRecognizer) {
        return Expanded(
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
        );
      } else {
        return Expanded(
          child: TextFormField(
            controller: textController,
            keyboardType: TextInputType.text,
            maxLines: 7,
            style: const TextStyle(fontSize: 14, height: 1.2),
            focusNode: focus,
            onTapOutside: (_) => focus?.unfocus(),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: "Enter text here...",
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        );
      }
    } else {
      return Expanded(
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
      );
    }
  }

  Widget _buildFooter(
    BuildContext context,
    TranslationProvider translationProvider,
    DBProvider dbProvider,
  ) {
    if (isSource) {
      return _buildTranslateButton(context, translationProvider, dbProvider);
    } else {
      return _buildActionButtons(context, translationProvider, dbProvider);
    }
  }

  Widget _buildTranslateButton(
    BuildContext context,
    TranslationProvider translationProvider,
    DBProvider dbProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            focus?.unfocus();
            final input =
                isImgRecognizer
                    ? translationProvider.recognizedText
                    : textController!.text;
            if (input.isNotEmpty) {
              CustomDialog().progressLoading(context);
              await translationProvider.translateText(
                input: input,
                isImgRecognizer: isImgRecognizer,
              );
              Navigator.of(context, rootNavigator: true).pop();
              final sourceLang =
                  isImgRecognizer
                      ? "en"
                      : translationProvider.sourceLanguage.bcpCode;
              dbProvider.addData(
                isHistory: true,
                sourceLang: sourceLang,
                targetLang: translationProvider.targetLanguage.bcpCode,
                sourceText: input,
                targetText:
                    isImgRecognizer
                        ? translationProvider.imgOutputText
                        : translationProvider.outputText,
              );
              translationProvider.setAddedToFav(false);
            } else {
              CustomDialog().flushBarMessage(context, "Empty Text!!!");
            }
          },
          child: Container(
            width: 108,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.darkOrange,
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
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    TranslationProvider translationProvider,
    DBProvider dbProvider,
  ) {
    final textToCopyOrShare =
        isImgRecognizer
            ? translationProvider.imgOutputText
            : translationProvider.outputText;
    final sourceTextForFav =
        isImgRecognizer
            ? translationProvider.recognizedText
            : textController?.text ?? '';
    final sourceLangForFav =
        isImgRecognizer ? "en" : translationProvider.sourceLanguage.bcpCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButtons().iconButton(
          onTap: () async {
            await FlutterClipboard.copy(textToCopyOrShare);
            CustomDialog().flushBarMessage(context, "Copied to clipboard");
          },
          icon: Icons.copy_rounded,
          color: AppColors.darkBlue,
        ),
        const SizedBox(width: 20),
        CustomButtons().iconButton(
          onTap: () async {
            if (textToCopyOrShare.isNotEmpty) {
              await SharePlus.instance.share(
                ShareParams(text: textToCopyOrShare),
              );
            }
          },
          icon: Icons.share,
          color: AppColors.darkBlue,
        ),
        const SizedBox(width: 20),
        CustomButtons().iconButton(
          onTap: () {
            if (sourceTextForFav.isNotEmpty && textToCopyOrShare.isNotEmpty) {
              dbProvider.addData(
                isHistory: false,
                sourceLang: sourceLangForFav,
                targetLang: translationProvider.targetLanguage.bcpCode,
                sourceText: sourceTextForFav,
                targetText: textToCopyOrShare,
              );
              translationProvider.setAddedToFav(true);
              CustomDialog().flushBarMessage(context, "Added to favorite");
            } else {
              CustomDialog().flushBarMessage(
                context,
                "Cannot add empty text to favorites",
              );
            }
          },
          icon:
              context.watch<TranslationProvider>().addedToFav
                  ? Icons.star
                  : Icons.star_border,
          color: AppColors.darkBlue,
        ),
      ],
    );
  }
}
