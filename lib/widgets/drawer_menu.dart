import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = <Map<String, dynamic>>[
    {
      'route': 'pronostico',
      'title': 'Pronóstico',
      'subtitle': 'Sebastián',
      'icon': Icons.cloud,
    },
    {
      'route': 'weather_history_list',
      'title': 'Historial Clima',
      'subtitle': 'Mateo',
      'icon': Icons.history,
    },
    {
      'route': 'buscar_ciudad',
      'title': 'Buscar Ciudad',
      'subtitle': 'Valentina',
      'icon': Icons.search,
    },
    {
      'route': 'settings',
      'title': 'Configuración',
      'subtitle': 'Sebastián',
      'icon': Icons.settings,
    },
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor:
          theme.drawerTheme.backgroundColor ?? theme.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeaderAlternative(),
          ...ListTile.divideTiles(
            context: context,
            tiles: _menuItems.map(
              (item) => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                dense: true,
                minLeadingWidth: 25,
                title: Text(
                  item['title']!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.listTileTheme.textColor ??
                        theme.colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7) ??
                        theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                leading: Icon(
                  item['icon'] as IconData,
                  color: theme.listTileTheme.iconColor ??
                      theme.colorScheme.primary,
                ),
                onTap: () {
                  if ((item['route'] == 'pronostico' ||
                          item['route'] == 'weather_history_list') &&
                      Preferences.city == '') {
                    redirectChooseCity(context);
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, item['route']!);
                  }
                },
              ),
            ),
          ),
          Divider(
            color: theme.dividerColor,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }

  Future<void> redirectChooseCity(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Debe elegir una ciudad primero',
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Elegir',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'buscar_ciudad');
              },
            ),
          ],
        );
      },
    );
  }
}

class DrawerHeaderAlternative extends StatelessWidget {
  const DrawerHeaderAlternative({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DrawerHeader(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Fondo de seguridad
      ),
      child: Stack(
        children: [
          // Contenido del header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 10),
              Text(
                'Bienvenido!',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Explora las opciones del menú',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
