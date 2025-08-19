import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/widgets/language_selection_row.dart';

import '../utils/app_colors.dart';
import '../view_modal/speech_to_text_provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final heightFactor = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer<SpeechToTextProvider>(
                  builder: (_, SpeechToTextProvider value, _) {
                    return ListView.separated(
                      itemCount: value.conversationList.length,
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 14);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColors().lightPurple,
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
                            children: [
                              customText(
                                text: value.conversationList[index]["source"],
                                textColor: AppColors().darkBlue,
                              ),
                              Divider(color: Colors.grey.shade400, height: 10),
                              customText(
                                text: value.conversationList[index]["target"],
                                textColor: AppColors().darkOrange,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(height: heightFactor * 0.09),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: heightFactor * .0168,
            child: LanguageSelectRow(isChat: true),
          ),
        ],
      ),
    );
  }
}

Widget customText({required String text, required Color textColor}) {
  return Expanded(
    child: Row(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}
