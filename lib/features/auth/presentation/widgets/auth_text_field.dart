import 'package:flutter/material.dart';
import 'package:frello/core/utils/my_style.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  const AuthTextField({
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: TextFormField(
        style: mystyle(16, Colors.black, FontWeight.w600),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
          hintText: hintText,
          hintStyle: mystyle(16, Colors.black45, FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none, // R
          ),
        ),
        controller: controller,
        obscureText: isPassword,
      ),
    );
  }
}
