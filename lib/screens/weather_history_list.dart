import 'package:clima_app/helpers/historial_lista.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/widgets/drawer_menu.dart';
import 'package:clima_app/screens/weather_info.dart';

class WeatherScreenList extends StatefulWidget {
  const WeatherScreenList({super.key});

  @override
  State<WeatherScreenList> createState() => _WeatherScreenListState();
}

class _WeatherScreenListState extends State<WeatherScreenList> {
  late Future<List<ClimateData>> _climateDataFuture;

  @override
  void initState() {
    super.initState();
    _climateDataFuture = searchClimateDataForecast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial del Clima"),
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder<List<ClimateData>>(
        future: _climateDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          List<ClimateData> climateDataList = snapshot.data!;
          final reversedList = climateDataList.reversed.toList();

          return ListView.builder(
            itemCount: reversedList.length,
            itemBuilder: (context, index) {
              final data = reversedList[index];
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
                        builder: (context) => WeatherDetailsScreen(date: data.date),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
