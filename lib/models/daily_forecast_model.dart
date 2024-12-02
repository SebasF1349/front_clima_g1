import 'package:clima_app/models/daily_data_model.dart';

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
