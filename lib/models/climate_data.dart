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
  final List<double> hourlyTemperatures;
  final List<DateTime> hourlyTimes;

  ClimateData({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.weatherIcon,
    required this.weatherLabel,
    this.windSpeed,
    this.rain,
    required this.hourlyTemperatures,
    required this.hourlyTimes,
  });

// Método para convertir JSON a ClimateData
  factory ClimateData.fromJson(Map<String, dynamic> json) {
    return ClimateData(
      date: json['date'],
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      avgTemp: (json['avgTemp'] as num).toDouble(),
      weatherIcon: (json['weatherCode']),
      weatherLabel: json['weatherLabel'],
      windSpeed: json['windSpeed'] != null ? (json['windSpeed'] as num).toDouble() : null,
      rain: json['rain'] != null ? (json['rain'] as num).toDouble() : null,
      hourlyTemperatures: (json['hourlyTemperatures'] as List)
          .map((temp) => (temp as num).toDouble())
          .toList(),
      hourlyTimes: (json['hourlyTimes'] as List)
          .map((time) => DateTime.parse(time))
          .toList(),
    );
  }
}
