import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view_modal/image_provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';
import 'package:translate_now/widgets/language_selection_row.dart';

import '../widgets/text_container.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    final imgProvider = context.read<ImgProvider>();
    final translationProvider = context.read<TranslationProvider>();

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await imgProvider.pickImage(source: ImageSource.camera);
              if (imgProvider.imagePath.isNotEmpty) {
                translationProvider.translateImage(
                  imgPath: imgProvider.imagePath,
                );
              }
            },
            backgroundColor: AppColors().darkBlue,
            child: const Icon(Icons.camera_alt, size: 30),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {
              await imgProvider.pickImage(source: ImageSource.gallery);
              if (imgProvider.imagePath.isNotEmpty) {
                translationProvider.translateImage(
                  imgPath: imgProvider.imagePath,
                );
              }
            },
            backgroundColor: AppColors().darkBlue,
            child: const Icon(Icons.image, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const LanguageSelectRow(isImg: true),
              const SizedBox(height: 10),
              Consumer<ImgProvider>(
                builder: (context, value, _) {
                  return value.image != null
                      ? Container(
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(value.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      : const Icon(Icons.image, size: 200, color: Colors.grey);
                },
              ),
              const SizedBox(height: 10),
              const TextContainer(
                isSource: true,
                width: 380,
                isImgRecognizer: true,
              ),
              const SizedBox(height: 30),
              Consumer<TranslationProvider>(
                builder: (context, translationValue, _) {
                  return translationValue.translationDone
                      ? const TextContainer(
                        isSource: false,
                        width: 380,
                        isImgRecognizer: true,
                      )
                      : Container();
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
