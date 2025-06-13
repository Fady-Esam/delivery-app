import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saree3_mobile/core/cubits/change_language_cubit/change_language_cubit.dart';
import 'package:saree3_mobile/core/cubits/change_language_cubit/change_language_state.dart';
import 'package:saree3_mobile/core/utils/app_colors.dart';
import 'package:saree3_mobile/core/utils/app_images.dart';
import 'package:saree3_mobile/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/home/presentation/views/home_view.dart';
import 'Features/account/presentation/views/account_view.dart';

class TabsNavBar extends StatefulWidget {
  const TabsNavBar({super.key});

  @override
  State<TabsNavBar> createState() => _TabsNavBarState();
}

class _TabsNavBarState extends State<TabsNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const Center(child: Text("صفحة الطلبات", style: TextStyle(fontSize: 20))),
    const Center(child: Text("صفحة الإشعارات", style: TextStyle(fontSize: 20))),
    AccountView(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  String lang = "ar";
  Future<void> getLoadedLanguage() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
    lang = prefs.getString('language') ?? "ar";
      
    });
  }
  @override
  initState() {
    super.initState();
    getLoadedLanguage();
  }



  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : AppColors.primaryColor;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color shadowColor = isDarkMode ? Colors.black54 : Colors.black26;
    final Color unselectedItemColor =
        isDarkMode ? Colors.white70 : Colors.black54;
    final Color navBarBackground =
        isDarkMode ? Colors.grey[900]! : Colors.grey[100]!;

    final List<Map<String, dynamic>> navItems = [
      {"label": S.of(context).home, "icon": Assets.imageHomeIcon},
      {"label": S.of(context).orders, "icon": Assets.imageOrdersIcon},
      {
        "label": S.of(context).notifications,
        "icon": Assets.imageNotificationIcon
      },
      {"label": S.of(context).account, "icon": Assets.imageUserProfileIcon},
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: navBarBackground,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 7,
              spreadRadius: 0.5,
              //offset: const Offset(0, -2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navItems.asMap().entries.map((entry) {
            int index = entry.key;
            String iconPath = entry.value["icon"];
            String label = entry.value["label"];
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onNavItemTapped(index),
              child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                builder: (context, state)  {
                  if (state is ChangeLanguageDone){
                    lang = state.language.languageCode;
                  }
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(
                      left: lang == "ar" ? 12 : 8,
                      right: lang == "en" ? 12 : 8,
                      top: 0.5,
                      bottom: 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? !isDarkMode
                              ? Color(0xffDADADA)
                              : Color.fromARGB(255, 114, 113, 113)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 42,
                          width: 42,
                          decoration: isSelected
                              ? BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                )
                              : null,
                          child: Center(
                            child: SvgPicture.asset(
                              iconPath,
                              height: 25,
                              width: 25,
                              colorFilter: ColorFilter.mode(
                                isSelected ? Colors.white : unselectedItemColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
