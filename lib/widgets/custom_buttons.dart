import 'package:flutter/material.dart';

class CustomButtons {
  Widget customIconButton({
    required VoidCallback onTap,
    required IconData icon,
    Color color = Colors.white,
    double size = 24,
  }) {
    return InkWell(onTap: onTap, child: Icon(icon, size: size, color: color));
  }

  Widget customMicButton({
    required VoidCallback onTap,
    required IconData icon,
    Color color = Colors.white,
    double size = 24,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, size: size, color: Colors.white),
      ),
    );
  }
}
