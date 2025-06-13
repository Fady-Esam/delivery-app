import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';

class CustomVerifyView extends StatefulWidget {
  const CustomVerifyView({
    super.key,
    required this.phoneNumber,
    this.isFromForgottonPassword = false,
  });
  static const String routeName = "customVerify";
  final String phoneNumber;
  final bool isFromForgottonPassword;

  @override
  State<CustomVerifyView> createState() => _CustomVerifyViewState();
}

class _CustomVerifyViewState extends State<CustomVerifyView> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleInputComplete() {
    final code = _controllers.map((c) => c.text).join();
    log('Entered Code: $code');
    // Do not Forget To reverse it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "التحقق من الرمز",
          style: TextStyles.bold23
              .copyWith(fontSize: getResponsiveFontSize(context, fontSize: 23)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أدخل الرمز التأكيدي الذي ارسلناه الي ${widget.phoneNumber}',
              style: TextStyles.semiBold16.copyWith(
                  color: const Color.fromARGB(255, 83, 88, 88),
                  fontSize: getResponsiveFontSize(context, fontSize: 16)),
            ),
            SizedBox(height: 22.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final reversedIndex = 3 - index;
                return CodeInputField(
                  autoFocus: reversedIndex == 3,
                  focusNode: _focusNodes[reversedIndex],
                  nextFocusNode:
                      reversedIndex > 0 ? _focusNodes[reversedIndex - 1] : null,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length == 1) {
                      if (reversedIndex == 0) {
                        _handleInputComplete();
                      }
                    }
                  },
                  controller: _controllers[reversedIndex],
                );
              }).reversed.toList(),
            ),
            SizedBox(height: 28.h),
            Align(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: CustomButton(
                  onPressed: () {
                    // check isFromForgottonPassword
                    // Logic To Verify
                  },
                  text: "تحقق من الرمز",
                ),
              ),
            ),
            SizedBox(height: 18.h),
            InkWell(
              onTap: () {
                // Logic To Resend
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "إعادة إرسال الرمز",
                  style: TextStyles.semiBold16.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: getResponsiveFontSize(context, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeInputField extends StatelessWidget {
  const CodeInputField({
    super.key,
    this.autoFocus = false,
    required this.focusNode,
    this.nextFocusNode,
    required this.onChanged,
    required this.controller,
  });

  final bool autoFocus;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .15,
      height: MediaQuery.of(context).size.height * .1,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFA),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 200, 196, 196),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color(0xffDCDEDE),
          width: 1,
        ),
      ),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          cursorHeight: 60.h,
          controller: controller,
          focusNode: focusNode,
          autofocus: autoFocus,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              onChanged(value);
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              } else {
                focusNode.unfocus();
              }
            } else {
              if (focusNode.hasFocus && value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            }
          },
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, fontSize: 30),
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      ),
    );
  }
}
