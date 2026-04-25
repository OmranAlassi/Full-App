import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/core/network/api_error.dart';
import 'package:full_app/features/auth/data/auth_repo.dart';
import 'package:full_app/features/auth/data/user_model.dart';
import 'package:full_app/features/home/data/model/product_model.dart';
import 'package:full_app/features/home/data/repo/product_repo.dart';
import 'package:full_app/features/home/widgets/card_item.dart';
import 'package:full_app/features/home/widgets/category_home.dart';
import 'package:full_app/features/home/widgets/search_field.dart';
import 'package:full_app/features/home/widgets/user_header.dart';
import 'package:full_app/features/productDetail/views/product_details_view.dart';
import 'package:full_app/shared/custom_snack_bar.dart';

import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchController = .new();
  List<ProductModel>? products;
  List<ProductModel>? categories;
  List<ProductModel>? allProducts;
  // Timer in search
  Timer? _debounce;
  //Infinite scroll
  // int page = 1;
  // bool isLoadingMore = false;
  // bool hasMore = true;
  final ScrollController scrollController = ScrollController();
  ProductRepo productRepo = ProductRepo();

  Future<void> getProduct() async {
    final res = await productRepo.getProducts();
    setState(() {
      allProducts = res.cast<ProductModel>();
      products = res.cast<ProductModel>();
    });
  }
  //Infinite scroll
  // Future<void> getProduct() async {
  //   if (isLoadingMore || !hasMore) return;
  //   setState(() => isLoadingMore = true);
  //   final res = await productRepo.getProducts(page: page);
  //   setState(() {
  //     if (res.isEmpty) {
  //       hasMore = false;
  //     } else {
  //       page++;
  //       products?.addAll(res.cast<ProductModel>());
  //       allProducts?.addAll(res.cast<ProductModel>());
  //     }
  //     isLoadingMore = false;
  //   });
  // }

  Future<void> getCategory() async {
    final res = await productRepo.getCategory();
    setState(() {
      categories = res.cast<ProductModel>();
    });
  }

  // List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;

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
    getCategory();
    getProduct();
    //Infinite scroll
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 200) {
    //     getProduct();
    //   }
    // });
    super.initState();
  }

  // Timer in search
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              //header
              SliverAppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 188,
                pinned: true,
                floating: false,
                elevation: 0,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 38, right: 20, left: 20),
                  child: Column(
                    children: [
                      UserHeader(
                        userImage:
                            userModel?.image.toString() ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxIM0GFCH1NdjwHQAMNDUW9NbcIzI_KWuQjA&s",
                        userName: userModel?.name ?? "Guest User",
                      ),
                      Gap(20),
                      SearchField(
                        controller: searchController,
                        // Timer in search
                        onChanged: (v) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();

                          _debounce = Timer(Duration(milliseconds: 500), () {
                            final query = v.toLowerCase();

                            setState(() {
                              products = allProducts!
                                  .where(
                                    (e) => e.name.toLowerCase().contains(query),
                                  )
                                  .toList();
                            });
                          });
                        },
                        //no Timer
                        // onChanged: (v) {
                        //   final query = v.toLowerCase();
                        //   setState(() {
                        //     products = allProducts!
                        //         .where(
                        //           (e) => e.name.toLowerCase().contains(query),
                        //         )
                        //         .toList();
                        //   });
                        // },
                      ),
                      Gap(10),
                    ],
                  ),
                ),
              ),

              //  category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),

                  child: CategoryHome(
                    selectedIndex: selectedIndex,
                    category: categories ?? [],
                  ),
                ),
              ),

              //GridView
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: products?.length,
                    (context, index) {
                      final product = products?[index];
                      if (product == null) {
                        return CupertinoActivityIndicator();
                      }
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) {
                              return ProductDetailsView(
                                productImage: product.image,
                                productId: product.id,
                                productPrice: product.price,
                              );
                            },
                          ),
                        ),
                        child: CardItem(
                          image: product.image,
                          text: product.name,
                          desc: product.desc,
                          rate: product.rate,
                        ),
                      );
                    },
                  ),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 2,
                  ),
                ),
              ),
              //Infinite scroll
              // GridView.builder(
              //   controller: scrollController,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     childAspectRatio: 0.75,
              //   ),
              //   itemCount: products?.length ?? 0,
              //   itemBuilder: (context, index) {
              //     final product = products?[index];
              //     if (product == null) return CupertinoActivityIndicator();

              //     return GestureDetector(
              //       onTap: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (c) {
              //             return ProductDetailsView(
              //               productImage: product.image,
              //               productId: product.id,
              //               productPrice: product.price,
              //             );
              //           },
              //         ),
              //       ),
              //       child: CardItem(
              //         image: product.image,
              //         text: product.name,
              //         desc: product.desc,
              //         rate: product.rate,
              //       ),
              //     );
              //   },
              // ),
              // if (isLoadingMore)
              //   Padding(
              //     padding: EdgeInsets.all(16),
              //     child: CupertinoActivityIndicator(),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
