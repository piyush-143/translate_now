import 'package:flutter/material.dart';
import 'package:translate_now/widgets/chat_box.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            InkWell(onLongPress: () {}, child: ChatBox()),
          ],
        ),
      ),
    );
  }
}
