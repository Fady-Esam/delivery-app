import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../../../../../core/utils/app_colors.dart';

class ChooseRiderCustomCard extends StatelessWidget {
  const ChooseRiderCustomCard({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
    required this.imageWidth,
    required this.imageHeight,
  });
  final String imagePath;
  final String text;
  final bool isSelected;
  final double imageWidth;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return SizedBox(
      width: isTablet
          ? MediaQuery.sizeOf(context).width * 0.3
          : MediaQuery.sizeOf(context).width * 0.4,
      child: Card(
        clipBehavior: Clip.none,
        color: !isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 6.h,
            bottom: 6.h,
            //right: 12.w,
            left: isTablet ? 22.w : 8.w,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: !isTablet ? 0.0 : 0.0),
                  child: Column(
                    children: [
                      Text(
                        "سائق",
                        style: TextStyle(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 16),
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -calculateTop(MediaQuery.sizeOf(context).width),
                child: SizedBox(
                  width: imageWidth.w,
                  height: imageHeight,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTop(double screenWidth) {
    if (screenWidth >= 450) {
      return 18; // Default value
    } else {
      return 18 + ((450 - screenWidth) / 20) * 1.3;
    }
  }
}
