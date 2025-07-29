import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';
import 'package:translate_now/widgets/text_container.dart';

import '../widgets/language_selection_row.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              LanguageSelectRow(),
              SizedBox(height: 30),
              TextContainer(isSource: true, textController: textController),
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
