import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestImageView extends StatelessWidget {
  static const routeName = "test";

  const TestImageView({super.key});

  // Function to check if the image is SVG and return the correct widget
  Widget _getImageWidget(String path) {
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: 1000,
        height: 543,
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        path,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test SVG & Asset Images")),
      body: Center(
        child: _getImageWidget(
          "assets/images/motor_cycle_rider.svg",
        ), // Display image based on type
      ),
    );
  }
}
