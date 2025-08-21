import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view_modal/speech_to_text_provider.dart';
import 'package:translate_now/widgets/custom_bottom_bar.dart';

import '../view_modal/db_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    Future.microtask(() {
      context.read<SpeechToTextProvider>().initSpeech();
      context.read<DBProvider>().getData();
    });

    // We use Future.delayed to show the splash screen for a set duration.
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CustomBottomBar()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_TopBubbles(), _LogoAndText(), _LoadingIndicator()],
      ),
    );
  }
}

class _TopBubbles extends StatelessWidget {
  const _TopBubbles();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset("assets/bubble1.png", width: screenWidth * 0.75),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset("assets/bubble2.png", width: screenWidth * 0.5),
        ),
      ],
    );
  }
}

class _LogoAndText extends StatelessWidget {
  const _LogoAndText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png", width: 100, height: 82),
          const SizedBox(height: 25),
          const Text(
            "TRANSLATE ON THE GO",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Image.asset("assets/loading.png", width: 120)],
        ),
      ),
    );
  }
}
