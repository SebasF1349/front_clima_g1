import 'package:flutter/material.dart';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/utils/weather_utils.dart';
import 'package:clima_app/mocks/historial_mock.dart';
import 'package:clima_app/widgets/drawer_menu.dart';
import 'package:clima_app/screens/weather_info.dart'; 

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
