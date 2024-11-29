class Daily {
  List<DateTime> time;
  List<int> weatherCode;
  List<double> temperature2MMax;
  List<double> temperature2MMin;
  List<double> apparentTemperatureMax;
  List<double> apparentTemperatureMin;
  List<String> sunrise;
  List<String> sunset;
  List<int> precipitationHours;
  List<int> precipitationProbabilityMax;

  Daily({
    required this.time,
    required this.weatherCode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.apparentTemperatureMax,
    required this.apparentTemperatureMin,
    required this.sunrise,
    required this.sunset,
    required this.precipitationHours,
    required this.precipitationProbabilityMax,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: List<DateTime>.from(json["time"].map((x) => DateTime.parse(x))),
        weatherCode: List<int>.from(json["weather_code"].map((x) => x)),
        temperature2MMax: List<double>.from(
            json["temperature_2m_max"].map((x) => x?.toDouble())),
        temperature2MMin: List<double>.from(
            json["temperature_2m_min"].map((x) => x?.toDouble())),
        apparentTemperatureMax: List<double>.from(
            json["apparent_temperature_max"].map((x) => x?.toDouble())),
        apparentTemperatureMin: List<double>.from(
            json["apparent_temperature_min"].map((x) => x?.toDouble())),
        sunrise: List<String>.from(json["sunrise"].map((x) => x)),
        sunset: List<String>.from(json["sunset"].map((x) => x)),
        precipitationHours:
            List<int>.from(json["precipitation_hours"].map((x) => x)),
        precipitationProbabilityMax:
            List<int>.from(json["precipitation_probability_max"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "weather_code": List<dynamic>.from(weatherCode.map((x) => x)),
        "temperature_2m_max":
            List<dynamic>.from(temperature2MMax.map((x) => x)),
        "temperature_2m_min":
            List<dynamic>.from(temperature2MMin.map((x) => x)),
        "apparent_temperature_max":
            List<dynamic>.from(apparentTemperatureMax.map((x) => x)),
        "apparent_temperature_min":
            List<dynamic>.from(apparentTemperatureMin.map((x) => x)),
        "sunrise": List<dynamic>.from(sunrise.map((x) => x)),
        "sunset": List<dynamic>.from(sunset.map((x) => x)),
        "precipitation_hours":
            List<dynamic>.from(precipitationHours.map((x) => x)),
        "precipitation_probability_max":
            List<dynamic>.from(precipitationProbabilityMax.map((x) => x)),
      };
}
