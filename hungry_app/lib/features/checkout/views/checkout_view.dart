import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/features/auth/data/auth_repo.dart';
import 'package:full_app/features/auth/data/user_model.dart';
import 'package:full_app/features/checkout/widgets/order_details_widget.dart';
import 'package:full_app/shared/custom_button.dart';
import 'package:full_app/shared/custom_snack_bar.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.totalPrice});
  final String totalPrice;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

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

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order summary',
                size: 20,
                weight: FontWeight.w500,
              ),
              Gap(10),
              OrderDetailsWidget(
                order: widget.totalPrice,
                taxes: '55',
                fees: '55.33',
                total: (double.parse(widget.totalPrice) + 3.50 + 40.33)
                    .toStringAsFixed(2),
              ),
              Gap(80),
              CustomText(
                text: 'Payment methods',
                size: 20,
                weight: FontWeight.w500,
              ),
              Gap(20),

              ListTile(
                onTap: () => setState(() => selectedMethod = 'Cash'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 16,
                ),
                tileColor: Color(0xFF3C2F2F),
                leading: Image.asset(
                  'assets/icon/dollar Background Removed 1.png',
                  width: 50,
                ),
                title: CustomText(
                  text: 'Cash on Delivery',
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  // ignore: deprecated_member_use
                  groupValue: selectedMethod,
                  // ignore: deprecated_member_use
                  onChanged: (value) => setState(() => selectedMethod = value!),
                ),
              ),

              Gap(10),
              userModel?.visa == null
                  ? SizedBox.shrink()
                  : ListTile(
                      onTap: () => setState(() => selectedMethod = 'Visa'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
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
                      trailing: Radio<String>(
                        activeColor: Colors.grey.shade500,
                        value: 'Visa',
                        // ignore: deprecated_member_use
                        groupValue: selectedMethod,
                        // ignore: deprecated_member_use
                        onChanged: (value) =>
                            setState(() => selectedMethod = value!),
                      ),
                    ),

              Gap(5),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (v) {},
                    checkColor: Colors.white,
                    activeColor: Color(0xFFEF2A39),
                  ),
                  CustomText(text: 'Save card details for future payments'),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total', size: 15),
                  CustomText(
                    text:
                        '\$ ${(double.parse(widget.totalPrice) + 3.50 + 40.33).toStringAsFixed(2)}',
                    size: 20,
                  ),
                ],
              ),
              CustomButton(
                text: 'Pay Now',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 200,
                          ),
                          child: Container(
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade800,
                                  blurRadius: 15,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColor.primary,

                                  child: Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.white,
                                  ),
                                ),
                                Gap(10),
                                CustomText(
                                  text: 'Success !',
                                  weight: FontWeight.bold,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                Gap(3),
                                CustomText(
                                  text:
                                      'Your payment was successful. \nA receipt for this purchase \nhas been sent to your email.',
                                  color: Colors.grey.shade500,
                                  size: 11,
                                ),
                                Gap(18),
                                CustomButton(
                                  text: 'Go Back',
                                  width: 200,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                width: 209,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
