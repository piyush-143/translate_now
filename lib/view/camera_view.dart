import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view_modal/image_provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';
import 'package:translate_now/widgets/language_selection_row.dart';

import '../widgets/text_container.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    final imgProvider = context.read<ImgProvider>();
    final translationProvider = context.read<TranslationProvider>();

    return Scaffold(
      floatingActionButton: _buildFloatingActionButtons(
        imgProvider,
        translationProvider,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const LanguageSelectRow(isImg: true),
              const SizedBox(height: 10),
              _buildImageDisplay(),
              const SizedBox(height: 10),
              const TextContainer(
                isSource: true,
                width: 380,
                isImgRecognizer: true,
              ),
              const SizedBox(height: 30),
              _buildTranslatedTextContainer(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButtons(
    ImgProvider imgProvider,
    TranslationProvider translationProvider,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed:
              () => _pickAndTranslateImage(
                imgProvider,
                translationProvider,
                ImageSource.camera,
              ),
          backgroundColor: AppColors.darkBlue,
          child: const Icon(Icons.camera_alt, size: 30),
        ),
        const SizedBox(width: 20),
        FloatingActionButton(
          onPressed:
              () => _pickAndTranslateImage(
                imgProvider,
                translationProvider,
                ImageSource.gallery,
              ),
          backgroundColor: AppColors.darkBlue,
          child: const Icon(Icons.image, size: 30),
        ),
      ],
    );
  }

  Future<void> _pickAndTranslateImage(
    ImgProvider imgProvider,
    TranslationProvider translationProvider,
    ImageSource source,
  ) async {
    await imgProvider.pickImage(source: source);
    if (imgProvider.imagePath.isNotEmpty) {
      translationProvider.translateImage(imgPath: imgProvider.imagePath);
    }
  }

  Widget _buildImageDisplay() {
    return Consumer<ImgProvider>(
      builder: (context, value, _) {
        if (value.image != null) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(value.image!),
                fit: BoxFit.fill,
              ),
            ),
          );
        } else {
          return const Icon(Icons.image, size: 200, color: Colors.grey);
        }
      },
    );
  }

  Widget _buildTranslatedTextContainer() {
    return Consumer<TranslationProvider>(
      builder: (context, translationValue, _) {
        return translationValue.translationDone
            ? const TextContainer(
              isSource: false,
              width: 380,
              isImgRecognizer: true,
            )
            : const SizedBox.shrink();
      },
    );
  }
}
