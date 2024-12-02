import 'package:clima_app/models/hourly_model.dart';
import 'package:clima_app/models/hourly_data_model.dart';
import 'package:clima_app/models/hourly_forecast_model.dart';
import 'package:clima_app/models/hourly_units_model.dart';

HourlyForecast pronosticoHorario = HourlyForecast(
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
            weatherCode: "wmo code"),
        hourly: Hourly(time: [
          DateTime.parse("2024-11-23T00:00"),
          DateTime.parse("2024-11-23T01:00"),
          DateTime.parse("2024-11-23T02:00"),
          DateTime.parse("2024-11-23T03:00"),
          DateTime.parse("2024-11-23T04:00"),
          DateTime.parse("2024-11-23T05:00"),
          DateTime.parse("2024-11-23T06:00"),
          DateTime.parse("2024-11-23T07:00"),
          DateTime.parse("2024-11-23T08:00"),
          DateTime.parse("2024-11-23T09:00"),
          DateTime.parse("2024-11-23T10:00"),
          DateTime.parse("2024-11-23T11:00"),
          DateTime.parse("2024-11-23T12:00"),
          DateTime.parse("2024-11-23T13:00"),
          DateTime.parse("2024-11-23T14:00"),
          DateTime.parse("2024-11-23T15:00"),
          DateTime.parse("2024-11-23T16:00"),
          DateTime.parse("2024-11-23T17:00"),
          DateTime.parse("2024-11-23T18:00"),
          DateTime.parse("2024-11-23T19:00"),
          DateTime.parse("2024-11-23T20:00"),
          DateTime.parse("2024-11-23T21:00"),
          DateTime.parse("2024-11-23T22:00"),
          DateTime.parse("2024-11-23T23:00")
        ], temperature2M: [
          -2.9,
          -3.2,
          -3.2,
          -2.3,
          -2.2,
          -2,
          -2.2,
          -2.3,
          -2.4,
          -2.8,
          -2.5,
          -2.5,
          -2.3,
          -2.3,
          -2.2,
          -2.2,
          -2.2,
          -2.2,
          -2.2,
          -2.2,
          -2.8,
          -3.5,
          -4.2,
          -5.1
        ], apparentTemperature: [
          -8.6,
          -8.8,
          -9,
          -7.9,
          -7.8,
          -7.6,
          -7.8,
          -7.8,
          -7.8,
          -8,
          -7.7,
          -7.7,
          -7.6,
          -7.8,
          -7.9,
          -8,
          -8.1,
          -8.1,
          -8,
          -8.2,
          -10.3,
          -13.1,
          -14.9,
          -15.9
        ], precipitationProbability: [
          18,
          23,
          23,
          30,
          30,
          38,
          38,
          45,
          45,
          40,
          38,
          45,
          43,
          48,
          53,
          65,
          83,
          88,
          85,
          85,
          80,
          83,
          83,
          78
        ], rain: [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ], weatherCode: [
          2,
          2,
          2,
          2,
          85,
          85,
          85,
          85,
          85,
          85,
          3,
          3,
          3,
          3,
          3,
          3,
          3,
          3,
          85,
          85,
          85,
          86,
          85,
          71
        ])));
