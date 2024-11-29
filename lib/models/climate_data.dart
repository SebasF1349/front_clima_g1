import 'package:flutter/material.dart';

class ClimateData {
  final double maxTemp;
  final double minTemp;
  final String date;
  final IconData weatherIcon;
  final String weatherLabel;

  ClimateData({
    required this.maxTemp,
    required this.minTemp,
    required this.date,
    required this.weatherIcon,
    required this.weatherLabel,
  });
}
