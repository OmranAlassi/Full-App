import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/features/home/data/model/topping_model.dart';
import 'package:full_app/features/home/data/repo/product_repo.dart';
import 'package:full_app/features/productDetail/widgets/spicy_slider.dart';
import 'package:full_app/features/productDetail/widgets/topping_card.dart';
import 'package:full_app/shared/custom_button.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productImage});
  final String productImage;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
  int? selectedToppingIndex;

  ProductRepo productRepo = ProductRepo();

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

  Future<void> getToppings() async {
    final res = await productRepo.getToppings();
    setState(() {
      toppings = res.cast<ToppingModel>();
    });
  }

  Future<void> getOptions() async {
    final res = await productRepo.getOptions();
    setState(() {
      options = res.cast<ToppingModel>();
    });
  }

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.productImage.isEmpty,
      child: Scaffold(
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
                SpicySlider(
                  image: widget.productImage,
                  value: value,
                  onChanged: (v) {
                    setState(() {
                      value = v;
                    });
                  },
                ),
                Gap(50),
                CustomText(text: 'Toppings', size: 20),
                Gap(20),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 4, (index) {
                      final isSelected = selectedToppingIndex == index;
                      final topping = toppings?[index];
                      if (topping == null) {
                        return CupertinoActivityIndicator();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ToppingCard(
                          imageUrl: topping.image,
                          name: topping.name,
                          onAdd: () {
                            setState(() {
                              selectedToppingIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
                Gap(20),
                CustomText(text: 'Side Options', size: 20),
                Gap(20),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(options?.length ?? 4, (index) {
                      final isSelected = selectedToppingIndex == index;
                      final option = options?[index];
                      if (option == null) {
                        return CupertinoActivityIndicator();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ToppingCard(
                          imageUrl: option.image,
                          name: option.name,
                          onAdd: () {
                            setState(() {
                              selectedToppingIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
                Gap(200),
              ],
            ),
          ),
        ),
      
        bottomSheet: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
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
                    CustomText(text: '\$18.9', size: 24),
                  ],
                ),
                CustomButton(text: 'Add To Cart', onTap: () {}, width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
