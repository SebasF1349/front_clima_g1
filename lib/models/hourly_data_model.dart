import 'package:clima_app/models/hourly_units_model.dart';
import 'package:clima_app/models/hourly_model.dart';

class HourlyData {
  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  int elevation;
  HourlyUnits hourlyUnits;
  Hourly hourly;

  HourlyData({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyUnits,
    required this.hourly,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) => HourlyData(
        latitude: json["latitude"],
        longitude: json["longitude"],
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
        hourly: Hourly.fromJson(json["hourly"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "hourly_units": hourlyUnits.toJson(),
        "hourly": hourly.toJson(),
      };
}
