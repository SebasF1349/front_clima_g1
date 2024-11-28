import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/climate_data.dart';
import 'package:flutter_application_base/models/weather_code.dart';
import 'package:flutter_application_base/utils/weather_code_translation.dart'; // Importamos el mapa de códigos de clima

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
  static List<ClimateData> processWeatherData(Map<String, dynamic> pronostico) {
    final List<String> times = pronostico['data']['hourly']['time'].cast<String>();
    final List<double> temperatures =
        pronostico['data']['hourly']['temperature_2m'].cast<double>();
    final List<int> weatherCodesList =
        pronostico['data']['hourly']['weather_code'].cast<int>();

    final Map<String, List<double>> dailyTemperatures = {};
    final Map<String, List<int>> dailyWeatherCodes = {};

    for (int i = 0; i < times.length; i++) {
      final String date = times[i].split('T')[0];
      dailyTemperatures.putIfAbsent(date, () => []).add(temperatures[i]);
      dailyWeatherCodes.putIfAbsent(date, () => []).add(weatherCodesList[i]);
    }

    final List<ClimateData> result = [];
    dailyTemperatures.forEach((date, temps) {
      final maxTemp = getDayTemperatureRange(temps)['maxTemp']!;
      final minTemp = getDayTemperatureRange(temps)['minTemp']!;
      final predominantCode = getPredominantWeatherCode(dailyWeatherCodes[date]!);

      // Usamos directamente el mapa `weatherCodes` para obtener ícono y etiqueta
      final WeatherCode? weatherData = weatherCodes[predominantCode]; // Asegúrate de que weatherCodes sea Map<int, WeatherCode>
      final weatherIcon = weatherData?.icon ?? Icons.help_outline;
      final weatherLabel = weatherData?.label ?? 'Clima desconocido';

      result.add(ClimateData(
        date: date,
        maxTemp: maxTemp,
        minTemp: minTemp,
        weatherIcon: weatherIcon,
        weatherLabel: weatherLabel,
      ));
    });

    return result;
  }
}
