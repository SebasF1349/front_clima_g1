import 'dart:typed_data';
import 'package:clima_app/helpers/bandera_foto_future.dart';
import 'package:clima_app/helpers/ciudad_future.dart';
import 'package:clima_app/models/ciudad_data.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/models/ciudad_model.dart';

class CiudadSearchDelegate extends SearchDelegate<Ciudad?> {
  Future<List<Ciudad>> fetchCities(String query) async {
    CiudadesLista? ciudadesLista = await searchCiudad(query);

    if (ciudadesLista == null || ciudadesLista.data.isEmpty) {
      return [];
    }

    return ciudadesLista.data
        .where((ciudad) => ciudad.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
          child: Text('Escribe una ciudad para buscar', style: TextStyle(fontSize: 20)));
    }

    return FutureBuilder<CiudadesLista?>(
      future: searchCiudad(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar datos'));
        }

        final ciudadesLista = snapshot.data;
        if (ciudadesLista == null || ciudadesLista.data.isEmpty) {
          return const Center(child: Text('No se encontraron ciudades.'));
        }

        final suggestions = ciudadesLista.data;

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final city = suggestions[index];
            final bandera = city.countryCode.toLowerCase();

            return FutureBuilder<Uint8List?>(
              future: buscarBandera(bandera),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(),)
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return InkWell(
                    onTap: () async {
                      try {
                        Preferences.city = city.name;
                        Preferences.latitude = city.latitude;
                        Preferences.longitude = city.longitude;
                        Preferences.timezone = city.timezone;
                        Preferences.countryCode = city.countryCode;
                        Preferences.country = city.country ?? '';
                        Preferences.provincia = city.admin1 ?? '';

                        await Navigator.pushNamed(
                          context,
                          'ciudad_seleccionada'
                        );

                        close(context, city);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error al procesar la ciudad seleccionada')),
                        );
                      }
                    },
                    child: ListTile(
                      leading: Image.memory(
                        snapshot.data!,
                        width: 30,
                        height: 22,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                      title: Text(
                        city.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(city.admin1 ?? 'Desconocido'),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: const Icon(Icons.flag, color: Colors.grey),
                    title: Text(
                      city.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(city.admin1 ?? 'Desconocido'),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }
}