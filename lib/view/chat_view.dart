import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../view_modal/speech_to_text_provider.dart';
import '../widgets/language_selection_row.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    // The heightFactor value is dynamically calculated based on the device's screen size.
    final heightFactor = MediaQuery.of(context).size.height * 0.0168;

    return Scaffold(
      body: Stack(
        children: [
          _buildConversationList(),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: heightFactor,
            child: const LanguageSelectRow(isChat: true),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationList() {
    return Consumer<SpeechToTextProvider>(
      builder: (_, SpeechToTextProvider value, __) {
        // Handle empty list state for a better user experience
        if (value.chatList.isEmpty) {
          return const Center(
            child: Text(
              "Start a conversation to see translations here.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 100.0,
          ), // Add padding to avoid overlap with the language row
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: value.chatList.length,
            itemBuilder: (context, index) {
              final conversation = value.chatList[index];
              return _buildConversationItem(
                sourceText: conversation["source"] ?? "",
                targetText: conversation["target"] ?? "",
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 14),
          ),
        );
      },
    );
  }

  Widget _buildConversationItem({
    required String sourceText,
    required String targetText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Use MainAxisSize.min for a flexible height
        children: [
          _customText(text: sourceText, textColor: AppColors.darkBlue),
          Divider(color: Colors.grey.shade400, height: 10),
          _customText(text: targetText, textColor: AppColors.darkOrange),
        ],
      ),
    );
  }

  Widget _customText({required String text, required Color textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
