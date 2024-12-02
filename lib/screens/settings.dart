import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSettings(size: size),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: BodySettings(),
            ),
          ],
        ),
      ),
    );
  }
}

class BodySettings extends StatelessWidget {
  final bool darkMode = false;

  const BodySettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Options(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

const List<String> themes = <String>[
  'latte',
  'frappe',
  'macchiato',
  'mocha',
];

class _OptionsState extends State<Options> {
  String theme = themes.last;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    List<String> timezones = [for (var i = -12; i <= 14; i += 1) i.toString()];
    timezones.insert(0, 'Ciudad Elegida');
    timezones.insert(1, 'Sistema');

    return Column(
      children: [
        SettingsDropdownMenu(
            label: 'Tema',
            dropdownMenu: DropdownMenu<String>(
              width: size.width * 9 / 20,
              initialSelection: Preferences.theme,
              onSelected: (String? value) {
                setState(() {
                  Preferences.theme = value!;
                  temaProvider.setTheme(Preferences.getTheme());
                });
              },
              dropdownMenuEntries: [...themes, 'sistema']
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            )),
        if (Preferences.theme == 'sistema')
          SettingsDropdownMenu(
            label: 'Tema Oscuro',
            dropdownMenu: DropdownMenu<String>(
              width: size.width * 9 / 20,
              initialSelection: Preferences.darkTheme,
              onSelected: (String? value) {
                setState(() {
                  Preferences.darkTheme = value!;
                  temaProvider.setTheme(Preferences.getTheme());
                });
              },
              dropdownMenuEntries:
                  themes.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
          ),
        if (Preferences.theme == 'sistema')
          SettingsDropdownMenu(
            label: 'Tema Claro',
            dropdownMenu: DropdownMenu<String>(
              width: size.width * 9 / 20,
              initialSelection: Preferences.lightTheme,
              onSelected: (String? value) {
                setState(() {
                  Preferences.lightTheme = value!;
                  temaProvider.setTheme(Preferences.getTheme());
                });
              },
              dropdownMenuEntries:
                  themes.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
          ),
        SizedBox(
          height: 80,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'buscar_ciudad');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Text(
                    'Cambiar Ciudad',
                    textScaler: TextScaler.linear(1.3),
                  ),
                ]),
              ),
            ),
          ),
        ),
        SettingsDropdownMenu(
          label: 'Zona Horaria',
          dropdownMenu: DropdownMenu<String>(
            width: size.width * 9 / 20,
            initialSelection: Preferences.userSelectedTimezone != ''
                ? Preferences.userSelectedTimezone
                : 'Ciudad Elegida',
            onSelected: (String? value) {
              setState(() {
                Preferences.userSelectedTimezone = value!;
              });
            },
            dropdownMenuEntries:
                timezones.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SettingsDropdownMenu extends StatelessWidget {
  final String label;
  final DropdownMenu dropdownMenu;

  const SettingsDropdownMenu(
      {super.key, required this.label, required this.dropdownMenu});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                label,
                textScaler: TextScaler.linear(1.3),
              ),
              Spacer(),
              dropdownMenu,
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSettings extends StatelessWidget {
  const HeaderSettings({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      color: const Color(0xff2d3e4f),
      child: Center(
        child: CircleAvatar(
          radius: 100,
          child: Image.asset('assets/images/avatar.png'),
        ),
      ),
    );
  }
}
