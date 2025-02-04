import 'dart:typed_data';
import 'package:clima_app/helpers/bandera_foto_future.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';

class CiudadCardWidget extends StatelessWidget {
  final String countryCode;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const CiudadCardWidget({
    super.key,
    required this.countryCode,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
  });

  @override
  Widget build(BuildContext context) {
    final ciudadNombre = Preferences.city;
    final provinciaNombre = Preferences.provincia;
 
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
            FutureBuilder<Uint8List>(
              future: buscarBandera(countryCode.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(strokeWidth: 2.0);
                } else if (snapshot.hasError) {
                  return const Icon(Icons.flag, color: Colors.grey, size: 60);
                } else {
                  return Image.memory(
                    snapshot.data!,
                    width: 100,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              ciudadNombre +', '+ provinciaNombre,
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
                  child: const Text('Pronóstico'),
                ),
                ElevatedButton(
                  onPressed: onButton2Pressed,
                  child: const Text('Historial pronóstico'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
