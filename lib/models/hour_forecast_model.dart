import 'package:clima_app/models/hour_data_model.dart';
import 'dart:convert';

HourForecast hourForecastFromJson(String str) =>
    HourForecast.fromJson(json.decode(str));

String hourForecastToJson(HourForecast data) => json.encode(data.toJson());

class HourForecast {
  String msg;
  HourData data;

  HourForecast({
    required this.msg,
    required this.data,
  });

  factory HourForecast.fromJson(Map<String, dynamic> json) => HourForecast(
        msg: json["msg"],
        data: HourData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}
