import 'package:flutter/material.dart';
import 'package:translate_now/widgets/chat_box.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [SizedBox(height: 20), ChatBox(isFav: true)]),
      ),
    );
  }
}
