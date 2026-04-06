import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_app/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onAdd;

  const ToppingCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
            // Bottom half – dark bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 37,
              child: Container(
                color: const Color(0xFF3C2F2F),
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
                    GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB03040),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
