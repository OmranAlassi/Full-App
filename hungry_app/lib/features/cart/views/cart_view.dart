import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/features/auth/data/auth_repo.dart';
import 'package:full_app/features/auth/data/user_model.dart';
import 'package:full_app/features/auth/views/login_view.dart';
import 'package:full_app/features/cart/data/cart_model.dart';
import 'package:full_app/features/cart/data/cart_repo.dart';
import 'package:full_app/features/cart/widgets/custom_cart_item.dart';
import 'package:full_app/features/checkout/views/checkout_view.dart';
import 'package:full_app/shared/custom_btn.dart';
import 'package:full_app/shared/custom_button.dart';
import 'package:full_app/shared/custom_snack_bar.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities = [];
  // final int itemCount = 3;
  bool isLoading = false;
  bool isLoadingRemove = false;
  CartRepo cartRepo = CartRepo();
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  GetCartResponse? cartResponse;
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

  Future<void> getCartData() async {
    try {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      final res = await cartRepo.getCartData();
      if (!mounted) return;
      final itemCount = res?.cartData.items.length ?? 0;
      setState(() {
        cartResponse = res;
        quantities = List.generate(itemCount, (_) => 1);
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  Future<void> removeCartItem(int id) async {
    try {
      setState(() {
        isLoadingRemove = true;
      });
      await cartRepo.removeCartItem(id);
      getCartData();
      setState(() {
        isLoadingRemove = false;
      });
    } catch (e) {
      setState(() {
        isLoadingRemove = false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    autoLogin();
    getCartData();
    // quantities = List.generate(itemCount, (_) => 1);
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMin(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
        body: isLoading
            ? Center(child: CupertinoActivityIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.only(bottom: 120, top: 10),
                  itemCount: cartResponse!.cartData.items.length,
                  itemBuilder: (context, index) {
                    final item = cartResponse!.cartData.items[index];
                    // if (item == null) {
                    //   return CupertinoActivityIndicator();
                    // }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CustomCartItem(
                        isLoading: isLoadingRemove,
                        image: item.image,
                        text: item.name,
                        desc: 'Spicy ${item.spicy}',
                        number: quantities[index],
                        onAdd: () => onAdd(index),
                        onMin: () => onMin(index),
                        onRemove: () => removeCartItem(item.itemId),
                      ),
                    );
                  },
                ),
              ),

        bottomSheet: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total', size: 15),
                  CustomText(
                    text: '\$${cartResponse?.cartData.totalPrice}??"0.0',
                    size: 24,
                  ),
                ],
              ),
              CustomButton(
                width: 200,
                text: 'Checkout',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return CheckoutView(
                          totalPrice:
                              cartResponse?.cartData.totalPrice ?? "0.0",
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else if (isGuest) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 55,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CustomText(text: 'Guest Mode')),
            CustomAuthBtn(
              color: AppColor.primary,
              text: 'Go To Login',
              textColor: Colors.white,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }
}
