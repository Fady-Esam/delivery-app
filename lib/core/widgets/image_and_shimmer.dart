
import 'package:flutter/material.dart';

import 'custom_shimmer.dart';

class ImageAndShimmer extends StatelessWidget {
  const ImageAndShimmer({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'admin_assets/assets/images/shopping_cart.png',
          height: 55,
        ),
        const SizedBox(width: 12),
        CustomShimmer(text: text),
      ],
    );
  }
}
