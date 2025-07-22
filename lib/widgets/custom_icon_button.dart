import 'package:flutter/material.dart';

Widget customIconButton({
  required VoidCallback onTap,
  required IconData icon,
  Color color = Colors.white,
  double size = 24,
}) {
  return InkWell(onTap: onTap, child: Icon(icon, size: size, color: color));
}
