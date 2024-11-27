import 'package:flutter/material.dart';
import 'package:flutter_application_base/utils/weather_emoji_translation.dart';

class WeatherWidget extends StatelessWidget {
  final String condition; // Condición climática dinámica
  final int temperature;
  final int feelsLike;
  final double rainProbability;
  final double precipitation;

  const WeatherWidget({
    super.key,
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.rainProbability,
    required this.precipitation,
  });

  @override
  Widget build(BuildContext context) {
    final weatherEmoji = getWeatherEmoji(condition); // Obtenemos el emoji dinámico

    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                weatherEmoji,
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "temp/st",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$temperature°/$feelsLike°",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Prob. lluvia: ${rainProbability.toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                "Precipitación: ${precipitation.toStringAsFixed(1)}mm",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
