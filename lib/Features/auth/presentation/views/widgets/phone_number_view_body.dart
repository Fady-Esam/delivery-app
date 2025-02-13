import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyles.bold23,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text(
                widget.description,
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromARGB(255, 30, 26, 26),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                  hintText: 'رقم الهاتف',
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        widget.onClickBtn(phoneNumber);
                        // Rest of Logic
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text:widget.buttonTitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
