import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

SnackBar customSnackBar(dynamic errorMsg) {
  return SnackBar(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    elevation: 10,
    margin: EdgeInsets.only(bottom: 25, right: 20, left: 20),
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    backgroundColor: Colors.red.shade900,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(14),
        CustomText(
          text: errorMsg,
          color: Colors.white,
          size: 12,
          weight: FontWeight.w600,
        ),
      ],
    ),
  );
}
