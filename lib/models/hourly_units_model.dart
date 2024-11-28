class HourlyUnits {
  String time;
  String temperature2M;
  String apparentTemperature;
  String precipitationProbability;
  String rain;
  String weatherCode;

  HourlyUnits({
    required this.time,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.precipitationProbability,
    required this.rain,
    required this.weatherCode,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
        time: json["time"],
        temperature2M: json["temperature_2m"],
        apparentTemperature: json["apparent_temperature"],
        precipitationProbability: json["precipitation_probability"],
        rain: json["rain"],
        weatherCode: json["weather_code"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m": temperature2M,
        "apparent_temperature": apparentTemperature,
        "precipitation_probability": precipitationProbability,
        "rain": rain,
        "weather_code": weatherCode,
      };
}
