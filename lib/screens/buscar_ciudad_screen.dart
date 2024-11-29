import 'package:flutter/material.dart';
import 'package:flutter_application_base/searchrs/search_ciudad.dart';
import 'package:flutter_application_base/widgets/drawer_menu.dart';

class BuscarCiudad extends StatelessWidget {
  const BuscarCiudad({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar entre Bahias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CiudadSearchDelegate(),
              );
            },
          ),
        ], 
      ),
      drawer: DrawerMenu(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Elegí tu ciudad',
            style: TextStyle(fontSize: 30, letterSpacing: 2, wordSpacing: 3),
          ),
          SizedBox(height: 20),
          ClimaGifWidget(),
          ],
        ),
    );
  }
}


class ClimaGifWidget extends StatelessWidget {
  const ClimaGifWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
              'assets/gif/clouds.gif',
              width: 180,
              height: 180,
        ),
      ],
    );
  }
}