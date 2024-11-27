import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/weather_info.dart';  // Asegúrate de importar el widget que ya creaste

class WeatherTestScreen extends StatelessWidget {
  const WeatherTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos ficticios para probar el widget
    const String condition = 'Clear';  // Puedes cambiar la condición para probar diferentes emojis
    const int temperature = 23;
    const int feelsLike = 22;
    const double rainProbability = 10.5;
    const double precipitation = 2.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Widget Test'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: WeatherWidget(
            condition: condition,
            temperature: temperature,
            feelsLike: feelsLike,
            rainProbability: rainProbability,
            precipitation: precipitation,
          ),
        ),
      ),
    );
  }
}

