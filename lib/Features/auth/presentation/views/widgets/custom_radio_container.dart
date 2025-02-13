// import 'package:flutter/material.dart';

// import '../../../../../core/utils/app_colors.dart';

// class CustomRadioContainer extends StatelessWidget {
//   const CustomRadioContainer({
//     super.key,
//     required this.isSelected,
//   });
//   final bool isSelected;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 24,
//       height: 24,
//       decoration: BoxDecoration(
//         color: isSelected ? AppColors.primaryColor : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isSelected ? AppColors.primaryColor : Colors.grey,
//           width: 2,
//         ),
//       ),
//       child: isSelected
//           ? Icon(
//               Icons.check,
//               color: Colors.white,
//               size: 16,
//             )
//           : null,
//     );
//   }
// }