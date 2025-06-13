import 'package:flutter/material.dart';


import '../../../../../core/funcs/get_responsive_text.dart';
import '../../../../../core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFDCDEDE),
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Text(
          'أو',
          textAlign: TextAlign.center,
          style: TextStyles.semiBold16.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 16)
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFDCDEDE),
          ),
        ),
      ],
    );
  }
}
