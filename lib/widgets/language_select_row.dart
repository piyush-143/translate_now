import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class LanguageSelectRow extends StatelessWidget {
  const LanguageSelectRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 320,
      decoration: BoxDecoration(
        color: AppColors().lightPurple,
        borderRadius: BorderRadius.circular(50),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                CircleAvatar(radius: 18),
                SizedBox(width: 10),
                Text(
                  "English",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
          Icon(Icons.swap_horiz_outlined, size: 24),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Spanish",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(width: 10),
                CircleAvatar(radius: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
