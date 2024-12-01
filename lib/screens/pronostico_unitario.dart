import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;
import 'package:flutter_application_base/mocks/pronostico_hora_mock.dart'
    show pronosticoHora;
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

    final data = getData(args);
    final next = getNext(args);
    final prev = getPrev(args);

    final List<Widget> buttons = [];
    // NOTE: Deberian hacer wrap los botones?
    if (prev != '') {
      buttons.add(Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 50)),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'pronostico_unitario',
                ModalRoute.withName('pronostico'),
                arguments: <String, dynamic>{
                  'dataType': args['dataType'],
                  'time': prev,
                });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ));
    }
    if (next != '') {
      buttons.add(Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(100, 50)),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'pronostico_unitario',
                ModalRoute.withName('pronostico'),
                arguments: <String, dynamic>{
                  'dataType': args['dataType'],
                  'time': next,
                });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(args['time']),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: ClimaCard(data: data),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(children: buttons),
            ),
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
      final data = pronosticoDiario.data.daily;
      final idx = data.time.indexWhere((t) =>
          t.year == now.year &&
          t.month.toString().padLeft(2, "0") == month &&
          t.day.toString().padLeft(2, "0") == day);
      if (idx == -1) return returnData;

      final units = pronosticoDiario.data.dailyUnits;
      final temperature =
          '${data.temperature2MMin[idx]}${units.temperature2MMin}/${data.temperature2MMax[idx]}${units.temperature2MMin}';
      final apparentTemperature =
          '${data.apparentTemperatureMin[idx]}${units.apparentTemperatureMin}/${data.apparentTemperatureMax[idx]}${units.apparentTemperatureMax}';
      final weatherCode = weatherCodes[data.weatherCode[idx]]!;
      final sunrise = getTime(data.sunrise[idx]);
      final sunset = getTime(data.sunset[idx]);
      final precipitationHours = '${data.precipitationHours[idx].toString()}hs';
      final precipitationProbabilityMax =
          '${data.precipitationProbabilityMax[idx]}%';

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
            title: weatherCode.label,
            leading: weatherCode.icon,
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
      final data = pronosticoHora.data.hourly;
      final units = pronosticoHora.data.hourlyUnits;

      final temperature = '${data.temperature2M}${units.temperature2M}';
      final apparentTemperature =
          '${data.apparentTemperature}${units.apparentTemperature}';
      final weatherCode = weatherCodes[data.weatherCode]!;
      final precipitationProbability =
          '${data.precipitationProbability}${units.precipitationProbability}';
      final rain = '${data.rain.toString()}${units.rain}';

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
            title: weatherCode.label,
            leading: weatherCode.icon,
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
      final data = pronosticoDiario.data.daily;
      final int idx = data.time.indexWhere((t) =>
          t.year == now.year &&
          t.month.toString().padLeft(2, "0") == month &&
          t.day.toString().padLeft(2, "0") == day);
      if (idx == -1 || idx + 1 == data.time.length) return '';
      DateTime date =
          (idx + 1 == data.time.length) ? data.time[0] : data.time[idx + 1];
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
      final data = pronosticoDiario.data.daily;
      final int idx = data.time.indexWhere((t) =>
          t.year == now.year &&
          t.month.toString().padLeft(2, "0") == month &&
          t.day.toString().padLeft(2, "0") == day);
      if (idx == -1 || idx == 0) return '';
      DateTime date = (idx == 0) ? data.time.last : data.time[idx - 1];
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
