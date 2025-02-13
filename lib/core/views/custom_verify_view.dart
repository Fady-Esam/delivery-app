import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          style: TextStyles.bold23,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.phoneNumber} أدخل الرمز التأكيدي الذي أرسلناه إلى رقم',
              style: TextStyles.semiBold16.copyWith(
                color: const Color.fromARGB(255, 83, 88, 88),
              ),
            ),
            const SizedBox(height: 22),
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
            const SizedBox(height: 22),
            CustomButton(
              onPressed: _handleInputComplete,
              text: "تحقق من الرمز",
            ),
            const SizedBox(height: 18),
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
                    fontSize: 18,
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
      width: MediaQuery.of(context).size.width * .16,
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
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
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
