import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view_modal/translation_provider.dart';
import 'package:translate_now/widgets/language_select_row.dart';
import 'package:translate_now/widgets/text_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          context.watch<TranslationProvider>().loading
              ? Center(
                child: CircularProgressIndicator(
                  color: AppColors().darkBlue,
                  strokeWidth: 5,
                  trackGap: 20,
                  backgroundColor: AppColors().lightPurple,
                ),
              )
              : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      LanguageSelectRow(),
                      SizedBox(height: 30),
                      TextContainer(isSource: true),
                      SizedBox(height: 30),
                      context.watch<TranslationProvider>().translationDone
                          ? TextContainer()
                          : Container(),
                    ],
                  ),
                ),
              ),
    );
  }
}
