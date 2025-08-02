import 'package:convex_bottom_bar_renew/convex_bottom_bar_renew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view/favourite_view.dart';
import 'package:translate_now/view/history_view.dart';
import 'package:translate_now/view/home_view.dart';
import 'package:translate_now/view_modal/bottom_app_bar_provider.dart';
import 'package:translate_now/widgets/custom_icon_button.dart';

import '../view/camera_view.dart';
import '../view/chat_view.dart';
import '../view_modal/image_provider.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final List<TabItem> _tabItems = [
    TabItem(icon: Icons.mic, title: 'Chat'),
    TabItem(icon: Icons.camera_alt, title: 'Camera'),
    TabItem(icon: Icons.translate, title: 'Home'),
    TabItem(icon: Icons.history, title: 'History'),
    TabItem(icon: Icons.star_border, title: 'Favourite'),
  ];
  List screens = [
    ChatView(),
    CameraView(),
    HomeView(),
    HistoryView(),
    FavouriteView(),
  ];
  List<String> title = [
    "Voice Conversation",
    "Camera Traslation",
    "Language Translator",
    "History",
    "Favourite",
  ];
  @override
  Widget build(BuildContext context) {
    final indexProvider = context.watch<BottomAppBarProvider>();
    final imgPicker = context.read<ImgProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().darkBlue,
        automaticallyImplyLeading: false,
        title: Text(title[indexProvider.index]),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        leading: DrawerButton(
          color: Colors.white,
          style: ButtonStyle(iconSize: WidgetStatePropertyAll(28)),
        ),
        actions: [
          indexProvider.index == 3
              ? !indexProvider.isSelected
                  ? TextButton(
                    onPressed: () {},
                    child: Text(
                      "Clear all",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )
                  : Row(
                    spacing: 15,
                    children: [
                      customIconButton(
                        onTap: () {},
                        icon: Icons.check_box_outline_blank,
                      ),
                      customIconButton(
                        onTap: () {},
                        icon: Icons.delete_forever,
                      ),
                    ],
                  )
              : SizedBox(),
        ],
        actionsPadding: EdgeInsets.only(right: 20),
      ),
      drawer: Container(
        width: 308,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 90),
            Image.asset("assets/logo.png", width: 100, height: 82),
            SizedBox(height: 25),
            Text(
              "TRANSLATE ON THE GO",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 100),
            reUseRow(Icons.share, "Share App"),
            reUseRow(Icons.star, "Rate Us"),
            reUseRow(Icons.privacy_tip_rounded, "Privacy Policy"),
            reUseRow(Icons.feed, "Feedback"),
            Spacer(),
            Text(
              "Version 1.0",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: _tabItems,
        color: Colors.black,
        height: 60,
        backgroundColor: AppColors().lightPurple,
        activeColor: Color.fromRGBO(0, 91, 161, 1),
        elevation: 7,
        shadowColor: Colors.black38,
        curveSize: 100,
        top: -16,
        initialActiveIndex: indexProvider.index,
        onTap: (index) {
          context.read<BottomAppBarProvider>().setIndex(idx: index);
        },
      ),

      body: screens[indexProvider.index],
    );
  }
}

Widget reUseRow(IconData drawerIcon, String iconLabel) {
  return SizedBox(
    width: 180,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 29,
      children: [
        Icon(drawerIcon, size: 24),
        Text(
          iconLabel,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
