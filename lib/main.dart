import 'dart:io';
import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saree3_mobile/core/cubits/change_language_cubit/change_language_cubit.dart';
import 'package:saree3_mobile/core/cubits/change_language_cubit/change_language_state.dart';
import 'package:saree3_mobile/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'core/cubits/change_theme_cubit/change_theme_cubit.dart';
import 'core/cubits/change_theme_cubit/change_theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String deviceLang = PlatformDispatcher.instance.locale.languageCode;
  String defaultLangCode =
      deviceLang == "ar" || deviceLang == "en" ? deviceLang : "ar";
  final savedLanguage = prefs.getString("language") ?? defaultLangCode;
  final savedTheme = prefs.getString("theme") ?? "system";
  runApp(
    //MyApp(),
    DevicePreview(
      enabled: !Platform.isAndroid, // Set to false to disable in production
      //enabled: false,
      builder: (context) => MyApp(
        savedLanguage: savedLanguage,
        savedTheme: savedTheme,
      ), // Your main app widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.savedLanguage,
    required this.savedTheme,
  });
  final String savedLanguage;
  final String savedTheme;
  @override
  Widget build(BuildContext context) {
    ThemeData setThemeData(Brightness brightness) {
      return ThemeData(
        fontFamily: "Cairo",
        brightness: brightness,
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: AppColors.primaryColor,
        //   brightness: brightness,
        // ),
        useMaterial3: true,
      );
    }

    Locale locale = Locale(savedLanguage);
    ThemeMode mode = savedTheme == "dark"
        ? ThemeMode.dark
        : savedTheme == "light"
            ? ThemeMode.light
            : ThemeMode.system;
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // Default design size for a mobile layout
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        log("width: ${MediaQuery.of(context).size.width}");
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ChangeLanguageCubit()),
            BlocProvider(create: (context) => ChangeThemeCubit()),
          ],
          child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
            builder: (context, state) {
              if (state is ChangeThemeDone) {
                mode = state.theme;
              }
              return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                builder: (context, state) {
                  if (state is ChangeLanguageDone) {
                    locale = state.language;
                  }
                  return MaterialApp(
                    //builder: DevicePreview.appBuilder,
                    locale: locale,
                    localizationsDelegates: [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    themeMode: mode == ThemeMode.dark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    theme: setThemeData(Brightness.light),
                    darkTheme: setThemeData(Brightness.dark),
                    // onGenerateRoute: onGenerateRoute,
                    // initialRoute: ChooseUserTypeView.routeName,
                    home: TestView(),
                    debugShowCheckedModeBanner: false,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(26.560062585563415, 31.686161969533767,), zoom: 15),
    ));
  }
}
