class Hourly {
  List<DateTime> time;
  List<double> temperature2M;
  List<double> apparentTemperature;
  List<int> precipitationProbability;
  List<double> rain;
  List<int> weatherCode;

  Hourly({
    required this.time,
    required this.temperature2M,
    required this.apparentTemperature,
    required this.precipitationProbability,
    required this.rain,
    required this.weatherCode,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        // time: List<String>.from(json["time"].map((x) => x)),
        time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        temperature2M:
            List<double>.from(json["temperature_2m"].map((x) => x?.toDouble())),
        apparentTemperature: List<double>.from(
            json["apparent_temperature"].map((x) => x?.toDouble())),
        precipitationProbability:
            List<int>.from(json["precipitation_probability"].map((x) => x)),
        rain: List<double>.from(json["rain"].map((x) => x?.toDouble())),
        weatherCode: List<int>.from(json["weather_code"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
        "apparent_temperature":
            List<dynamic>.from(apparentTemperature.map((x) => x)),
        "precipitation_probability":
            List<dynamic>.from(precipitationProbability.map((x) => x)),
        "rain": List<dynamic>.from(rain.map((x) => x)),
        "weather_code": List<dynamic>.from(weatherCode.map((x) => x)),
      };
}
