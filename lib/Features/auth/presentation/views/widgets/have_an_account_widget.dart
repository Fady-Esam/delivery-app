import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/funcs/get_responsive_text.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل ؟',
            style: TextStyles.semiBold16.copyWith(
              color: Color.fromARGB(255, 108, 112, 113),
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
                Navigator.pop(context);
              },
            text: 'تسجيل الدخول',
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
