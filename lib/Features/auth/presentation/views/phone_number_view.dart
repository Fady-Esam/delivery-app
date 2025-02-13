import 'package:flutter/material.dart';

import 'widgets/phone_number_view_body.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({
    super.key,
    required this.buttonTitle,
    required this.description,
    required this.title,
    required this.onClickBtn,
  });
  static const routeName = "phoneNumber";
  final String buttonTitle;
  final String description;
  final String title;
  final void Function(String phoneNumber) onClickBtn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhoneNumberViewBody(
        buttonTitle: buttonTitle,
        description: description,
        title: title,
        onClickBtn: onClickBtn,
      ),
    );
  }
}
