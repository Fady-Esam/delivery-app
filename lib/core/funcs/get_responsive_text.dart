import 'package:flutter/material.dart';

double getResponsiveFontSize(
  BuildContext? context,{
  required double fontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  return responsiveFontSize.clamp(fontSize * 0.8, fontSize * 1.2);
}

double getScaleFactor(BuildContext? context) {
  final double width = context != null ? MediaQuery.of(context).size.width : 0;
  if (width < 600) {
    return width / 400;
  } else {
    return width / 600; // 700
  }
  // else if (width < 900) {
  //   return width / 600;
  // } else {
  //   return width / 800;
  // }
}
