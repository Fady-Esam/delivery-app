import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';

class ChooseRiderCustomWidget extends StatelessWidget {
  const ChooseRiderCustomWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
  });
  final String imagePath;
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: !isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            right: text == "دراجة هوائية" ? 60 : 72,
            left: 14),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Text(
                  "سائق",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Positioned(
              top: text == "دراجة هوائية" ? -20 : -35,
              right: text == "دراجة هوائية" ? -85 : -90,
              child: SvgPicture.asset(
                imagePath,
                height: 120,
                width: 120,
                // fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      ),
    );
  }
}
