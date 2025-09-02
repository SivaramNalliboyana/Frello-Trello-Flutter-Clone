import 'package:flutter/material.dart';
import 'package:frello/core/utils/my_style.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AuthButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.75, 45),
          backgroundColor: Colors.blue),
      child: Text(
        title,
        style: mystyle(18, Colors.white, FontWeight.bold),
      ),
    );
  }
}
