import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/climate_data.dart';
import 'package:flutter_application_base/utils/weather_utils.dart';
import 'package:flutter_application_base/mocks/historial_mock.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';
import 'package:flutter_application_base/screens/weather_info.dart'; 

class WeatherScreenList extends StatelessWidget {
  WeatherScreenList({Key? key}) : super(key: key);

  final List<ClimateData> climateDataList =
      WeatherUtils.processWeatherData(pronosticoHistorial);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial del Clima"),
      ),
      drawer: DrawerMenu(),
      body: ListView.builder(
        itemCount: climateDataList.length,
        itemBuilder: (context, index) {
          final data = climateDataList[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(data.weatherIcon, size: 40),
              title: Text(
                data.date,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                  "Máx: ${data.maxTemp}°C, Mín: ${data.minTemp}°C\n${data.weatherLabel}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherDetailsScreen(data: data),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
