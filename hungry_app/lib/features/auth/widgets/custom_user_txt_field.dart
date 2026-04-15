import 'package:flutter/material.dart';

class CustomUserTxtField extends StatelessWidget {
  const CustomUserTxtField({
    super.key,
    required this.controller,
    required this.label,
    this.color,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String label;
  final Color? color;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: color ?? Colors.white,
      cursorHeight: 20,
      style: TextStyle(color: color ?? Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        labelText: label,
        labelStyle: TextStyle(color: color ?? Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
