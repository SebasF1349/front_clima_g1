class Ciudad {
    String name;
    double latitude;
    double longitude;
    String countryCode;
    String timezone;
    String? country;
    String? admin1;

    Ciudad({

        required this.name,
        required this.latitude,
        required this.longitude,
        required this.countryCode,
        required this.timezone,
        this.country,
        this.admin1,
    });

    factory Ciudad.fromJson(Map<String, dynamic> json) => Ciudad(

        name: json["name"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        countryCode: json["country_code"],
        timezone: json["timezone"],
        country: json["country"],
        admin1: json["admin1"],
    );

    Map<String, dynamic> toJson() => {

        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "country_code": countryCode,
        "timezone": timezone,
        "country": country,
        "admin1": admin1,
    };
}