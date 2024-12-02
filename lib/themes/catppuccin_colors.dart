import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:flutter/material.dart';

Map<String, Color> catppuccinColors() {
  Flavor flavor = Preferences.getTheme();

  return {
    "rosewater": flavor.rosewater,
    "flamingo": flavor.flamingo,
    "pink": flavor.pink,
    "mauve": flavor.mauve,
    "red": flavor.red,
    "maroon": flavor.maroon,
    "peach": flavor.peach,
    "yellow": flavor.yellow,
    "green": flavor.green,
    "teal": flavor.teal,
    "sky": flavor.sky,
    "sapphire": flavor.sapphire,
    "blue": flavor.blue,
    "lavender": flavor.lavender,
    "text": flavor.text,
    "subtext1": flavor.subtext1,
    "subtext0": flavor.subtext0,
    "overlay2": flavor.overlay2,
    "overlay1": flavor.overlay1,
    "overlay0": flavor.overlay0,
    "surface2": flavor.surface2,
    "surface1": flavor.surface1,
    "surface0": flavor.surface0,
    "crust": flavor.crust,
    "mantle": flavor.mantle,
    "base": flavor.base,
  };
}
