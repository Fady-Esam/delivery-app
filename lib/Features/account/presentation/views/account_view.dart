
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saree3_mobile/core/cubits/change_language_cubit/change_language_cubit.dart';
import '../../../../core/cubits/change_theme_cubit/change_theme_cubit.dart';


class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: [
          IconButton(
            //color: Colors.purple,
            icon: const Icon(Icons.language),
            onPressed: () async {
              String loadedLang =
                  await BlocProvider.of<ChangeLanguageCubit>(context)
                      .getSavedLanguage();
              final String langCode = loadedLang == "ar" ? "en" : "ar";
              await BlocProvider.of<ChangeLanguageCubit>(context)
                  .changeLanguage(langCode);
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () async {
              ThemeMode mode = await BlocProvider.of<ChangeThemeCubit>(context).getSavedTheme();
              ThemeMode themeMode = mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
              await BlocProvider.of<ChangeThemeCubit>(context).changeTheme(themeMode);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(""),
      ),
    );
  }
}
