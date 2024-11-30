import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/climate_data.dart';
import 'package:flutter_application_base/widgets/weather_detail.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final ClimateData data;

  const WeatherDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos adicionales para WeatherDetailsWidget
    final weatherDetails = [
      {
        'title': 'Máx Temp',
        'icon': Icons.thermostat,
        'value': "${data.maxTemp}°C",
      },
      {
        'title': 'Mín Temp',
        'icon': Icons.thermostat_outlined,
        'value': "${data.minTemp}°C",
      },
      {
        'title': 'Viento',
        'icon': Icons.air,
        'value': "${data.windSpeed ?? 'N/A'} km/h", // Ejemplo de viento
      },
      {
        'title': 'Lluvia',
        'icon': Icons.water_drop,
        'value': "${data.rain ?? '0'} mm",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Clima - ${data.date}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: WeatherDetailsWidget(
            weatherStateName: data.weatherLabel,
            weatherIcon: data.weatherIcon,
            temperature: data.avgTemp, // Promedio o temperatura principal
            weatherDetails: weatherDetails,
          ),
        ),
      ),
    );
  }
}
