import 'package:flutter/material.dart';

void showSnackBarFun({
  required BuildContext context,
  required String text,
  //Color backgroundColor = Colors.red,
  //Duration duration = const Duration(seconds: 3),
}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    //backgroundColor: backgroundColor,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating, // Makes it float above the bottom
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Use ScaffoldMessenger to show the SnackBar
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar() // Ensure no other snack bar is showing
    ..showSnackBar(snackBar);
}
