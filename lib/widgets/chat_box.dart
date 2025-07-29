import 'package:flutter/material.dart';
import 'package:translate_now/widgets/custom_icon_button.dart';

import '../utils/app_colors.dart';

class ChatBox extends StatelessWidget {
  final bool isFav;
  const ChatBox({super.key, this.isFav = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 92,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reUseRow(isSource: true, lang: "en", isFav: isFav),
            Divider(color: Colors.grey.shade400),
            reUseRow(isSource: false, lang: "hi", isFav: isFav),
          ],
        ),
      ),
    );
  }
}

Widget reUseRow({
  required bool isSource,
  required String lang,
  required bool isFav,
}) {
  return Row(
    spacing: 20,
    children: [
      Text(lang, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      Text(
        "Hello how are you",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isSource ? AppColors().darkBlue : AppColors().darkOrange,
        ),
      ),
      Spacer(),
      isSource && isFav
          ? customIconButton(
            onTap: () {},
            icon: Icons.star,
            color: AppColors().darkBlue,
          )
          : Text(''),
    ],
  );
}
