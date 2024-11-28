/* import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/climate_card.dart';
import 'package:flutter_application_base/mocks/pronostico_horario_mock.dart';
import 'package:flutter_application_base/utils/weather_code_translation.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = pronosticoHorario['data']['hourly'];
    final int weatherCode = weatherData['weather_code'];
    final double temperature = weatherData['temperature_2m'];

    final String weatherStateName = weatherCodes[weatherCode]?['label'] ?? 'Unknown';
    final IconData weatherIcon = weatherCodes[weatherCode]?['icon'] ?? Icons.help;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Screen'),
      ),
      body: Center(
        child: ClimateCard(
          weatherStateName: weatherStateName,
          weatherIcon: weatherIcon,
          temperature: temperature,
        ),
      ),
    );
  }
}
 */
/* 
import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/pronostico_mock.dart';
import 'package:flutter_application_base/widgets/climate_item.dart';
import 'package:flutter_application_base/utils/weather_utils.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí simulas obtener los datos del mock.
    final climateList = WeatherUtils.processWeatherData(pronostico);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pronóstico del Clima"),
      ),
      body: ListView.builder(
        itemCount: climateList.length,
        itemBuilder: (context, index) {
          final climateData = climateList[index];
          return ClimateItem(climateData: climateData); // Pasas el objeto completo
        },
      ),
    );
  }
} */

/* import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/rain_info.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WeatherInfoWidget(
              title: 'Wind Speed',
              icon: Icons.air,
              value: '7 km/h',
            ),
            WeatherInfoWidget(
              title: 'Humidity',
              icon: Icons.water_drop,
              value: '50%',
            ),
            WeatherInfoWidget(
              title: 'Temp',
              icon: Icons.thermostat,
              value: '20°C',
            ),
          ],
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/weather_detail.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather App')),
        body: const WeatherDetailsWidget(
          weatherStateName: 'Sunny',
          weatherIcon: Icons.wb_sunny,
          temperature: 28.0,
          weatherDetails: [
            {'title': 'Humidity', 'icon': Icons.water_drop, 'value': '40%'},
            {'title': 'Pressure', 'icon': Icons.speed, 'value': '1012 hPa'},
          ],
        ),
      ),
    );
  }
}