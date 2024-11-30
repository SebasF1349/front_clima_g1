import 'package:flutter_application_base/models/hourly_model.dart';
import 'package:flutter_application_base/models/hourly_data_model.dart';
import 'package:flutter_application_base/models/hourly_forecast_model.dart';
import 'package:flutter_application_base/models/hourly_units_model.dart';

HourlyForecast pronosticoHistorial = HourlyForecast(
  msg: "Ok",
  data: HourlyData(
    latitude: 80,
    longitude: 10,
    generationtimeMs: 11.6209983825684,
    utcOffsetSeconds: -10800,
    timezone: 'Etc/GMT+3',
    timezoneAbbreviation: '-03',
    elevation: 0,
    hourlyUnits: HourlyUnits(
      time: "iso8601",
      temperature2M: "°C",
      apparentTemperature: "°C",
      precipitationProbability: "%",
      rain: "mm",
      weatherCode: "wmo code",
    ),
    hourly: Hourly(
      time: List.generate(
        57,
        (index) => DateTime.parse("2024-11-23T00:00").add(Duration(hours: index)),
      ),
      temperature2M: List.generate(57, (index) => -3.0 + (index % 10) * 0.1),
      apparentTemperature: List.generate(57, (index) => -8.0 + (index % 10) * 0.2),
      precipitationProbability: List.generate(57, (index) => (index % 100)),
      rain: List.generate(57, (index) => (index % 2 == 0 ? 0.0 : 0.1)),
      weatherCode: List.generate(57, (index) => [2, 3, 85, 86, 71][index % 5]),
    ),
  ),
);
