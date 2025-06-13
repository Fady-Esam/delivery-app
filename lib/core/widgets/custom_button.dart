import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return SizedBox(
      width: double.infinity,
      height: isTablet ? 64.h : 48.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.r,
            ),
          ),
          backgroundColor: Color(0xff003DA6),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.bold16.copyWith(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 16)),
        ),
      ),
    );
  }
}
