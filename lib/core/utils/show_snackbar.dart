import 'package:flutter/material.dart';
import 'package:frello/core/utils/my_style.dart';

void showSnackBar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      content: Text(
        content,
        style: mystyle(18, Colors.white, FontWeight.w700),
      ),
    ),
  );
}
