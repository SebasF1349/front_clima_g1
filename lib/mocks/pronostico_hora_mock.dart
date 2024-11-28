import 'package:flutter_application_base/models/hour_data_model.dart';
import 'package:flutter_application_base/models/hour_forecast_model.dart';
import 'package:flutter_application_base/models/hour_model.dart';
import 'package:flutter_application_base/models/hourly_units_model.dart';

HourForecast pronosticoHora = HourForecast(
    msg: "Ok",
    data: HourData(
        latitude: 80,
        longitude: 10,
        generationtimeMs: 0.0709295272827148,
        utcOffsetSeconds: -10800,
        timezone: "Etc/GMT+3",
        timezoneAbbreviation: "-03",
        elevation: 0,
        hourlyUnits: HourlyUnits(
            time: "iso8601",
            temperature2M: "°C",
            apparentTemperature: "°C",
            precipitationProbability: "%",
            rain: "mm",
            weatherCode: "wmo code"),
        hourly: Hour(
            time: DateTime.parse("2024-11-25T23:00"),
            temperature2M: -12.6,
            apparentTemperature: -21.7,
            precipitationProbability: 100,
            rain: 0,
            weatherCode: 71)));
