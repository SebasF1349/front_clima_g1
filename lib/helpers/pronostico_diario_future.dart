import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_app/utils/times_utils.dart';
import 'package:clima_app/models/daily_forecast_model.dart';
import 'package:clima_app/helpers/preferences.dart';

DailyForecast? activeSearchDaily;
double longitud = 0.0;
double latitud = 0.0;
DateTime? lastDay;
DateTime? lastCheck;

String get ip => dotenv.env['IP_EMULATOR'] ?? '10.0.2.2:3000';

Future<DailyForecast?> searchDailyForecast() async {
  double newLongitud = Preferences.longitude;
  double newLatitud = Preferences.latitude;

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);

  bool hasPassedAnHour = TimesUtils.hoursPassed(lastCheck, now, 1);

  if (activeSearchDaily != null &&
      longitud == newLongitud &&
      latitud == newLatitud &&
      today == lastDay &&
      !hasPassedAnHour) {
    return activeSearchDaily;
  }

  final url = Uri.http(ip, '/api/v1/pronostico/diario',
      {'longitud': '$newLongitud', 'latitud': '$newLatitud', 'dias': '16'});
  final response = await http.get(url);

  activeSearchDaily = dailyForecastFromJson(response.body);
  longitud = newLongitud;
  latitud = newLatitud;
  lastDay = today;
  lastCheck = now;
  return activeSearchDaily;
}
