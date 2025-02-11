import 'package:flutter/material.dart';
import 'package:clima_app/helpers/pronostico_horario_future.dart';
import 'package:clima_app/models/hourly_data_model.dart';
import 'package:clima_app/models/hourly_forecast_model.dart';
import 'package:clima_app/models/hourly_model.dart';
import 'package:clima_app/models/clima_card_data.dart';
import 'package:clima_app/utils/weather_code_translation.dart'
    show weatherCodes;
import 'package:clima_app/widgets/clima_card.dart';

class PronosticoUnitarioHora extends StatefulWidget {
  const PronosticoUnitarioHora({super.key});

  @override
  State<PronosticoUnitarioHora> createState() => _PronosticoUnitarioHora();
}

class _PronosticoUnitarioHora extends State<PronosticoUnitarioHora> {
  late Future<HourlyForecast?> _pronosticoHorario;

  late List<ClimaCardData> _data;
  late String _hour;
  late String _nextDay;
  late String _prevDay;

  @override
  void initState() {
    super.initState();
    _pronosticoHorario = searchHourlyForecast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return FutureBuilder<HourlyForecast?>(
        future: _pronosticoHorario,
        builder: (context, AsyncSnapshot<HourlyForecast?> snapshot) {
          if (snapshot.hasData) {
            _hour = args['label'];
            updateData(snapshot.data!.data);

            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              final List<Widget> buttons = [];
              if (_prevDay != '') {
                buttons.add(Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50)),
                    onPressed: () {
                      _hour = _prevDay;
                      updateData(snapshot.data!.data);
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ));
              }
              if (_nextDay != '') {
                buttons.add(Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50)),
                    onPressed: () {
                      _hour = _nextDay;
                      updateData(snapshot.data!.data);
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ));
              }

              return Scaffold(
                  appBar: AppBar(
                    title: Text(_hour),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: ClimaCard(data: _data),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Row(children: buttons),
                      ),
                    ],
                  ));
            });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  String getTime(String label) {
    DateTime dateTime = DateTime.parse(label);
    return '${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}hs';
  }

  List<ClimaCardData> getData(String timeLabel, HourlyData hourlyData) {
    final hourly = hourlyData.hourly;
    final idx = getIdx(timeLabel, hourly);
    if (idx == -1) return [];

    final units = hourlyData.hourlyUnits;

    final temperature = '${hourly.temperature2M[idx]}${units.temperature2M}';
    final apparentTemperature =
        '${hourly.apparentTemperature[idx]}${units.apparentTemperature}';
    final weatherCode = weatherCodes[hourly.weatherCode[idx]]!;
    final precipitationProbability =
        '${hourly.precipitationProbability[idx]}${units.precipitationProbability}';
    final rain = '${hourly.rain[idx].toString()}${units.rain}';

    return [
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
    ];
  }

  String getNext(String timeLabel, Hourly hourly) {
    final idx = getIdx(timeLabel, hourly);
    if (idx == -1 || idx + 1 == hourly.time.length) return '';
    return '${hourly.time[idx + 1].hour.toString().padLeft(2, "0")}hs';
  }

  String getPrev(String timeLabel, Hourly hourly) {
    final idx = getIdx(timeLabel, hourly);
    if (idx == -1 || idx == 0) return '';
    return '${hourly.time[idx - 1].hour.toString().padLeft(2, "0")}hs';
  }

  int getIdx(String timeLabel, Hourly hourly) {
    final hour = timeLabel.substring(0, 2);
    return hourly.time
        .indexWhere((t) => t.hour.toString().padLeft(2, "0") == hour);
  }

  void updateData(HourlyData hourlyData) {
    _data = getData(_hour, hourlyData);
    _nextDay = getNext(_hour, hourlyData.hourly);
    _prevDay = getPrev(_hour, hourlyData.hourly);
  }
}
