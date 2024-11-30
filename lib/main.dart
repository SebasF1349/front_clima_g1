import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/screens/ciudad_eleccion_screen.dart';
import 'package:flutter_application_base/screens/screens.dart';
import 'package:flutter_application_base/providers/theme_provider.dart';
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
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        theme: tema.temaActual,
        routes: {
          'home': (context) => Preferences.city == '' ? const BuscarCiudad() : const Pronostico(),
          'pronostico': (context) => const Pronostico(),
          'pronostico_unitario': (context) => const PronosticoDia(),
          'weather_history_list': (context) => WeatherScreenList(),
          'settings': (context) => const Settings(),
          'ciudad_seleccionada': (context) => const CiudadSeleccionada(),
          'buscar_ciudad': (context) => const BuscarCiudad(),
        }
        );
  }
}
