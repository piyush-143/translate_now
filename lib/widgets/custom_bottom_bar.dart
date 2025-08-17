import 'package:convex_bottom_bar_renew/convex_bottom_bar_renew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';
import 'package:translate_now/view/favourite_view.dart';
import 'package:translate_now/view/history_view.dart';
import 'package:translate_now/view/home_view.dart';
import 'package:translate_now/view_modal/bottom_app_bar_provider.dart';
import 'package:translate_now/view_modal/db_provider.dart';
import 'package:translate_now/widgets/custom_dialog.dart';

import '../view/camera_view.dart';
import '../view/chat_view.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final List<TabItem> _tabItems = const [
    TabItem(icon: Icons.mic, title: 'Chat'),
    TabItem(icon: Icons.camera_alt, title: 'Camera'),
    TabItem(icon: Icons.translate, title: 'Home'),
    TabItem(icon: Icons.history, title: 'History'),
    TabItem(icon: Icons.star_border, title: 'Favourite'),
  ];

  final List<Widget> _screens = const [
    ChatView(),
    CameraView(),
    HomeView(),
    HistoryView(),
    FavouriteView(),
  ];

  final List<String> _titles = const [
    "Voice Conversation",
    "Camera Translation",
    "Language Translator",
    "History",
    "Favourite",
  ];

  @override
  Widget build(BuildContext context) {
    final indexProvider = context.watch<BottomAppBarProvider>();
    final dbProvider = context.read<DBProvider>();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        return CustomDialog().exitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().darkBlue,
          title: Text(_titles[indexProvider.index]),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          actions: [
            if (indexProvider.index == 3 || indexProvider.index == 4)
              TextButton(
                onPressed: () {
                  dbProvider.clearAllHistory(
                    isHistory: indexProvider.index == 3,
                  );
                },
                child: const Text(
                  "Clear all",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
          ],
          actionsPadding: const EdgeInsets.only(right: 20),
        ),
        drawer: Drawer(
          width: 308,
          child: Column(
            children: [
              const SizedBox(height: 90),
              Image.asset("assets/logo.png", width: 100, height: 82),
              const SizedBox(height: 25),
              const Text(
                "TRANSLATE ON THE GO",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 100),
              _buildReUseRow(Icons.share, "Share App"),
              _buildReUseRow(Icons.star, "Rate Us"),
              _buildReUseRow(Icons.privacy_tip_rounded, "Privacy Policy"),
              _buildReUseRow(Icons.feed, "Feedback"),
              const Spacer(),
              const Text(
                "Version 1.0",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          items: _tabItems,
          color: Colors.black,
          height: 60,
          backgroundColor: AppColors().lightPurple,
          activeColor: const Color.fromRGBO(0, 91, 161, 1),
          elevation: 7,
          shadowColor: Colors.black38,
          curveSize: 100,
          top: -16,
          initialActiveIndex: indexProvider.index,
          onTap: (index) {
            context.read<BottomAppBarProvider>().setIndex(idx: index);
          },
        ),
        body: _screens[indexProvider.index],
      ),
    );
  }
}

Widget _buildReUseRow(IconData drawerIcon, String iconLabel) {
  return SizedBox(
    width: 180,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(drawerIcon, size: 24),
        const SizedBox(width: 29), // Replaced spacing with SizedBox
        Text(
          iconLabel,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
