import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _menuItems = <Map<String, dynamic>>[
    {
      'route': 'pronostico',
      'title': 'Pronóstico',
      'subtitle': '',
      'icon': Icons.cloud,
    },
    {
      'route': 'buscar_ciudad',
      'title': 'Buscar ciudad',
      'subtitle': 'valentina',
      'icon': Icons.search,
    },
    {
      'route': 'home',
      'title': 'Home',
      'subtitle': 'Home + counter app',
      'icon': Icons.home,
    },
    {
      'route': 'weather_history_list',
      'title': 'Historial Clima',
      'subtitle': '',
      'icon': Icons.history,
    },
    {
      'route': 'settings',
      'title': 'Configuración',
      'subtitle': '',
      'icon': Icons.settings,
    },
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor ?? theme.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeaderAlternative(),
          ...ListTile.divideTiles(
            context: context,
            tiles: _menuItems.map(
              (item) => ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                dense: true,
                minLeadingWidth: 25,
                title: Text(
                  item['title']!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.listTileTheme.textColor ?? theme.colorScheme.onSurface,
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
                  color: theme.listTileTheme.iconColor ?? theme.colorScheme.primary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, item['route']!);
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
