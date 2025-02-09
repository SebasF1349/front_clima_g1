import 'package:clima_app/helpers/pronostico_horario_future.dart';
import 'package:clima_app/helpers/pronostico_diario_future.dart';
import 'package:clima_app/models/daily_forecast_model.dart';
import 'package:clima_app/models/hourly_forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/utils/weather_code_translation.dart';
import 'package:clima_app/widgets/drawer_menu.dart';
import 'package:clima_app/widgets/chart.dart';
import 'package:clima_app/widgets/weather_detail.dart';

class Pronostico extends StatefulWidget {
  const Pronostico({super.key});

  @override
  State<Pronostico> createState() => _Pronostico();
}

class _Pronostico extends State<Pronostico> {
  late Future<HourlyForecast?> _pronosticoHorario;
  late Future<DailyForecast?> _pronosticoDiario;

  @override
  void initState() {
    super.initState();
    _pronosticoHorario = searchHourlyForecast();
    _pronosticoDiario = searchDailyForecast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pronóstico'),
        ),
        drawer: DrawerMenu(),
        body: FutureBuilder<List<dynamic>>(
            future: Future.wait([_pronosticoHorario, _pronosticoDiario]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                DateTime now = DateTime.now();

                List<double> tempHorario =
                    tempToDouble(snapshot.data![0]!.data.hourly.temperature2M);
                List<String> hourLabelsHorario =
                    getHourLabels(snapshot.data![0]!.data.hourly.time);

                List<double> tempDiarioMin = tempToDouble(
                    snapshot.data![1]!.data.daily.temperature2MMin);
                List<double> tempDiarioMax =
                    tempToDouble(snapshot.data![1].data.daily.temperature2MMax);
                List<String> hourLabelsDiario =
                    getDayLabels(snapshot.data![1].data.daily.time);

                final weather =
                    weatherCodes[snapshot.data![1].data.daily.weatherCode[0]];

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
                        "${snapshot.data![1].data.daily.precipitationProbabilityMax[0]} %",
                  },
                ];

                return ListView(children: [
                  const SizedBox(height: 10),
                  WeatherDetailsWidget(
                    weatherStateName: weather?.label ?? 'Clima desconocido',
                    weatherIcon: weather?.icon ?? Icons.help_outline,
                    temperature: tempHorario[now.hour],
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
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            }));
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