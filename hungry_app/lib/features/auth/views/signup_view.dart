import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/views/login_view.dart';
import 'package:full_app/shared/custom_btn.dart';
import 'package:full_app/shared/custom_text.dart';
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
    // TextEditingController confirmPassController = .new();
    return Scaffold(
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
              CustomText(
                text: 'Welcome To Our Food App',
                color: AppColor.primary,
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
                          hint: 'Name',
                          isPassword: false,
                          controller: nameController,
                        ),
                        Gap(15),
                        CustomTextfield(
                          hint: 'Email Address',
                          isPassword: false,
                          controller: emailController,
                        ),
                        Gap(15),
                        CustomTextfield(
                          hint: 'Password',
                          isPassword: true,
                          controller: passController,
                        ),
                        // Gap(10),
                        // CustomTextfield(
                        //   hint: 'Confirm Password',
                        //   isPassword: true,
                        //   controller: confirmPassController,
                        // ),
                        Gap(20),
                        CustomAuthBtn(
                          color: Colors.transparent,
                          textColor: Colors.white,
                          text: 'Sign Up',
                          onTap: () {
                            if (formKey.currentState!.validate()) {}
                          },
                        ),
                        Gap(10),
                        CustomAuthBtn(
                          color: Colors.white,
                          text: 'Go To Login ?',
                          textColor: AppColor.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) {
                                  return LoginView();
                                },
                              ),
                            );
                          },
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
    );
  }
}
