import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class ChooseCard extends StatefulWidget {
  const ChooseCard({
    super.key,
    required this.descriptionText,
    required this.buttonText,
    required this.onButtonTextClick,
    required this.imagePath,
    required this.isSelected,
  });

  final String descriptionText;
  final String buttonText;
  final void Function() onButtonTextClick;
  final String imagePath;
  final bool isSelected;

  @override
  State<ChooseCard> createState() => _ChooseCardState();
}

class _ChooseCardState extends State<ChooseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffD9D9D9),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.descriptionText,
                  style: TextStyles.semiBold13.copyWith(
                    fontSize: 15,
                    color: Color.fromARGB(255, 53, 58, 59),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: widget.onButtonTextClick,
                  style: TextButton.styleFrom(
                    backgroundColor: !widget.isSelected
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor, // Blue background
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8), // Padding
                  ),
                  child: Text(
                    widget.buttonText,
                    style: TextStyles.bold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Image.asset(
                widget.imagePath,
              ),
            )
          ],
        ),
      ),
    );
  }
}