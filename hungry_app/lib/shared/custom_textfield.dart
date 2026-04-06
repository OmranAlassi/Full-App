import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText = widget.isPassword;

  @override
  // ignore: override_on_non_overriding_member
  void iniState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglepassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorHeight: 20,
      cursorColor: AppColor.primary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please fill ${widget.hint}';
        }
        return null;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglepassword,
                child: Icon(CupertinoIcons.eye),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
