import 'package:flutter/material.dart';
import 'package:flutter_application_base/mocks/ciudad_mock.dart' show listaCiudades;

class CiudadSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Icono para limpiar la búsqueda
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
        print(city['country_code']);
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
          onTap: () {//SCREEN MENSAJE DE PREGUNTA
            Navigator.pushNamed(context, 'ciudad_seleccionada',
              arguments: <String, dynamic>{
                'name': city['name'],
                'country_code': city['country_code'],
                'latitude': city['latitude'],
                'longitude': city['longitude'],
              }
            );
          }
        );
      },
    );
  }
}