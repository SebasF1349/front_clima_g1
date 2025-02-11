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
DateTime? lastSearchedDate;

String get ip => dotenv.env['IP_EMULATOR'] ?? '10.0.2.2:3000';

Future<ClimateData?> searchClimateDataDayForecast(String date) async {
  double newLongitud = Preferences.longitude;
  double newLatitud = Preferences.latitude;
  DateTime fechaSolicitada = WeatherUtils.parseDateString(date);

  // Si el caché coincide con la misma fecha y ubicación, lo reutilizamos
  if (cachedClimateData != null &&
      longitud == newLongitud &&
      latitud == newLatitud &&
      lastSearchedDate == fechaSolicitada) {
    return cachedClimateData;
  }

  final url = Uri.http(ip, '/api/v1/historial/${fechaSolicitada.day}', {
    'latitud': '$newLatitud',
    'longitud': '$newLongitud',
    'mes': '${fechaSolicitada.month}',
    'anio': '${fechaSolicitada.year}'
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final climateDataDayForecast =
        ClimateDataDayForecast.fromJson(jsonData); // Convierte JSON a modelo

    cachedClimateData =
        WeatherUtils.processWeatherDataForDay(climateDataDayForecast); // Procesa datos
    longitud = newLongitud;
    latitud = newLatitud;
    lastSearchedDate = fechaSolicitada; // Guarda la fecha consultada en caché
    return cachedClimateData;
  } else {
    throw Exception('Error al obtener datos: ${response.statusCode}');
  }
}
