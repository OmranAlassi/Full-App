import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: CustomText(text: text, color: Colors.white),
      ),
    );
  }
}
