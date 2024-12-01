import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/climate_data.dart';
import 'package:flutter_application_base/widgets/weather_detail.dart';
import 'package:flutter_application_base/widgets/chart.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final ClimateData data;

  const WeatherDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Datos adicionales para WeatherDetailsWidget
    final weatherDetails = [
      {
        'title': 'Máx Temp',
        'icon': Icons.thermostat,
        'value': "${data.maxTemp.toStringAsFixed(1)}°C",
      },
      {
        'title': 'Mín Temp',
        'icon': Icons.thermostat_outlined,
        'value': "${data.minTemp.toStringAsFixed(1)}°C",
      },
      {
        'title': 'Viento',
        'icon': Icons.air,
        'value': "${data.windSpeed ?? 'N/A'} km/h", 
      },
      {
        'title': 'Lluvia',
        'icon': Icons.water_drop,
        'value': "${data.rain ?? '0'} mm",
      },
    ];

    // Limitar a las primeras 24 horas
    final limitedHourlyTemps = data.hourlyTemperatures.take(24).toList();
    final limitedHourlyTimes = data.hourlyTimes.take(24).toList();

    // Formatear las etiquetas de horas
    List<String> hourLabels = limitedHourlyTimes.map((date) {
      return '${date.hour.toString().padLeft(2, "0")}hs';
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Clima - ${data.date}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              WeatherDetailsWidget(
                weatherStateName: data.weatherLabel,
                weatherIcon: data.weatherIcon,
                temperature: data.avgTemp, 
                weatherDetails: weatherDetails,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: size.width - 32,
                    height: 150,
                    child: Chart(
                      type: 'horario',
                      min: limitedHourlyTemps,
                      labels: hourLabels,
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}