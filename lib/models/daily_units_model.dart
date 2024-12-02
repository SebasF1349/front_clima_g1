class DailyUnits {
  String time;
  String weatherCode;
  String temperature2MMax;
  String temperature2MMin;
  String apparentTemperatureMax;
  String apparentTemperatureMin;
  String sunrise;
  String sunset;
  String precipitationHours;
  String precipitationProbabilityMax;

  DailyUnits({
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

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json["time"],
        weatherCode: json["weather_code"],
        temperature2MMax: json["temperature_2m_max"],
        temperature2MMin: json["temperature_2m_min"],
        apparentTemperatureMax: json["apparent_temperature_max"],
        apparentTemperatureMin: json["apparent_temperature_min"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        precipitationHours: json["precipitation_hours"],
        precipitationProbabilityMax: json["precipitation_probability_max"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "weather_code": weatherCode,
        "temperature_2m_max": temperature2MMax,
        "temperature_2m_min": temperature2MMin,
        "apparent_temperature_max": apparentTemperatureMax,
        "apparent_temperature_min": apparentTemperatureMin,
        "sunrise": sunrise,
        "sunset": sunset,
        "precipitation_hours": precipitationHours,
        "precipitation_probability_max": precipitationProbabilityMax,
      };
}
