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
    final imgPicker = context.read<ImgProvider>();
    final translationProvider = context.read<TranslationProvider>();

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 20,
        children: [
          FloatingActionButton(
            onPressed: () {
              imgPicker.pickImage(source: ImageSource.camera);
            },
            backgroundColor: AppColors().darkBlue,

            child: Icon(Icons.camera_alt, size: 30),
          ),
          FloatingActionButton(
            onPressed: () {
              imgPicker.pickImage(source: ImageSource.gallery).then((value) {
                translationProvider.translateImage(
                  imgPath: imgPicker.imagePath,
                );
              });
            },
            backgroundColor: AppColors().darkBlue,

            child: Icon(Icons.image, size: 30),
          ),
        ],
      ),
      body: Consumer<ImgProvider>(
        builder: (_, value, _) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  LanguageSelectRow(isScript: true),
                  SizedBox(height: 20),
                  value.image != null
                      ? Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          image: DecorationImage(
                            image: FileImage(value.image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      : Icon(Icons.image, size: 200),
                  Container(height: 10, color: Colors.yellowAccent),
                  TextContainer(
                    isSource: true,
                    width: 380,
                    isImgRecognizer: true,
                  ),
                  Container(height: 10, color: Colors.yellowAccent),
                  TextContainer(
                    isSource: false,
                    width: 380,
                    isImgRecognizer: true,
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
