import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/widgets/mensaje_ciudad.dart';

class CiudadSeleccionada extends StatelessWidget {
  const CiudadSeleccionada({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final ciudadNombre = Preferences.city;
    final countryCode = arguments['country_code'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ciudad: $ciudadNombre'),
      ),
      body: Center(
        child: CiudadCardWidget(
          ciudadNombre: ciudadNombre,
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
