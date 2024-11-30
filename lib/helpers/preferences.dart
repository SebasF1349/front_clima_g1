import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String _theme = 'mocha';
  static String _darkTheme = 'mocha';
  static String _lightTheme = 'latte';
  static double _latitude = 0.0;
  static double _longitude = 0.0;
  static String _city = '';
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get theme {
    return _prefs.getString('theme') ?? _theme;
  }

  static String get darkTheme {
    return _prefs.getString('dark_theme') ?? _darkTheme;
  }

  static String get lightTheme {
    return _prefs.getString('light_theme') ?? _lightTheme;
  }

  static set theme(String value) {
    _theme = value;
    _prefs.setString('theme', value);
  }

  static set darkTheme(String value) {
    _darkTheme = value;
    _prefs.setString('dark_theme', value);
  }

  static set lightTheme(String value) {
    _lightTheme = value;
    _prefs.setString('light_theme', value);
  }

  static double get latitude {
    return _prefs.getDouble('latitude') ?? _latitude;
  }

  static set latitude(double value) {
    _latitude = value;
    _prefs.setDouble('latitude', value);
  }

  static double get longitude {
    return _prefs.getDouble('longitude') ?? _longitude;
  }

  static set longitude(double value) {
    _longitude = value;
    _prefs.setDouble('longitude', value);
  }

  static String get city {
    return _prefs.getString('city') ?? _city;
  }

  static set city(String value) {
    _city = value;
    _prefs.setString('city', value);
  }

  static Flavor getTheme() {
    return switch (getThemeSaved()) {
      'latte' => catppuccin.latte,
      'frappe' => catppuccin.frappe,
      'macchiato' => catppuccin.macchiato,
      'mocha' => catppuccin.mocha,
      _ => catppuccin.mocha
    };
  }

  static String getThemeSaved() {
    String currentTheme = theme;
    if (currentTheme == 'sistema') {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      currentTheme = brightness == Brightness.light ? lightTheme : darkTheme;
    }
    return currentTheme;
  }
}
