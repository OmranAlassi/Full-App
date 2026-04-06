import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });
  final String image, text, desc, rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: 170),
            Gap(10),
            CustomText(text: text, weight: FontWeight.bold),
            CustomText(text: desc),
            Row(
              children: [
                CustomText(text: '⭐$rate'),
                Spacer(),
                Icon(CupertinoIcons.heart_fill, color: AppColor.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
