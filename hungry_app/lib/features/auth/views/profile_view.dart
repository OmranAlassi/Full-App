// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/features/auth/data/auth_repo.dart';
import 'package:full_app/features/auth/data/user_model.dart';
import 'package:full_app/features/auth/views/login_view.dart';
import 'package:full_app/features/auth/widgets/custom_user_txt_field.dart';
import 'package:full_app/shared/custom_button.dart';
import 'package:full_app/shared/custom_snack_bar.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = .new();
  final TextEditingController emailController = .new();
  final TextEditingController addressController = .new();
  final TextEditingController visaController = .new();

  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  String? selectedImage;
  bool isLoading = false;
  bool isGuest = false;

  Future<void> autoLogin() async {
    final user = await authRepo.authLogin();
    setState(() {
      isGuest = authRepo.isGuest;
    });
    if (user != null) {
      setState(() {
        userModel = user;
      });
    }
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
    }
  }

  Future<void> updateProfileData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final user = await authRepo.updateProfileData(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        image: selectedImage,
        visa: visaController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar("Profile updated Successfully"));
      setState(() {
        isLoading = false;
      });

      setState(() {
        userModel = user;
      });
      await getProfileData();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMsg = "Error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginView();
        },
      ),
    );
  }

  Future<void> pickImage() async {
    final pickdImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickdImage != null) {
      setState(() {
        selectedImage = pickdImage.path;
      });
    }
  }

  @override
  void initState() {
    autoLogin();
    getProfileData().then((value) {
      print(userModel?.name);
      print(userModel?.email);
      nameController.text = userModel?.name ?? 'Omran AlAssi';
      emailController.text = userModel?.email ?? 'omranalassi3@gmail.com';
      addressController.text = userModel?.address ?? '55 Syria';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return RefreshIndicator(
        displacement: 40,
        color: Colors.white,
        backgroundColor: AppColor.primary,
        onRefresh: () => getProfileData(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  child: SvgPicture.asset(
                    'assets/icon/Group.svg',
                    width: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Skeletonizer(
                  enabled: userModel == null,

                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: FileImage(
                            //     File(selectedImage ?? "assets/icon/download.png"),
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),
                            color: Colors.grey.shade400,
                            border: Border.all(
                              width: 2,
                              color: AppColor.primary,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: selectedImage != null
                              ? Image.file(
                                  File(selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : (userModel?.image != null &&
                                    userModel!.image!.isNotEmpty)
                              ? Image.network(
                                  userModel!.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, builder) =>
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 70,
                                ),
                        ),
                      ),

                      Gap(30),
                      CustomButton(
                        text: 'Change image',
                        width: 150,
                        height: 50,
                        onTap: pickImage,
                      ),
                      Gap(25),
                      CustomUserTxtField(
                        controller: nameController,
                        label: 'Name',
                        color: AppColor.primary,
                      ),
                      Gap(25),
                      CustomUserTxtField(
                        controller: emailController,
                        label: 'Email',
                        color: AppColor.primary,
                      ),
                      Gap(25),
                      CustomUserTxtField(
                        controller: addressController,
                        label: 'Address',
                        color: AppColor.primary,
                      ),
                      Gap(20),
                      Divider(color: AppColor.primary),
                      Gap(10),
                      userModel?.visa == null
                          ? CustomUserTxtField(
                              keyboardType: TextInputType.number,
                              controller: visaController,
                              label: 'Add Visa Card',
                              color: AppColor.primary,
                            )
                          : ListTile(
                              // onTap: () => setState(() => selectedMethod = 'Visa'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              tileColor: Color(0XffF3F4F6),
                              leading: Image.asset(
                                'assets/icon/image 13.png',
                                width: 50,
                              ),
                              title: CustomText(
                                text: 'Debit card',
                                color: Color(0Xff3C2F2F),
                              ),
                              subtitle: CustomText(
                                text: userModel?.visa ?? '3566 **** **** 0505',
                                color: Color(0Xff808080),
                              ),
                              trailing: CustomText(text: 'Default', size: 12),
                              // trailing: Radio<String>(
                              //   activeColor: Colors.grey.shade500,
                              //   value: 'Visa',
                              //   // ignore: deprecated_member_use
                              //   groupValue: 'Visa',
                              //   // ignore: deprecated_member_use
                              //   onChanged: (value) {},
                              // ),
                            ),

                      Gap(400),
                    ],
                  ),
                ),
              ),
            ),

            bottomSheet: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset(0, 1),
                    color: Colors.grey.shade800,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isLoading
                        ? CupertinoActivityIndicator()
                        : GestureDetector(
                            onTap: updateProfileData,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                spacing: 5,
                                children: [
                                  CustomText(
                                    text: 'Edit Profile',
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    CupertinoIcons.pencil,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),

                    GestureDetector(
                      onTap: logout,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.primary),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            CustomText(text: 'Logout', color: AppColor.primary),
                            Icon(Icons.logout, color: AppColor.primary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (isGuest) {
      return Center(child: CustomText(text: 'Guest Mode'));
    }
    return SizedBox();
  }
}
