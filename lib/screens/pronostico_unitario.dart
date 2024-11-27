import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;
import 'package:flutter_application_base/mocks/pronostico_horario_mock.dart'
    show pronosticoHorario;
import 'package:flutter_application_base/models/clima_card_data.dart';
import 'package:flutter_application_base/utils/weather_code_translation.dart'
    show weatherCodes;
import 'package:flutter_application_base/widgets/clima_card.dart';

class PronosticoDia extends StatelessWidget {
  const PronosticoDia({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final size = MediaQuery.of(context).size;
    final data = getData(args);
    final next = getNext(args);
    final prev = getPrev(args);

    final List<Widget> buttons = [];
    // NOTE: Deberian hacer wrap los botones?
    if (prev != '') {
      buttons.add(Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'pronostico_unitario',
                ModalRoute.withName('pronostico'),
                arguments: <String, dynamic>{
                  'dataType': args['dataType'],
                  'time': prev,
                });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll<Color>(Colors.green),
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ));
    }
    if (next != '') {
      buttons.add(Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'pronostico_unitario',
                ModalRoute.withName('pronostico'),
                arguments: <String, dynamic>{
                  'dataType': args['dataType'],
                  'time': next,
                });
            // Navigator.popAndPushNamed(context, 'pronostico_unitario',
            //     arguments: <String, dynamic>{
            //       'dataType': args['dataType'],
            //       'time': next,
            //     });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(Colors.green),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(args['time']),
          centerTitle: true,
          elevation: 10,
        ),
        body: Column(
          children: [
            ClimaCard(data: data),
            Row(children: buttons),
          ],
        ));
  }

  String getTime(String label) {
    DateTime dateTime = DateTime.parse(label);
    return '${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}hs';
  }

  List<ClimaCardData> getData(Map<String, dynamic> args) {
    List<ClimaCardData> returnData = [];
    if (args['dataType'] == 'diario') {
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
        ClimaCardData(
            title: temperature,
            leading: Icons.thermostat,
            subtitle: 'Temperatura (min/max)'),
        ClimaCardData(
            title: apparentTemperature,
            leading: Icons.thermostat,
            subtitle: 'Sensación Térmica (min/max)'),
        ClimaCardData(
            title: weatherCode!['label'],
            leading: weatherCode['icon'],
            subtitle: 'Clima'),
        ClimaCardData(
            title: sunrise, leading: Icons.wb_sunny, subtitle: 'Amanecer'),
        ClimaCardData(
            title: sunset, leading: Icons.bedtime, subtitle: 'Anochecer'),
        ClimaCardData(
            title: precipitationProbabilityMax,
            leading: Icons.water_drop,
            subtitle: 'Probabilidad De Precipitaciones'),
        ClimaCardData(
            title: precipitationHours,
            leading: Icons.water_drop,
            subtitle: 'Cantidad de Horas De Precipitaciones'),
      ]);
    } else if (args['dataType'] == 'horario') {
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
        ClimaCardData(
            title: temperature,
            leading: Icons.thermostat,
            subtitle: 'Temperatura'),
        ClimaCardData(
            title: apparentTemperature,
            leading: Icons.thermostat,
            subtitle: 'Sensación Térmica'),
        ClimaCardData(
            title: weatherCode!['label'],
            leading: weatherCode['icon'],
            subtitle: 'Clima'),
        ClimaCardData(
            title: precipitationProbability,
            leading: Icons.water_drop,
            subtitle: 'Probabilidad De Precipitaciones'),
        ClimaCardData(
            title: rain,
            leading: Icons.water_drop,
            subtitle: 'Lluvia Última Hora'),
      ]);
    }
    return returnData;
  }

  String getNext(Map<String, dynamic> args) {
    if (args['dataType'] == 'diario') {
      final String dateLabel = args['time'];
      final [day, month] = dateLabel.split('/');
      final DateTime now = DateTime.now();
      final data = pronosticoDiario['data']['daily'];
      final int idx = data['time']!
          .indexWhere((t) => t == '${now.year.toString()}-$month-$day');
      if (idx == -1 || idx + 1 == data['time']!.length) return '';
      String dateStr = (idx + 1 == data['time']!.length)
          ? data['time'][0]
          : data['time'][idx + 1];
      DateTime date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
    } else if (args['dataType'] == 'horario') {
      final String timeLabel = args['time'];
      final time = int.parse(timeLabel.substring(0, 2));
      if (time == 23) return ''; // '00hs';
      return '${(time + 1).toString().padLeft(2, "0")}hs';
    }
    return '';
  }

  String getPrev(Map<String, dynamic> args) {
    if (args['dataType'] == 'diario') {
      final String dateLabel = args['time'];
      final [day, month] = dateLabel.split('/');
      DateTime now = DateTime.now();
      final data = pronosticoDiario['data']['daily'];
      final int idx = data['time']
          .indexWhere((t) => t == '${now.year.toString()}-$month-$day');
      if (idx == -1 || idx == 0) return '';
      String dateStr = (idx == 0) ? data['time'].last : data['time'][idx - 1];
      DateTime date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
    } else if (args['dataType'] == 'horario') {
      final String timeLabel = args['time'];
      final int time = int.parse(timeLabel.substring(0, 2));
      if (time == 0) return ''; //'23hs';
      return '${(time - 1).toString().padLeft(2, "0")}hs';
    }
    return '';
  }
}
