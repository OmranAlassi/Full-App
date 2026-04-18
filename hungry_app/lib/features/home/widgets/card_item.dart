import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  const CardItem({
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: -10,
                  child: Image.asset('assets/icon/Ellipse 1.png'),
                ),
                Center(child: Image.network(image, width: 130, height: 110)),
              ],
            ),
            Gap(10),
            CustomText(text: text, weight: FontWeight.bold),
            CustomText(text: desc),
            Row(
              children: [
                CustomText(text: '⭐$rate'),
                Spacer(),
                Icon(CupertinoIcons.heart, color: AppColor.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
