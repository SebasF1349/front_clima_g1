import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_app/utils/times_utils.dart';
import 'package:clima_app/models/hourly_forecast_model.dart';
import 'package:clima_app/helpers/preferences.dart';

HourlyForecast? activeSearchHourly;
double longitud = 0.0;
double latitud = 0.0;
DateTime? lastDay;
DateTime? lastCheck;

String get ip => dotenv.env['IP_EMULATOR'] ?? '10.0.2.2:3000';

Future<HourlyForecast?> searchHourlyForecast() async {
  double newLongitud = Preferences.longitude;
  double newLatitud = Preferences.latitude;

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);

  bool hasPassedAnHour = TimesUtils.hoursPassed(lastCheck, now, 1);

  if (activeSearchHourly != null &&
      longitud == newLongitud &&
      latitud == newLatitud &&
      today == lastDay &&
      !hasPassedAnHour) {
    return activeSearchHourly;
  }

  final url = Uri.http(ip, '/api/v1/pronostico/horario',
      {'longitud': '$newLongitud', 'latitud': '$newLatitud', 'dias': '1'});
  final response = await http.get(url);

  activeSearchHourly = hourlyForecastFromJson(response.body);
  longitud = newLongitud;
  latitud = newLatitud;
  lastDay = today;
  return activeSearchHourly;
}