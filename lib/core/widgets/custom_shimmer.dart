import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.text,
    this.fontSize = 23,
  });

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 500),
      baseColor: Colors.purple,
      highlightColor: Colors.pink,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
