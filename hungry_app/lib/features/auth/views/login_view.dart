// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/features/auth/data/auth_repo.dart';
import 'package:full_app/features/auth/views/signup_view.dart';
import 'package:full_app/shared/custom_btn.dart';
import 'package:full_app/root.dart';
import 'package:full_app/shared/custom_snack_bar.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:full_app/shared/custom_textfield.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = .new();
  TextEditingController passContrller = .new();
  final GlobalKey<FormState> formKey = .new();

  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passContrller.text.trim(),
        );
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) {
                return Root();
              },
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        String errorMsg = 'unhandied error in login';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          isLoading
                              ? CupertinoActivityIndicator(color: Colors.white)
                              : CustomAuthBtn(
                                  color: Colors.transparent,
                                  text: 'Login',
                                  textColor: Colors.white,
                                  onTap: login,
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
