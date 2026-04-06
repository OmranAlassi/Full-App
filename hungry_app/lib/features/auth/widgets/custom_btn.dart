import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        width: double.infinity,
        child: Center(
          child: CustomText(
            text: text,
            size: 15,
            weight: FontWeight.w500,
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}
