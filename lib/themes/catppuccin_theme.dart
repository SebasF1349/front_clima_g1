import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

ThemeData catppuccinTheme(Flavor flavor) {
  Color primaryColor = flavor.mauve;
  Color secondaryColor = flavor.pink;

  Brightness brightness =
      flavor == catppuccin.latte || flavor == catppuccin.frappe
          ? Brightness.light
          : Brightness.dark;

  return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: flavor.text),
        elevation: 10,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: flavor.text, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: flavor.crust,
        foregroundColor: flavor.mantle,
        toolbarHeight: 80,
      ),
      iconTheme: IconThemeData(color: flavor.pink),
      listTileTheme: ListTileThemeData(iconColor: primaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: flavor.surface1,
              foregroundColor: primaryColor,
              elevation: 3)),
      cardTheme: CardTheme(color: flavor.surface1, elevation: 3),
      colorScheme: ColorScheme(
        brightness: brightness,
        error: flavor.surface2,
        onError: flavor.red,
        onPrimary: primaryColor,
        onSecondary: secondaryColor,
        onSurface: flavor.text,
        primary: flavor.crust,
        secondary: flavor.mantle,
        surface: flavor.surface0,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: flavor.text,
        displayColor: primaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
      ));
}
