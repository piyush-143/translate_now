import 'dart:async';

import 'package:flutter/material.dart';
import 'package:translate_now/widgets/custom_bottom_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomBar()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/bubble1.png",
                width: screenWidth * 0.75,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/bubble2.png",
                width: screenWidth * 0.5,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png", width: 100, height: 82),
                  SizedBox(height: 25),
                  Text(
                    "TRANSLATE ON THE GO",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/loading.png", width: 120),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
