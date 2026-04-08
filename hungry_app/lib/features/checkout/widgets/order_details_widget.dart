import 'package:flutter/material.dart';
import 'package:full_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkoutWidget('Order', order, false, false),
        Gap(10),
        checkoutWidget('Taxes', taxes, false, false),
        Gap(10),
        checkoutWidget('Delivery fees', fees, false, false),
        Gap(10),
        Divider(),
        Gap(10),
        checkoutWidget('Total', total, true, false),
        Gap(10),
        checkoutWidget('Estimated delivery time:', '100.3', true, true),
      ],
    );
  }
}

Widget checkoutWidget(String title, price, bool isBold, bool isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        size: isSmall ? 12 : 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
      CustomText(
        text: '$price\$',
        size: isSmall ? 12 : 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
