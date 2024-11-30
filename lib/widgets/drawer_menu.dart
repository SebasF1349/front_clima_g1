import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = <Map<String, dynamic>>[
    {'route': 'pronostico', 'title': 'Pronóstico', 'subtitle': '', 'icon': Icons.cloud},
    {'route': 'buscar_ciudad', 'title': 'Buscar ciudad', 'subtitle': 'valentina', 'icon': Icons.search},
    {'route': 'home', 'title': 'Home', 'subtitle': 'Home + counter app', 'icon': Icons.home},
    {'route': 'weather_history_list', 'title': 'Historial Clima', 'subtitle': '', 'icon': Icons.history},
    {'route': 'settings', 'title': 'Configuración', 'subtitle': '', 'icon': Icons.settings},
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor, // Usando el color del tema
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeaderAlternative(),
          ...ListTile.divideTiles(
            context: context,
            tiles: _menuItems.map((item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              dense: true,
              minLeadingWidth: 25,
              title: Text(
                item['title']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor, // Color del tema
                ),
              ),
              subtitle: Text(
                item['subtitle'] ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              leading: Icon(item['icon'] as IconData, color: Theme.of(context).primaryColor),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, item['route']!);
              },
            )),
          ),
          Divider(color: Theme.of(context).dividerColor, thickness: 1, indent: 10, endIndent: 10),
        ],
      ),
    );
  }
}

class _DrawerHeaderAlternative extends StatelessWidget {
  const _DrawerHeaderAlternative();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/header_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(height: 10),
          Text(
            'Bienvenido!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Explora las opciones del menú',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
