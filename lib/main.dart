import 'package:clima_app/screens/pronostico_unitario_hora.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/helpers/background_detector.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/screens/ciudad_eleccion_screen.dart';
import 'package:clima_app/screens/screens.dart';
import 'package:clima_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();
  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(flavor: Preferences.getTheme()),
      ),
    ],
    child: const BackgroundDetector(child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<ThemeProvider>(context, listen: true);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Preferences.city == '' ? 'buscar_ciudad' : 'pronostico',
        theme: tema.temaActual,
        routes: {
          'pronostico': (context) => Pronostico(),
          'pronostico_unitario_dia': (context) => const PronosticoUnitarioDia(),
          'pronostico_unitario_hora': (context) =>
              const PronosticoUnitarioHora(),
          'weather_history_list': (context) => WeatherScreenList(),
          'settings': (context) => const Settings(),
          'ciudad_seleccionada': (context) => CiudadSeleccionada(),
          'buscar_ciudad': (context) => const BuscarCiudad(),
        });
  }
}
