import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/widgets/custom_btn.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:full_app/shared/custom_textfield.dart';
import 'package:gap/gap.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = .new();
    TextEditingController passContrller = .new();
    final GlobalKey<FormState> formKey = .new();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(100),
                    SvgPicture.asset('assets/logo/Hungry_.svg'),
                    Gap(10),
                    CustomText(
                      text: 'Welcome Back, Discover The Fast Food',
                      color: Colors.white,
                      size: 13,
                      weight: FontWeight.w400,
                    ),
                    Gap(60),
                    CustomTextfield(
                      hint: 'Email Address',
                      isPassword: false,
                      controller: emailController,
                    ),
                    Gap(20),
                    CustomTextfield(
                      hint: 'password',
                      isPassword: true,
                      controller: passContrller,
                    ),
                    Gap(30),
                    CustomAuthBtn(
                      text: 'Login',
                      onTap: () {
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
