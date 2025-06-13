import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../signup_view.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'لا تمتلك حساب؟',
            style: TextStyles.semiBold16.copyWith(
              color: const Color.fromARGB(255, 79, 82, 83),
              fontSize: getResponsiveFontSize(context, fontSize: 16),
            ),
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.semiBold16.copyWith(
              color: const Color(0xFF616A6B),
              fontSize: getResponsiveFontSize(context, fontSize: 16),
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
            text: 'قم بإنشاء حساب',
            style: TextStyles.semiBold16.copyWith(
              color: AppColors.primaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 16),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
