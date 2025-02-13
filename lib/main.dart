import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/signin_view.dart';
import 'package:saree3_mobile/Features/auth/presentation/views/signup_view.dart';
import 'package:saree3_mobile/generated/l10n.dart';

import 'Features/auth/presentation/views/add_image_view.dart';
import 'Features/auth/presentation/views/choose_view.dart';
import 'Features/auth/presentation/views/phone_number_view.dart';
import 'Features/auth/presentation/views/reset_password_view.dart';
import 'core/helpers/on_generate_routes.dart';
import 'core/views/custom_verify_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      locale: Locale("ar"),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SigninView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
