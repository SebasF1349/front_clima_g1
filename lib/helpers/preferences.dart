import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String _theme = 'mocha';
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

  static set theme(String value) {
    _theme = value;
    _prefs.setString('theme', value);
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
    return switch (_prefs.getString('theme')) {
      'latte' => catppuccin.latte,
      'frappe' => catppuccin.frappe,
      'macchiato' => catppuccin.macchiato,
      'mocha' => catppuccin.mocha,
      _ => catppuccin.mocha
    };
  }
}
