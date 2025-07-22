import 'package:flutter/material.dart';
import 'package:translate_now/utils/app_colors.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      backgroundColor: AppColors().darkOrange,
    );
  }
}
