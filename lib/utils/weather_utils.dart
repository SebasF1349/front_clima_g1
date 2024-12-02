import 'package:flutter/material.dart';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/models/hourly_forecast_model.dart';
import 'package:clima_app/models/weather_code.dart';
import 'package:clima_app/utils/weather_code_translation.dart';

class WeatherUtils {
  /// Función para determinar el máximo y el mínimo de temperatura de un día
  static Map<String, double> getDayTemperatureRange(List<double> temperatures) {
    double maxTemp = temperatures[0];
    double minTemp = temperatures[0];

    for (var temp in temperatures) {
      if (temp > maxTemp) {
        maxTemp = temp;
      }
      if (temp < minTemp) {
        minTemp = temp;
      }
    }

    return {'maxTemp': maxTemp, 'minTemp': minTemp};
  }

  static double calculateAverageTemperature(List<double> temperatures) {
  if (temperatures.isEmpty) {
    throw ArgumentError("La lista de temperaturas no puede estar vacía.");
  }

  final sum = temperatures.reduce((a, b) => a + b);
  return sum / temperatures.length;
  }
    static List<double> getHourlyTemperatures(HourlyForecast pronosticoHistorial) {
      return pronosticoHistorial.data.hourly.temperature2M;
    }

    static List<DateTime> getHourlyTimes(HourlyForecast pronosticoHistorial) {
      return pronosticoHistorial.data.hourly.time.map((dateTime) {
        return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour);
      }).toList();
    }


  /// Función para obtener el código de clima predominante
  static int getPredominantWeatherCode(List<int> weatherCodes) {
    final Map<int, int> weatherCodeCount = {};

    for (var code in weatherCodes) {
      if (weatherCodeCount.containsKey(code)) {
        weatherCodeCount[code] = weatherCodeCount[code]! + 1;
      } else {
        weatherCodeCount[code] = 1;
      }
    }

    final List<MapEntry<int, int>> sortedEntries = weatherCodeCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final int predominantCode = sortedEntries.isNotEmpty ? sortedEntries[0].key : -1;

    return predominantCode;
  }

  /// Función para procesar los datos del mock y devolver una lista de ClimateData
  static List<ClimateData> processWeatherData(dynamic pronostico) {
    final List<DateTime> times = pronostico.data.hourly.time;
    final List<double> temperatures = pronostico.data.hourly.temperature2M;
    final List<int> weatherCodesList = pronostico.data.hourly.weatherCode;

    final Map<String, List<double>> dailyTemperatures = {};
    final Map<String, List<int>> dailyWeatherCodes = {};

    for (int i = 0; i < times.length; i++) {
      final String date = times[i].toIso8601String().split('T')[0];
      dailyTemperatures.putIfAbsent(date, () => []).add(temperatures[i]);
      dailyWeatherCodes.putIfAbsent(date, () => []).add(weatherCodesList[i]);
    }

    final List<ClimateData> result = [];
    dailyTemperatures.forEach((date, temps) {
      final maxTemp = getDayTemperatureRange(temps)['maxTemp']!;
      final minTemp = getDayTemperatureRange(temps)['minTemp']!;
      final predominantCode = getPredominantWeatherCode(dailyWeatherCodes[date]!);
      final dailyAverageTemp = calculateAverageTemperature(temperatures);
      final hourlyTemperatures = getHourlyTemperatures(pronostico);
      final hourlyTimes = getHourlyTimes(pronostico);


      // Usamos directamente el mapa weatherCodes para obtener ícono y etiqueta
      final WeatherCode? weatherData = weatherCodes[predominantCode];
      final weatherIcon = weatherData?.icon ?? Icons.help_outline;
      final weatherLabel = weatherData?.label ?? 'Clima desconocido';

      result.add(ClimateData(
        date: date,
        maxTemp: maxTemp,
        minTemp: minTemp,
        avgTemp: dailyAverageTemp,
        weatherIcon: weatherIcon,
        weatherLabel: weatherLabel, 
        hourlyTemperatures: hourlyTemperatures,
        hourlyTimes: hourlyTimes,
      ));
    });

    return result;
  }
}
