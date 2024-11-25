import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;
import 'package:flutter_application_base/utils/weather_code_translation.dart'
    show weatherCodes;

class PronosticoDia extends StatelessWidget {
  const PronosticoDia({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final size = MediaQuery.of(context).size;
    final idx = args['day'];
    final data = pronosticoDiario['data']['daily'];
    final units = pronosticoDiario['data']['daily_units'];

    final temperature =
        '${data['temperature_2m_min'][idx]}${units['temperature_2m_min']}/${data['temperature_2m_max'][idx]}${units['temperature_2m_min']}';
    final apparentTemperature =
        '${data['apparent_temperature_min'][idx]}${units['apparent_temperature_min']}/${data['apparent_temperature_max'][idx]}${units['apparent_temperature_max']}';
    final weatherCode = weatherCodes[data['weather_code'][idx]];

    final sunrise = getTime(data['sunrise'][idx]);
    final sunset = getTime(data['sunset'][idx]);
    final precipitationHours =
        '${data['precipitation_hours'][idx].toString()}hs';
    final precipitationProbabilityMax =
        '${data['precipitation_probability_max'][idx]}%';

    return Scaffold(
      appBar: AppBar(
        title: Text(data['time'][idx]),
        centerTitle: true,
        elevation: 10,
      ),
      body: Card(
        elevation: 1,
        child: Column(children: [
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: Text(temperature),
            subtitle: const Text('Temperatura (min/max)'),
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: Text(apparentTemperature),
            subtitle: const Text('Sensación Térmica (min/max)'),
          ),
          ListTile(
            leading: Icon(weatherCode!['icon']),
            title: Text(weatherCode['label']),
            subtitle: const Text('Clima'),
          ),
          ListTile(
            leading: const Icon(Icons.wb_sunny),
            title: Text(sunrise),
            subtitle: const Text('Amanecer'),
          ),
          ListTile(
            leading: const Icon(Icons.bedtime),
            title: Text(sunset),
            subtitle: const Text('Anochecer'),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop),
            title: Text(precipitationProbabilityMax),
            subtitle: const Text('Probabilidad De Precipitaciones'),
          ),
          ListTile(
            leading: const Icon(Icons.water_drop),
            title: Text(precipitationHours),
            subtitle: const Text('Cantidad de Horas De Precipitaciones'),
          ),
        ]),
      ),
    );
  }

  String getTime(String label) {
    DateTime dateTime = DateTime.parse(label);
    return '${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}hs';
  }
}
