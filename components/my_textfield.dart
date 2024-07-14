import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color hintColor;
  final Color borderColor;
  final Color fillColor;
  final Color textColor;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.hintColor = const Color(0xFFCCCCCC),
    this.borderColor = const Color(0xFFCCCCCC),
    this.fillColor = const Color(0xFF24293E),
    this.textColor = const Color(0xFFF4F5FC),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor.withOpacity(0.5)),
          ),
          fillColor: fillColor.withOpacity(0.2),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
        ),
      ),
    );
  }
}
