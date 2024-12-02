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
          'pronostico': (context) => const Pronostico(),
          'pronostico_unitario': (context) => const PronosticoDia(),
          'weather_history_list': (context) => WeatherScreenList(),
          'settings': (context) => const Settings(),
          'ciudad_seleccionada': (context) => const CiudadSeleccionada(),
          'buscar_ciudad': (context) => const BuscarCiudad(),
        });
  }
}
