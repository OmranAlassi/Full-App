import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:gap/gap.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(280),
            SvgPicture.asset('assets/logo/Hungry_.svg'),
            Spacer(),
            Image.asset('assets/splash/image 1.png'),
          ],
        ),
      ),
    );
  }
}
