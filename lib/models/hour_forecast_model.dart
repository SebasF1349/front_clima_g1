import 'package:flutter_application_base/models/hour_data_model.dart';

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
