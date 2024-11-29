import 'package:flutter/material.dart';
import 'package:flutter_application_base/themes/catppuccin_theme.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData temaActual;

  ThemeProvider({required Flavor flavor})
      : temaActual = catppuccinTheme(flavor);

  setTheme(Flavor flavor) {
    temaActual = catppuccinTheme(flavor);
    notifyListeners();
  }

  setLatte() {
    temaActual = catppuccinTheme(catppuccin.latte);
    notifyListeners();
  }

  setFrappe() {
    temaActual = catppuccinTheme(catppuccin.frappe);
    notifyListeners();
  }

  setMacchiato() {
    temaActual = catppuccinTheme(catppuccin.macchiato);
    notifyListeners();
  }

  setMocha() {
    temaActual = catppuccinTheme(catppuccin.mocha);
    notifyListeners();
  }
}
