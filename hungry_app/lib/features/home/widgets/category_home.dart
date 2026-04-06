import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';

class CategoryHome extends StatefulWidget {
  CategoryHome({
    super.key,
    required this.selectedIndex,
    required this.category,
  });
  final int selectedIndex;
  final List category;
  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColor.primary
                    : Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
              child: CustomText(
                text: widget.category[index],
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.grey.shade700,
                weight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
