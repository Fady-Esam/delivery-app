import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class PhoneNumberViewBody extends StatefulWidget {
  const PhoneNumberViewBody({
    super.key,
    required this.title,
    required this.description,
    required this.buttonTitle,
    required this.onClickBtn,
  });
  final String title;
  final String description;
  final String buttonTitle;
  final void Function(String phonNumber) onClickBtn;

  @override
  State<PhoneNumberViewBody> createState() => _PhoneNumberViewBodyState();
}

class _PhoneNumberViewBodyState extends State<PhoneNumberViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyles.bold23.copyWith(
              fontSize: getResponsiveFontSize(context, fontSize: 23)
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28.h),
                      Text(
                      widget.description,
                        style: TextStyle(
                          fontSize: getResponsiveFontSize(context, fontSize: 19),
                          color: Color.fromARGB(255, 30, 26, 26),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        onSaved: (value) {
                          phoneNumber = value!;
                        },
                        hintText: 'رقم الهاتف',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: isTablet ? MediaQuery.sizeOf(context).width * 0.75 : MediaQuery.sizeOf(context).width * 0.9,
                          child: CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                widget.onClickBtn(phoneNumber);
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                            text:widget.buttonTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
