import 'package:flutter/material.dart';
import 'package:clima_app/helpers/pronostico_diario_future.dart';
import 'package:clima_app/models/daily_data_model.dart';
import 'package:clima_app/models/daily_forecast_model.dart';
import 'package:clima_app/models/daily_model.dart';
import 'package:clima_app/models/clima_card_data.dart';
import 'package:clima_app/utils/weather_code_translation.dart'
    show weatherCodes;
import 'package:clima_app/widgets/clima_card.dart';

class PronosticoUnitarioDia extends StatefulWidget {
  const PronosticoUnitarioDia({super.key});

  @override
  State<PronosticoUnitarioDia> createState() => _PronosticoUnitarioDia();
}

class _PronosticoUnitarioDia extends State<PronosticoUnitarioDia> {
  late Future<DailyForecast?> _pronosticoDiario;

  late List<ClimaCardData> _data;
  late String _today;
  late String _nextDay;
  late String _prevDay;

  @override
  void initState() {
    super.initState();
    _pronosticoDiario = searchDailyForecast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return FutureBuilder<DailyForecast?>(
        future: _pronosticoDiario,
        builder: (context, AsyncSnapshot<DailyForecast?> snapshot) {
          if (snapshot.hasData) {
            _today = args['label'];
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
                      _today = _prevDay;
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
                      _today = _nextDay;
                      updateData(snapshot.data!.data);
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ));
              }

              return Scaffold(
                  appBar: AppBar(
                    title: Text(_today),
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

  List<ClimaCardData> getData(String dateLabel, DailyData dailyData) {
    final daily = dailyData.daily;
    final idx = getIdx(dateLabel, daily);
    if (idx == -1) return [];

    final units = dailyData.dailyUnits;

    final temperature =
        '${daily.temperature2MMin[idx]}${units.temperature2MMin}/${daily.temperature2MMax[idx]}${units.temperature2MMin}';
    final apparentTemperature =
        '${daily.apparentTemperatureMin[idx]}${units.apparentTemperatureMin}/${daily.apparentTemperatureMax[idx]}${units.apparentTemperatureMax}';
    final weatherCode = weatherCodes[daily.weatherCode[idx]]!;
    final sunrise = getTime(daily.sunrise[idx]);
    final sunset = getTime(daily.sunset[idx]);
    final precipitationHours = '${daily.precipitationHours[idx].toString()}hs';
    final precipitationProbabilityMax =
        '${daily.precipitationProbabilityMax[idx]}%';

    return [
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
    ];
  }

  String getNext(String dateLabel, Daily daily) {
    final idx = getIdx(dateLabel, daily);
    if (idx == -1 || idx + 1 == daily.time.length) return '';
    DateTime date =
        (idx + 1 == daily.time.length) ? daily.time[0] : daily.time[idx + 1];
    return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
  }

  String getPrev(String dateLabel, Daily daily) {
    final idx = getIdx(dateLabel, daily);
    if (idx == -1 || idx == 0) return '';
    DateTime date = (idx == 0) ? daily.time.last : daily.time[idx - 1];
    return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
  }

  int getIdx(String dateLabel, Daily daily) {
    final [day, month] = dateLabel.split('/');
    DateTime now = DateTime.now();
    return daily.time.indexWhere((t) =>
        t.year == now.year &&
        t.month.toString().padLeft(2, "0") == month &&
        t.day.toString().padLeft(2, "0") == day);
  }

  void updateData(DailyData dailyData) {
    _data = getData(_today, dailyData);
    _nextDay = getNext(_today, dailyData.daily);
    _prevDay = getPrev(_today, dailyData.daily);
  }
}
