import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/features/home/data/model/product_model.dart';
import 'package:full_app/features/home/data/repo/product_repo.dart';
import 'package:full_app/features/home/widgets/card_item.dart';
import 'package:full_app/features/home/widgets/category_home.dart';
import 'package:full_app/features/home/widgets/search_field.dart';
import 'package:full_app/features/home/widgets/user_header.dart';
import 'package:full_app/features/productDetail/views/product_details_view.dart';

import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();

  Future<void> getProduct() async {
    final res = await productRepo.getProducts();
    setState(() {
      products = res.cast<ProductModel>();
    });
  }

  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;

  @override
  void initState() {
    getProduct();
    super.initState();
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
                    children: [UserHeader(), Gap(20), SearchField(), Gap(10)],
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
                    category: category,
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
            ],
          ),
        ),
      ),
    );
  }
}
