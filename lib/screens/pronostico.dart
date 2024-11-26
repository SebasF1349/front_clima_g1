import 'package:flutter/material.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';
import 'package:flutter_application_base/widgets/chart.dart';
import 'package:flutter_application_base/mocks/pronostico_mock.dart'
    show pronostico;
import 'package:flutter_application_base/mocks/pronostico_diario_mock.dart'
    show pronosticoDiario;

class Pronostico extends StatelessWidget {
  const Pronostico({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<double> tempHorario =
        tempToDouble(pronostico['data']['hourly']['temperature_2m']);
    List<String> hourLabelsHorario =
        getHourLabels(pronostico['data']['hourly']['time']);

    List<double> tempDiarioMin =
        tempToDouble(pronosticoDiario['data']['daily']['temperature_2m_min']);
    List<double> tempDiarioMax =
        tempToDouble(pronosticoDiario['data']['daily']['temperature_2m_max']);
    List<String> hourLabelsDiario =
        getDayLabels(pronosticoDiario['data']['daily']['time']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronóstico'),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
      ),
      drawer: DrawerMenu(),
      body: ListView(children: [
        // Center(child: Text('Pronóstico')),
        const SizedBox(height: 80),
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
        const SizedBox(height: 80),
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

  List<String> getHourLabels(List<String> labels) {
    return labels.map((label) {
      return '${DateTime.parse(label).hour.toString().padLeft(2, "0")}hs';
    }).toList();
  }

  List<String> getDayLabels(List<String> labels) {
    return labels.map((label) {
      DateTime date = DateTime.parse(label);
      return '${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}';
    }).toList();
  }

  List<double> tempToDouble(List<num> temp) {
    return temp.map((temp) {
      return temp.toDouble();
    }).toList();
  }
}
