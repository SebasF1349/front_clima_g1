import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/mensaje_ciudad.dart';

class CiudadSeleccionada extends StatelessWidget {
  const CiudadSeleccionada({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final ciudadNombre = arguments['name'] as String;
    final countryCode = arguments['country_code'] as String;
    final latitud = arguments['latitude'] as double;
    final longitud = arguments['longitude'] as double;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ciudad: $ciudadNombre'),
      ),
      body: Center(
        child: CiudadCardWidget(
          ciudadNombre: ciudadNombre,
          countryCode: countryCode,
          latitud: latitud,
          longitud: longitud,
          onButton1Pressed: () {
            // Lógica del botón 1
            Navigator.pushNamed(
              context,
              '/clima_hoy_futuro',
              arguments: {'latitud': latitud, 'longitud': longitud},
            );
          },
          onButton2Pressed: () {
            // Lógica del botón 2
            Navigator.pushNamed(
              context,
              '/clima_pasado',
              arguments: {'latitud': latitud, 'longitud': longitud},
            );
          },
        ),
      ),
    );
  }
}
