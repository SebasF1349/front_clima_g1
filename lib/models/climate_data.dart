import 'package:flutter/material.dart';

class ClimateData {
  final String date;
  final double maxTemp;
  final double minTemp;
  final double avgTemp;
  final IconData weatherIcon;
  final String weatherLabel;
  final double? windSpeed;
  final double? rain;

  ClimateData({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.weatherIcon,
    required this.weatherLabel,
    this.windSpeed,
    this.rain,
  });
}
