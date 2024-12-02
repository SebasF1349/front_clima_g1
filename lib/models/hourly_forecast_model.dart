import 'package:clima_app/models/hourly_data_model.dart';
import 'dart:convert';

HourlyForecast hourlyForecastFromJson(String str) =>
    HourlyForecast.fromJson(json.decode(str));

String hourlyForecastToJson(HourlyForecast data) => json.encode(data.toJson());

class HourlyForecast {
  String msg;
  HourlyData data;

  HourlyForecast({
    required this.msg,
    required this.data,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) => HourlyForecast(
        msg: json["msg"],
        data: HourlyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}
