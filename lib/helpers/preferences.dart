import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String _theme = 'mocha';
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

  static Flavor getTheme() {
    return switch (_theme) {
      'latte' => catppuccin.latte,
      'frappe' => catppuccin.frappe,
      'macchiato' => catppuccin.macchiato,
      'mocha' => catppuccin.mocha,
      _ => catppuccin.mocha
    };
  }
}
