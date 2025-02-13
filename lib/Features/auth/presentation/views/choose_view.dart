import 'package:flutter/material.dart';

import 'package:saree3_mobile/Features/auth/presentation/views/phone_number_view.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/choose_card.dart';
import 'widgets/choose_rider_custom_widget.dart';
import 'widgets/or_divider.dart';

class ChooseView extends StatefulWidget {
  const ChooseView({super.key});
  static const routeName = 'choose';
  @override
  State<ChooseView> createState() => _ChooseViewState();
}

class _ChooseViewState extends State<ChooseView> {
  int selectedIndex = -1;
  int selectedDriverIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اختر نوع التسجيل",
          style: TextStyles.bold23,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            const SizedBox(height: 28),
            ChooseCard(
              descriptionText: '''
التسجيل كسائق ( ديليفري )
ستقوم بتوصيل الطلب الذي سيطلبه
العميل الي المكان الذي حدده لك.
            ''',
              buttonText: "سجل كسائق",
              imagePath: Assets.imageChooseRider,
              isSelected: selectedIndex == 0,
              onButtonTextClick: () {
                if (selectedIndex == 1 || selectedIndex == -1) {
                  setState(() {
                    selectedIndex = 0;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            if (selectedIndex == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedDriverIndex == 1 ||
                          selectedDriverIndex == -1) {
                        setState(() {
                          selectedDriverIndex = 0;
                        });
                      }
                    },
                    child: ChooseRiderCustomWidget(
                      imagePath: Assets.imageBikeRider,
                      text: "دراجة هوائية",
                      isSelected: selectedDriverIndex == 0,
                    ),
                  ),
                  Text(
                    "أو",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff141F1F),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (selectedDriverIndex == 0 ||
                          selectedDriverIndex == -1) {
                        setState(() {
                          selectedDriverIndex = 1;
                        });
                      }
                    },
                    child: ChooseRiderCustomWidget(
                      imagePath: Assets.imageMotorCycleRider,
                      text: "دراجة نارية",
                      isSelected: selectedDriverIndex == 1,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 22),
            OrDivider(),
            const SizedBox(height: 22),
            ChooseCard(
              descriptionText: '''
التسجيل كزبون ( مشتري )
ستقوم بطلب الاوردر الذي تحتاجه
ثم تختار السائق الاقرب لك لطلب 
لطلب الاوردر وتوصيله لك.
            ''',
              buttonText: "سجل كزبون",
              imagePath: Assets.imageChooseCustomer,
              onButtonTextClick: () {
                if (selectedIndex == 0 || selectedIndex == -1) {
                  setState(() {
                    selectedIndex = 1;
                  });
                }
              },
              isSelected: selectedIndex == 1,
            ),
            const SizedBox(height: 42),
            if ((selectedIndex == 0 && selectedDriverIndex != -1) ||
                selectedIndex == 1)
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: CustomButton(
                  onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PhoneNumberView.routeName,
                    arguments: {
                      'buttonTitle': 'تأكيد',
                      'description': 'رجاء ادخل رقم الهاتف لتتمكن من الاستمرار وتأكد من كتابة الرقم بشكل صحيح',
                      'title': 'رقم الهاتف' ,
                      'onClickBtn': (String phoneNumber) {
                        // logic Here
                      }
                    },
                  );
                  },
                  text: "استمرار",
                ),
              ),
          ],
        ),
      ),
    );
  }
}
