import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/widgets/custom_btn.dart';
import 'package:full_app/shared/custom_textfield.dart';
import 'package:gap/gap.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = .new();
    TextEditingController emailController = .new();
    TextEditingController nameController = .new();
    TextEditingController passController = .new();
    TextEditingController confirmPassController = .new();
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(100),
                SvgPicture.asset('assets/logo/Hungry_.svg'),
                Gap(60),
                CustomTextfield(
                  hint: 'Name',
                  isPassword: false,
                  controller: nameController,
                ),
                Gap(10),
                CustomTextfield(
                  hint: 'Email Address',
                  isPassword: false,
                  controller: emailController,
                ),
                Gap(10),
                CustomTextfield(
                  hint: 'Password',
                  isPassword: true,
                  controller: passController,
                ),
                Gap(10),
                CustomTextfield(
                  hint: 'Confirm Password',
                  isPassword: true,
                  controller: confirmPassController,
                ),
                Gap(30),
                CustomAuthBtn(
                  text: 'Sign Up',
                  onTap: () {
                    if (formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
