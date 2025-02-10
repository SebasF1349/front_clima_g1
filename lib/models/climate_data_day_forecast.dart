import 'dart:convert';

ClimateDataDayForecast climateDataDayForecastFromJson(String str) => ClimateDataDayForecast.fromJson(json.decode(str));

String climateDataDayForecastToJson(ClimateDataDayForecast data) => json.encode(data.toJson());

class ClimateDataDayForecast {
    String msg;
    Data data;

    ClimateDataDayForecast({
        required this.msg,
        required this.data,
    });

    factory ClimateDataDayForecast.fromJson(Map<String, dynamic> json) => ClimateDataDayForecast(
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data.toJson(),
    };
}

class Data {
    double latitude;
    double longitude;
    double generationtimeMs;
    int utcOffsetSeconds;
    String timezone;
    String timezoneAbbreviation;
    int elevation;
    HourlyUnits hourlyUnits;
    Hourly hourly;

    Data({
        required this.latitude,
        required this.longitude,
        required this.generationtimeMs,
        required this.utcOffsetSeconds,
        required this.timezone,
        required this.timezoneAbbreviation,
        required this.elevation,
        required this.hourlyUnits,
        required this.hourly,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
        generationtimeMs: json["generationtime_ms"]?.toDouble() ?? 0.0,
        utcOffsetSeconds: json["utc_offset_seconds"] ?? 0,
        timezone: json["timezone"] ?? "",
        timezoneAbbreviation: json["timezone_abbreviation"] ?? "",
        elevation: json["elevation"] ?? 0,
        hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
        hourly: Hourly.fromJson(json["hourly"]),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "hourly_units": hourlyUnits.toJson(),
        "hourly": hourly.toJson(),
    };
}

class Hourly {
    List<String> time;
    List<double> temperature2M;
    List<double> apparentTemperature;
    List<dynamic> precipitationProbability;
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
        time: json["time"] != null ? List<String>.from(json["time"].map((x) => x)) : [],
        temperature2M: json["temperature_2m"] != null 
            ? List<double>.from(json["temperature_2m"].map((x) => x?.toDouble() ?? 0.0)) 
            : [],
        apparentTemperature: json["apparent_temperature"] != null 
            ? List<double>.from(json["apparent_temperature"].map((x) => x?.toDouble() ?? 0.0)) 
            : [],
        precipitationProbability: json["precipitation_probability"] != null 
            ? List<dynamic>.from(json["precipitation_probability"].map((x) => x)) 
            : [],
        rain: json["rain"] != null ? List<double>.from(json["rain"].map((x) => x ?? 0.0)) : [],
        weatherCode: json["weather_code"] != null ? List<int>.from(json["weather_code"].map((x) => x ?? 0)) : [],
    );

    Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time.map((x) => x)),
        "temperature_2m": List<dynamic>.from(temperature2M.map((x) => x)),
        "apparent_temperature": List<dynamic>.from(apparentTemperature.map((x) => x)),
        "precipitation_probability": List<dynamic>.from(precipitationProbability.map((x) => x)),
        "rain": List<dynamic>.from(rain.map((x) => x)),
        "weather_code": List<dynamic>.from(weatherCode.map((x) => x)),
    };
}

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
        time: json["time"] ?? "",
        temperature2M: json["temperature_2m"] ?? "",
        apparentTemperature: json["apparent_temperature"] ?? "",
        precipitationProbability: json["precipitation_probability"] ?? "",
        rain: json["rain"] ?? "",
        weatherCode: json["weather_code"] ?? "",
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
