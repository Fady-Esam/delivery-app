import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class ChooseUserTypeCard extends StatefulWidget {
  const ChooseUserTypeCard({
    super.key,
    required this.descriptionText,
    required this.titleText,
    required this.buttonText,
    required this.onButtonTextClick,
    required this.imagePath,
    required this.isSelected,
  });

  final String descriptionText;
  final String titleText;
  final String buttonText;
  final void Function() onButtonTextClick;
  final String imagePath;
  final bool isSelected;

  @override
  State<ChooseUserTypeCard> createState() => _ChooseUserTypeCardState();
}

class _ChooseUserTypeCardState extends State<ChooseUserTypeCard> {
  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return Card(
      color: Color(0xffD9D9D9),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 300.w : 210.w,
                      ),
                      child: Text(
                        widget.titleText,
                        style: TextStyles.semiBold13.copyWith(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16),
                          color: Color.fromARGB(255, 53, 58, 59),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 300.w : 210.w,
                      ),
                      child: Text(
                        widget.descriptionText,
                        style: TextStyles.semiBold13.copyWith(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16),
                          color: Color.fromARGB(255, 120, 125, 126),
                        ),
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Spacer(),
                    TextButton(
                      onPressed: widget.onButtonTextClick,
                      style: TextButton.styleFrom(
                        backgroundColor: !widget.isSelected
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 38.w : 16.w,
                          vertical: isTablet ? 18.h: 8.h,
                        ),
                      ),
                      child: Text(
                        widget.buttonText,
                        style: TextStyles.bold16.copyWith(
                          color: Colors.white,
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16),
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.fill,
                  height: 250.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
