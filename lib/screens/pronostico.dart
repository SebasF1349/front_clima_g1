import 'package:flutter/material.dart';
import 'package:clima_app/utils/weather_code_translation.dart';
import 'package:clima_app/widgets/drawer_menu.dart';
import 'package:clima_app/widgets/chart.dart';
import 'package:clima_app/mocks/pronostico_horario_mock.dart'
    show pronosticoHorario;
import 'package:clima_app/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;
import 'package:clima_app/widgets/weather_detail.dart';

class Pronostico extends StatelessWidget {
  const Pronostico({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<double> tempHorario =
        tempToDouble(pronosticoHorario.data.hourly.temperature2M);
    List<String> hourLabelsHorario =
        getHourLabels(pronosticoHorario.data.hourly.time);

    List<double> tempDiarioMin =
        tempToDouble(pronosticoDiario.data.daily.temperature2MMin);
    List<double> tempDiarioMax =
        tempToDouble(pronosticoDiario.data.daily.temperature2MMax);
    List<String> hourLabelsDiario =
        getDayLabels(pronosticoDiario.data.daily.time);

    final weather = weatherCodes[pronosticoDiario.data.daily.weatherCode[0]];

    final weatherDetails = [
      {
        'title': 'Máx Temp',
        'icon': Icons.thermostat,
        'value': "${tempDiarioMax[0]}°C",
      },
      {
        'title': 'Mín Temp',
        'icon': Icons.thermostat_outlined,
        'value': "${tempDiarioMin[0]}°C",
      },
      {
        'title': 'Lluvia',
        'icon': Icons.water_drop,
        'value':
            "${pronosticoDiario.data.daily.precipitationProbabilityMax[0]} %",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronóstico'),
      ),
      drawer: DrawerMenu(),
      body: ListView(children: [
        const SizedBox(height: 10),
        WeatherDetailsWidget(
          weatherStateName: weather?.label ?? 'Clima desconocido',
          weatherIcon: weather?.icon ?? Icons.help_outline,
          temperature: tempHorario[6],
          weatherDetails: weatherDetails,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Hoy',
            textScaler: TextScaler.linear(1.3),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          // const SizedBox(width: 20),
          SizedBox(
              width: size.width,
              height: 150,
              child: Chart(
                type: 'horario',
                min: tempHorario,
                labels: hourLabelsHorario,
              ))
        ]),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'Próximos días',
            textScaler: TextScaler.linear(1.3),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          // const SizedBox(width: 20),
          SizedBox(
              width: size.width,
              height: 150,
              child: Chart(
                type: 'diario',
                min: tempDiarioMin,
                max: tempDiarioMax,
                labels: hourLabelsDiario,
              ))
        ]),
      ]),
    );
  }

  List<String> getHourLabels(List<DateTime> dates) {
    return dates.map((date) {
      return '${date.hour.toString().padLeft(2, "0")}hs';
    }).toList();
  }

  List<String> getDayLabels(List<DateTime> dates) {
    return dates.map((date) {
      return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
    }).toList();
  }

  List<double> tempToDouble(List<num> temp) {
    return temp.map((temp) {
      return temp.toDouble();
    }).toList();
  }
}
