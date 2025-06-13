import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitial());
  Future<void> changeTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", newTheme.toString().split('.').last);
    emit(ChangeThemeDone(theme: newTheme));
  }

  Future<ThemeMode> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString("theme") ?? "system";
    return getThemeModeFromString(savedTheme);
  }
  ThemeMode getThemeModeFromString(String theme) {
    switch (theme) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

}
