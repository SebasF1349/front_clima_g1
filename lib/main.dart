import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/screens/screens.dart';
import 'package:flutter_application_base/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(isDarkMode: Preferences.darkmode),
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
          'home': (context) => const HomeScreen(),
          'pronostico': (context) => const Pronostico(),
          'pronostico_unitario': (context) => const PronosticoDia(),
          'weather_history': (context) => const WeatherScreen(), 
          'custom_list': (context) => const CustomListScreen(),
          'profile': (context) => const ProfileScreen(),
          'custom_list_item': (context) => const CustomListItem(),
        }
        /* home: DesignScreen(), */
        );
  }
}
