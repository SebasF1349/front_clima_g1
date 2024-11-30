import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/clima_card_data.dart';

class ClimaCard extends StatelessWidget {
  final List<ClimaCardData> data;

  const ClimaCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(data[index].leading),
              title: Text(data[index].title),
              subtitle: Text(data[index].subtitle),
            );
          }),
    );
  }
}
