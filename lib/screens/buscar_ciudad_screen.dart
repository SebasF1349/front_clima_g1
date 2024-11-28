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
        children: [ClimaGifWidget(),]
      ),
    );
  }
}


class ClimaGifWidget extends StatelessWidget {
  const ClimaGifWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
              'assets/gif/solnubegif2.gif',
              scale: 0.50
        ),
      ],
    );
  }
}
