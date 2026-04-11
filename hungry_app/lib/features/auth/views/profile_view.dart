import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/widgets/custom_user_txt_field.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = .new();
  final TextEditingController emailController = .new();
  final TextEditingController addressController = .new();
  @override
  void initState() {
    nameController.text = 'Omran AlAssi';
    emailController.text = 'omranalassi3@gmail.com';
    addressController.text = '55 Syria';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: SvgPicture.asset('assets/icon/Group.svg', width: 18),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon/download.png'),
                    ),
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                ),
              ),
              Gap(30),

              CustomUserTxtField(controller: nameController, label: 'Name'),
              Gap(25),
              CustomUserTxtField(controller: emailController, label: 'Email'),
              Gap(25),
              CustomUserTxtField(
                controller: addressController,
                label: 'Address',
              ),
              Gap(20),
              Divider(),
              Gap(10),
              ListTile(
                // onTap: () => setState(() => selectedMethod = 'Visa'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                tileColor: Color(0XffF3F4F6),
                leading: Image.asset('assets/icon/image 13.png', width: 50),
                title: CustomText(text: 'Debit card', color: Color(0Xff3C2F2F)),
                subtitle: CustomText(
                  text: '3566 **** **** 0505',
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
              Gap(100),
            ],
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    CustomText(text: 'Edit Profile', color: Colors.white),
                    Icon(CupertinoIcons.pencil, color: Colors.white),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}
