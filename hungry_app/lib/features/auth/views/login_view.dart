import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/views/signup_view.dart';
import 'package:full_app/shared/custom_btn.dart';
import 'package:full_app/root.dart';
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
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(200),
                SvgPicture.asset(
                  'assets/logo/Hungry_.svg',
                  // ignore: deprecated_member_use
                  color: AppColor.primary,
                ),
                Gap(10),
                CustomText(
                  text: 'Welcome Back, Discover The Fast Food',
                  color: AppColor.primary,
                  size: 13,
                  weight: FontWeight.w400,
                ),

                Gap(100),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gap(30),
                          CustomTextfield(
                            hint: 'Email Address',
                            isPassword: false,
                            controller: emailController,
                          ),
                          Gap(15),
                          CustomTextfield(
                            hint: 'password',
                            isPassword: true,
                            controller: passContrller,
                          ),
                          Gap(20),
                          CustomAuthBtn(
                            color: Colors.transparent,
                            text: 'Login',
                            textColor: Colors.white,
                            onTap: () {
                              if (formKey.currentState!.validate()) {}
                            },
                          ),
                          Gap(10),
                          CustomAuthBtn(
                            color: Colors.white,
                            text: 'Create Account ?',
                            textColor: AppColor.primary,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) {
                                    return SignupView();
                                  },
                                ),
                              );
                            },
                          ),
                          Gap(20),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) {
                                  return Root();
                                },
                              ),
                            ),
                            child: CustomText(
                              text: 'Continue as a guest ?',
                              color: Colors.white,
                              weight: FontWeight.bold,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
