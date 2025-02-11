import 'package:flutter/material.dart';
import 'package:clima_app/helpers/historial_dia.dart';
import 'package:clima_app/models/climate_data.dart';
import 'package:clima_app/widgets/widgets.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String date;

  const WeatherDetailsScreen({super.key, required this.date});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailsScreen> {
  late Future<ClimateData?> _climateDataFuture;

  @override
  void initState() {
    super.initState();
    _climateDataFuture = searchClimateDataDayForecast(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Clima - ${widget.date}"),
      ),
      body: FutureBuilder<ClimateData?>(
        future: _climateDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final data = snapshot.data!;

          // Datos adicionales para WeatherDetailsWidget
          final weatherDetails = [
            {
              'title': 'Máx Temp',
              'icon': Icons.thermostat,
              'value': "${data.maxTemp.toStringAsFixed(1)}°C",
            },
            {
              'title': 'Mín Temp',
              'icon': Icons.thermostat_outlined,
              'value': "${data.minTemp.toStringAsFixed(1)}°C",
            },
            {
              'title': 'Viento',
              'icon': Icons.air,
              'value': "${data.windSpeed ?? 'N/A'} km/h",
            },
            {
              'title': 'Lluvia',
              'icon': Icons.water_drop,
              'value': "${data.rain ?? '0'} mm",
            },
          ];

          // Limitar a las primeras 24 horas
          final limitedHourlyTemps = data.hourlyTemperatures.take(24).toList();
          final limitedHourlyTimes = data.hourlyTimes.take(24).toList();

          // Formatear las etiquetas de horas
          List<String> hourLabels = limitedHourlyTimes.map((date) {
            return '${date.hour.toString().padLeft(2, "0")}hs';
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                WeatherDetailsWidget(
                  weatherStateName: data.weatherLabel,
                  weatherIcon: data.weatherIcon,
                  temperature: data.avgTemp,
                  weatherDetails: weatherDetails,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: size.width - 32,
                      height: 150,
                      child: Chart(
                        type: 'horario',
                        min: limitedHourlyTemps,
                        labels: hourLabels,
                        disableClick: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
