import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';
import 'package:flutter_application_base/mocks/ciudad_mock.dart' show listaCiudades;

class CiudadSearchDelegate extends SearchDelegate {
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = listaCiudades.where((ciudad) {
      final ciudadName = ciudad['name']!.toLowerCase();
      final input = query.toLowerCase();
      return ciudadName.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final city = suggestions[index];
        return ListTile(
          leading: Image.asset(
            'assets/banderas/${city['country_code']}.png',
            width: 30,
            height: 22,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Error cargando imagen: $error');
              return const Icon(Icons.flag, color: Colors.grey);
            },
          ),
          title: Text(
            city['name']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(city['admin1']!),
          onTap: () async {
            try{
                Preferences.city = city['name']!;
                Preferences.latitude = city['latitude']!;
                Preferences.longitude = city['longitude']!;
                Preferences.timezone = city['timezone']!;
                Preferences.country = city['country']!;
                Preferences.provincia = city['admin1']!;
                Navigator.pushNamed(context, 'ciudad_seleccionada',
                  arguments: <String, dynamic>{
                    'country_code': city['country_code'],
                  }
                );
            } catch (e) {
                print('Error al procesar la ciudad seleccionada: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al procesar la ciudad seleccionada')),
              );
            }
          }
        );
      },
    );

  }
}
