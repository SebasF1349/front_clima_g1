import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/widgets/mensaje_ciudad.dart';

class CiudadSeleccionada extends StatelessWidget {
  CiudadSeleccionada({super.key});

  final ciudadNombre = Preferences.city;
  final countryCode = Preferences.countryCode;
  final provinciaNombre = Preferences.provincia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'buscar_ciudad');
          },
        ),
      ),
      body: Center(
        child: CiudadCardWidget(
          countryCode: countryCode,
          onButton1Pressed: () {
            Navigator.pushNamed(
              context,
              'pronostico',
            );
          },
          onButton2Pressed: () {
            Navigator.pushNamed(
              context,
              'weather_history_list',
            );
          },
        ),
      ),
    );
  }
}
