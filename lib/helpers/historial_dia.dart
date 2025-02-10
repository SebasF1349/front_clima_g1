import 'dart:convert';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/models/climate_data_day_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/utils/weather_utils.dart';

ClimateData? cachedClimateData;
double longitud = 0.0;
double latitud = 0.0;
DateTime? lastDay;

String get ip => dotenv.env['IP_CHROME'] ?? '127.0.0.1:3000';

Future<ClimateData?> searchClimateDataDayForecast(String date) async {
  double newLongitud = Preferences.longitude;
  double newLatitud = Preferences.latitude;
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime fecha = WeatherUtils.parseDateString(date);
  int day = fecha.day;
  int month = fecha.month;
  int year = fecha.year;

  // Usamos caché si ya se hizo la búsqueda hoy y en la misma ubicación
  if (cachedClimateData != null &&
      longitud == newLongitud &&
      latitud == newLatitud &&
      today == lastDay) {
    return cachedClimateData;
  }

  final url = Uri.http(ip, '/api/v1/historial/$day', {
    'latitud': '$newLatitud', 
    'longitud': '$newLongitud',
    'mes': '$month',
    'anio': '$year'
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final climateDataDayForecast = ClimateDataDayForecast.fromJson(jsonData); // Convierte JSON a modelo

    cachedClimateData = WeatherUtils.processWeatherDataForDay(climateDataDayForecast); // Procesa datos
    longitud = newLongitud;
    latitud = newLatitud;
    lastDay = today;
    return cachedClimateData;
  } else {
    throw Exception('Error al obtener datos: ${response.statusCode}');
  }
}
