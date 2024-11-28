class Hour {
  DateTime time;
  double temperature2M;
  double apparentTemperature;
  int precipitationProbability;
  int rain;
  int weatherCode;

  Hour({
    required this.time,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.precipitationProbability,
    required this.rain,
    required this.weatherCode,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        time: DateTime.parse(json["time"]),
        temperature2M: json["temperature_2m"]?.toDouble(),
        apparentTemperature: json["apparent_temperature"]?.toDouble(),
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
