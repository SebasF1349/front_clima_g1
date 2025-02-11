import 'package:clima_app/models/climate_data_day_forecast.dart';
import 'package:clima_app/models/climate_data_forecast.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/models/weather_code.dart';
import 'package:clima_app/utils/weather_code_translation.dart';

class WeatherUtils {
  /// Función para determinar el máximo y el mínimo de temperatura de un día
  static Map<String, double> getDayTemperatureRange(List<double> temperatures) {
    final maxTemp = temperatures.reduce((a, b) => a > b ? a : b);
    final minTemp = temperatures.reduce((a, b) => a < b ? a : b);
    return {'maxTemp': maxTemp, 'minTemp': minTemp};
  }

  static double calculateAverageTemperature(List<double> temperatures) {
    if (temperatures.isEmpty) {
      throw ArgumentError("La lista de temperaturas no puede estar vacía.");
    }

    final sum = temperatures.reduce((a, b) => a + b);
    return sum / temperatures.length;
  }

  static List<double> getHourlyTemperatures(
      ClimateDataForecast pronosticoHistorial) {
    return pronosticoHistorial.data.hourly.temperature2M;
  }

  static List<DateTime> getHourlyTimes(
      ClimateDataForecast pronosticoHistorial) {
    return pronosticoHistorial.data.hourly.time.map((dateTime) {
      return DateTime(
          dateTime.year, dateTime.month, dateTime.day, dateTime.hour);
    }).toList();
  }

  static DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split('-');
    if (parts.length == 3) {
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      throw FormatException('El formato de la fecha es incorrecto');
    }
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

    final List<MapEntry<int, int>> sortedEntries = weatherCodeCount.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.isNotEmpty ? sortedEntries[0].key : -1;
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
      final predominantCode =
          getPredominantWeatherCode(dailyWeatherCodes[date]!);
      final dailyAverageTemp =
          calculateAverageTemperature(temps); // Corregido aquí
      final hourlyTemperatures = getHourlyTemperatures(pronostico);
      final hourlyTimes = getHourlyTimes(pronostico);

      // Usamos el mapa correcto para obtener íconos y etiquetas
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

  static ClimateData processWeatherDataForDay(ClimateDataDayForecast forecast) {
    var firstHourlyData = forecast.data.hourly;

    // Obtener la temperatura máxima, mínima y promedio
    double maxTemp =
        firstHourlyData.temperature2M.reduce((a, b) => a > b ? a : b);
    double minTemp =
        firstHourlyData.temperature2M.reduce((a, b) => a < b ? a : b);
    double avgTemp = firstHourlyData.temperature2M.reduce((a, b) => a + b) /
        firstHourlyData.temperature2M.length;

    // Obtener el icono y la etiqueta del clima usando el weatherCode
    final List<int> weatherCodesListDay = forecast.data.hourly.weatherCode;
    final weatherIconPredominate =
        getPredominantWeatherCode(weatherCodesListDay);
    final WeatherCode? weatherDataa = weatherCodes[weatherIconPredominate];
    final weatherIcon = weatherDataa?.icon ?? Icons.help_outline;
    String weatherLabel = weatherDataa?.label ?? 'Clima desconocido';

    // Convertir las horas y temperaturas en formato adecuado
    List<DateTime> hourlyTimes =
        firstHourlyData.time.map((time) => DateTime.parse(time)).toList();
    List<double> hourlyTemperatures = firstHourlyData.temperature2M;

    double?
        windSpeed; // Aquí puedes agregar datos del viento si están disponibles.
    double? rain = firstHourlyData.rain.isNotEmpty
        ? firstHourlyData.rain[0].toDouble()
        : null;

    return ClimateData(
      date: DateTime.now().toIso8601String(),
      maxTemp: maxTemp,
      minTemp: minTemp,
      avgTemp: avgTemp,
      weatherIcon: weatherIcon,
      weatherLabel: weatherLabel,
      windSpeed: windSpeed,
      rain: rain,
      hourlyTemperatures: hourlyTemperatures,
      hourlyTimes: hourlyTimes,
    );
  }
}
