import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/features/cart/data/cart_model.dart';
import 'package:full_app/features/cart/data/cart_repo.dart';
import 'package:full_app/features/cart/widgets/custom_cart_item.dart';
import 'package:full_app/features/checkout/views/checkout_view.dart';
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
  late List<int> quantities;
  // final int itemCount = 3;
  bool isLoading = false;
   bool isLoadingRemove = false;
  CartRepo cartRepo = CartRepo();

  GetCartResponse? cartResponse;

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
        isLoadingRemove=true;
      });
      await cartRepo.removeCartItem(id);
      getCartData();
      setState(() {
        isLoadingRemove=false;
      });
    } catch (e) {
      setState(() {
        isLoadingRemove=false;
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
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
                CustomText(text: '\$18.9', size: 24),
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
                      return CheckoutView();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
