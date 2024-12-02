import 'package:flutter/material.dart';
import 'package:clima_app/models/climate_data.dart';

class ClimateItem extends StatelessWidget {
  final ClimateData climateData;

  const ClimateItem({super.key, required this.climateData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  climateData.date,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Máxima: ${climateData.maxTemp.toStringAsFixed(1)}°C'),
                Text('Mínima: ${climateData.minTemp.toStringAsFixed(1)}°C'),
              ],
            ),
            Icon(
              climateData.weatherIcon,
              size: 40,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
