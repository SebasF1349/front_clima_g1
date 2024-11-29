import 'package:flutter/material.dart';

class CiudadCardWidget extends StatelessWidget {
  final String ciudadNombre;
  final String countryCode;
  final double latitud;
  final double longitud;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const CiudadCardWidget({
    super.key,
    required this.ciudadNombre,
    required this.countryCode,
    required this.latitud,
    required this.longitud,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/banderas/$countryCode.png',
              width: 100,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.flag, color: Colors.grey, size: 60);
              },
            ),
            const SizedBox(height: 16),

            Text(
              '$ciudadNombre',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onButton1Pressed,
                  child: const Text('Clima HOY - FUTURO'),
                ),
                ElevatedButton(
                  onPressed: onButton2Pressed,
                  child: const Text('Clima PASADO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

