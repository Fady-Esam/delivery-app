// import 'package:flutter/material.dart';



// class TitleAndPriceDetails extends StatelessWidget {
//   const TitleAndPriceDetails({
//     super.key,
//     required this.widget,
//   });

//   final ProductItemDetailsView widget;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.sizeOf(context).width * 0.7,
//           ),
//           child: Text(
//             widget.productModel.productTitle,
//             style: const TextStyle(
//               fontSize: 20,
//             ),
//           ),
//         ),
//         Flexible(
//           child: Text(
//             '\$${widget.productModel.productPrice}',
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Colors.blue,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
