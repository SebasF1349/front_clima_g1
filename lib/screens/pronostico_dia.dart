import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;
import 'package:flutter_application_base/mocks/pronostico_horario_mock.dart'
    show pronosticoHorario;
import 'package:flutter_application_base/utils/weather_code_translation.dart'
    show weatherCodes;

class PronosticoDia extends StatelessWidget {
  const PronosticoDia({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final size = MediaQuery.of(context).size;
    final data = getData(args);

    return Scaffold(
        appBar: AppBar(
          title: Text(args['time']),
          centerTitle: true,
          elevation: 10,
        ),
        body: Card(
          elevation: 1,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(data[index]['leading']),
                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['subtitle']),
                );
              }),
        ));
  }

  String getTime(String label) {
    DateTime dateTime = DateTime.parse(label);
    return '${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}hs';
  }

  List<Map<String, dynamic>> getData(Map<String, dynamic> args) {
    List<Map<String, dynamic>> returnData = [];
    if (args['chartType'] == 'diario') {
      final dateLabel = args['time'];
      final [day, month] = dateLabel.split('/');
      DateTime now = DateTime.now();
      final data = pronosticoDiario['data']['daily'];
      final idx = data['time']
          .indexWhere((t) => t == '${now.year.toString()}-$month-$day');
      if (idx == -1) return data;

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

      returnData.addAll([
        {
          'title': temperature,
          'leading': Icons.thermostat,
          'subtitle': 'Temperatura (min/max)'
        },
        {
          'title': apparentTemperature,
          'leading': Icons.thermostat,
          'subtitle': 'Sensación Térmica (min/max)'
        },
        {
          'title': weatherCode!['label'],
          'leading': weatherCode['icon'],
          'subtitle': 'Clima'
        },
        {'title': sunrise, 'leading': Icons.wb_sunny, 'subtitle': 'Amanecer'},
        {'title': sunset, 'leading': Icons.bedtime, 'subtitle': 'Anochecer'},
        {
          'title': precipitationProbabilityMax,
          'leading': Icons.water_drop,
          'subtitle': 'Probabilidad De Precipitaciones'
        },
        {
          'title': precipitationHours,
          'leading': Icons.water_drop,
          'subtitle': 'Cantidad de Horas De Precipitaciones'
        },
      ]);
    } else if (args['chartType'] == 'horario') {
      final data = pronosticoHorario['data']['hourly'];
      final units = pronosticoHorario['data']['hourly_units'];

      final temperature = '${data['temperature_2m']}${units['temperature_2m']}';
      final apparentTemperature =
          '${data['apparent_temperature']}${units['apparent_temperature']}';
      final weatherCode = weatherCodes[data['weather_code']];
      final precipitationProbability =
          '${data['precipitation_probability']}${units['precipitation_probability']}';
      final rain = '${data['rain'].toString()}${units['rain']}';

      returnData.addAll([
        {
          'title': temperature,
          'leading': Icons.thermostat,
          'subtitle': 'Temperatura'
        },
        {
          'title': apparentTemperature,
          'leading': Icons.thermostat,
          'subtitle': 'Sensación Térmica'
        },
        {
          'title': weatherCode!['label'],
          'leading': weatherCode['icon'],
          'subtitle': 'Clima'
        },
        {
          'title': precipitationProbability,
          'leading': Icons.water_drop,
          'subtitle': 'Probabilidad De Precipitaciones'
        },
        {
          'title': rain,
          'leading': Icons.water_drop,
          'subtitle': 'Lluvia Última Hora'
        },
      ]);
    }
    return returnData;
  }
}
