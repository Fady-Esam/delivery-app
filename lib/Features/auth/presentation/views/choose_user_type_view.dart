import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/phone_number_view.dart';
import 'package:saree3_mobile/core/funcs/get_responsive_text.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'widgets/choose_user_type_card.dart';
import 'widgets/choose_rider_type_card.dart';
import 'widgets/or_divider.dart';

class VehicleModel {
  final String title;
  final String imagePath;
  final double height;
  final double width;

  VehicleModel({
    required this.title,
    required this.imagePath,
    required this.height,
    required this.width,
  });
}

class ChooseUserTypeView extends StatefulWidget {
  const ChooseUserTypeView({super.key});
  static const routeName = 'choose';
  @override
  State<ChooseUserTypeView> createState() => _ChooseUserTypeViewState();
}

class _ChooseUserTypeViewState extends State<ChooseUserTypeView> {
  int selectedIndex = -1;
  int selectedDriverIndex = -1;
  final List<VehicleModel> vehicles = [
    VehicleModel(
      title: "اسكيت",
      imagePath: Assets.imageSkateRider,
      height: 77,
      width: 75,
    ),
    VehicleModel(
      title: "تروسكل",
      imagePath: Assets.imageTricycleRider,
      height: 85,
      width: 95,
    ),
    VehicleModel(
      title: "دراجة هوائية",
      imagePath: Assets.imageBicycleRider,
      height: 85,
      width: 50,
    ),
    VehicleModel(
      title: "دراجة نارية",
      imagePath: Assets.imageMotorCycleRider,
      height: 80,
      width: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اختر نوع التسجيل",
          style: TextStyles.bold23.copyWith(
            fontSize: getResponsiveFontSize(context, fontSize: 19),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 27.h),
              SizedBox(
                width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
                child: ChooseUserTypeCard(
                  descriptionText:
                      "ستقوم بتوصيل الطلب الذي سيطلبه العميل الي المكان الذي حدده لك.",
                  titleText: "التسجيل كسائق ( ديليفري )",
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
              ),
              if (selectedIndex == 0) ...[
                const SizedBox(
                  height: 28,
                ),
                IntrinsicHeight(
                  child: SizedBox(
                    width: isTablet
                        ? MediaQuery.sizeOf(context).width * 0.7
                        : null,
                    child: Center(
                      child: SingleChildScrollView(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: vehicles.map((vehicle) {
                            final int index = vehicles.indexOf(vehicle);
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDriverIndex =
                                        selectedDriverIndex == index
                                            ? -1
                                            : index;
                                  });
                                },
                                child: ChooseRiderCustomCard(
                                  imagePath: vehicle.imagePath,
                                  text: vehicle.title,
                                  isSelected: selectedDriverIndex == index,
                                  imageHeight: vehicle.height,
                                  imageWidth: vehicle.width,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
              SizedBox(height: selectedIndex == 0 ? 24 : 12),
              OrDivider(),
              const SizedBox(height: 12),
              SizedBox(
                width: isTablet ? MediaQuery.sizeOf(context).width * 0.8 : null,
                child: ChooseUserTypeCard(
                  descriptionText:
                      "ستقوم بتوصيل الطلب الذي سيطلبه العميل الي المكان الذي حدده لك.",
                  titleText: "التسجيل كزبون ( مشتري )",
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
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              if ((selectedIndex == 0 && selectedDriverIndex != -1) ||
                  selectedIndex == 1)
                SizedBox(
                  width:
                      isTablet ? MediaQuery.sizeOf(context).width * 0.7 : null,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PhoneNumberView.routeName,
                        arguments: {
                          'buttonTitle': 'تأكيد',
                          'description':
                              'رجاء ادخل رقم الهاتف لتتمكن من الاستمرار وتأكد من كتابة الرقم بشكل صحيح',
                          'title': 'رقم الهاتف',
                          'onClickBtn': (String phoneNumber) {
                            // logic Here
                          }
                        },
                      );
                    },
                    text: "استمرار",
                  ),
                ),
              SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}
