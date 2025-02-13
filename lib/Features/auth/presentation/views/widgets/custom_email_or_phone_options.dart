// import 'package:flutter/material.dart';

// import '../../../../../core/utils/app_text_styles.dart';
// import 'custom_radio_container.dart';

// class CustomEmailOrPhoneOptions extends StatefulWidget {
//   const CustomEmailOrPhoneOptions({super.key, required this.onSelect});
//   final void Function(int slectedIndex) onSelect;
//   @override
//   State<CustomEmailOrPhoneOptions> createState() =>
//       _CustomEmailOrPhoneOptionsState();
// }

// class _CustomEmailOrPhoneOptionsState extends State<CustomEmailOrPhoneOptions> {
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       width: MediaQuery.of(context).size.width * 0.6,
//       decoration: BoxDecoration(
//         color: Color.fromARGB(
//           10,
//           128,
//           128,
//           128,
//         ), // Replace with your desired background color
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   selectedIndex = 0;
//                   setState(() {});
//                   widget.onSelect(selectedIndex);
//                 },
//                 child: CustomRadioContainer(isSelected: selectedIndex == 0),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 'البريد الالكتروني',
//                 style: TextStyles.bold16,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   selectedIndex = 1;
//                   setState(() {});
//                   widget.onSelect(selectedIndex);
//                 },
//                 child: CustomRadioContainer(isSelected: selectedIndex == 1),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 'رقم الموبايل',
//                 style: TextStyles.bold16,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
