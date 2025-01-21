import 'package:clima_app/models/daily_data_model.dart';
import 'dart:convert';

DailyForecast dailyForecastFromJson(String str) =>
    DailyForecast.fromJson(json.decode(str));

String hourlyForecastToJson(DailyForecast data) => json.encode(data.toJson());

class DailyForecast {
  String msg;
  DailyData data;

  DailyForecast({
    required this.msg,
    required this.data,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) => DailyForecast(
        msg: json["msg"],
        data: DailyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}
