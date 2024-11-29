import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

ThemeData catppuccinTheme(Flavor flavor) {
  Color primaryColor = flavor.mauve;
  Color secondaryColor = flavor.pink;

  Brightness brightness =
      flavor == catppuccin.latte || flavor == catppuccin.frappe
          ? Brightness.light
          : Brightness
              .dark; // Asumimos que los temas claros tienen 'Brightness.light'

  return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      appBarTheme: AppBarTheme(
          elevation: 0,
          titleTextStyle: TextStyle(
              color: flavor.text, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: flavor.crust,
          foregroundColor: flavor.mantle),
      colorScheme: ColorScheme(
        background: flavor.base,
        brightness: brightness,
        error: flavor.surface2,
        onBackground: flavor.text,
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
