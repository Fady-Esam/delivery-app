import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageInitial());
  Future<void> changeLanguage(String newLanguageCode) async {
    final newLocale = Locale(newLanguageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", newLanguageCode);
    emit(ChangeLanguageDone(language: newLocale));
  }

  Future<String> getSavedLanguage() async {
    String deviceLang = PlatformDispatcher.instance.locale.languageCode;
    String defaultLangCode =
        deviceLang == "ar" || deviceLang == "en" ? deviceLang : "ar";
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("language") ?? defaultLangCode;
  }
}
