import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../funcs/get_responsive_text.dart';
import '../utils/app_text_styles.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    super.key,
    required this.labelText,
    required this.image,
    required this.onPressed,
  });

  final String labelText;
  final String image;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFDCDEDE), width: 1),
            borderRadius: BorderRadius.circular(
              16.r,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              image,
            ),
            Spacer(),
            Text(
              labelText,
              style: TextStyles.semiBold16.copyWith(
                  fontSize: getResponsiveFontSize(context, fontSize: 16)),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
