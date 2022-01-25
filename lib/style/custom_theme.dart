import 'package:chat_app_nodejs/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomTheme {
  // final bool isDark;
  // CustomTheme(this.isDark);
  // static ThemeData themeData = ThemeData.light()
  //   ..copyWith(
  //     primaryColorLight: Colors.pink,
  //     accentColor: Colors.amber,
  //     scaffoldBackgroundColor: Colors.white,
  //     //
  //     textTheme: const TextTheme(
  //         headline5: TextStyle(fontFamily: 'ubuntu', color: Colors.pink)),

  //   );
  // static bool isDark = false;
  static const Color _primaryColor = Colors.pink;
  static const Color _secondaryColor = Colors.red;
  //
  static ThemeData themeData(BuildContext context) {
    final _settingProvider = context.watch<SettingsProvider>();
    // if (_settingProvider.isDark) {
    //   return ThemeData.dark().copyWith(
    //     appBarTheme: const AppBarTheme(
    //       elevation: 0.0,
    //     ),
    //     textTheme: const TextTheme(
    //       headline5: TextStyle(
    //         fontFamily: 'ubuntu',
    //         color: Colors.brown,
    //       ),
    //     ),
    //   );
    // }
    // return ThemeData.light().copyWith(
    //   primaryColor: _primaryColor,
    //   appBarTheme: const AppBarTheme(
    //     elevation: 0.0,
    //     color: _primaryColor,
    //   ),
    //   textTheme: const TextTheme(
    //     headline5: TextStyle(
    //       fontFamily: 'ubuntu',
    //       color: Colors.brown,
    //     ),
    //   ),
    // );
    return ThemeData(
      primaryColor: Colors.pink,
      primaryColorLight: Colors.amber,
      colorScheme: ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness:
            _settingProvider.isDark ? Brightness.dark : Brightness.light,
        primary: _primaryColor,
        primaryVariant: _primaryColor,
        secondary: _secondaryColor,
        secondaryVariant: _primaryColor,
        background: _primaryColor,
        surface: _primaryColor,
        onBackground: _primaryColor,
        onSurface: _primaryColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400,
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(
          fontFamily: 'ubuntu',
          color: Colors.brown,
        ),
      ),
    );
  }

  //
  static TextStyle fontTheme(BuildContext context) =>
      Theme.of(context).textTheme.headline6!;
  //
  static TextStyle customfontTheme(BuildContext context,
          {double? fontSize, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 14.0,
        fontFamily: 'ubuntu',
        color: color,
      );
}
