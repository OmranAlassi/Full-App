import 'package:flutter/material.dart';
import 'package:full_app/core/const/app_color.dart';
import 'package:full_app/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onAdd;
  final Color color;

  const ToppingCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onAdd,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: SizedBox(
        width: 100,
        height: 110,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Top half – image
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 80,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              // Bottom half – dark bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 37,
                child: Container(
                  color: AppColor.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: name,
                        weight: FontWeight.w600,
                        size: 12,
                        color: Colors.white,
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
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
