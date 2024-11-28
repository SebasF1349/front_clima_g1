import 'package:flutter/material.dart';
import 'climate_card.dart'; // Archivo separado
import 'rain_info.dart'; // Archivo separado

class WeatherDetailsWidget extends StatelessWidget {
  final String weatherStateName;
  final IconData weatherIcon;
  final double temperature;
  final List<Map<String, dynamic>> weatherDetails;

  const WeatherDetailsWidget({
    super.key,
    required this.weatherStateName,
    required this.weatherIcon,
    required this.temperature,
    required this.weatherDetails, // Lista de detalles del clima
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Widget ClimateCard
        ClimateCard(
          weatherStateName: weatherStateName,
          weatherIcon: weatherIcon,
          temperature: temperature,
        ),
        const SizedBox(height: 16),
        // Información adicional del clima
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weatherDetails.map((detail) {
              return WeatherInfoWidget(
                title: detail['title'],
                icon: detail['icon'],
                value: detail['value'],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
