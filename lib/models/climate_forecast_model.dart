import 'package:clima_app/models/daily_data_model.dart';
import 'dart:convert';

ClimateData climateForecastFromJson(String str) =>
    ClimateData.fromJson(json.decode(str));

String hourlyForecastToJson(ClimateData data) => json.encode(data.toJson());

class ClimateData {
  String msg;
  DailyData data;

  ClimateData({
    required this.msg,
    required this.data,
  });

  factory ClimateData.fromJson(Map<String, dynamic> json) => ClimateData(
        msg: json["msg"],
        data: DailyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
      };
}
