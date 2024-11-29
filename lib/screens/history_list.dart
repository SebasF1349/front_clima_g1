import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/climate_data.dart';
import 'package:flutter_application_base/widgets/climate_item.dart';

class ClimateListScreen extends StatelessWidget {
  final List<ClimateData> climateDataList;

  const ClimateListScreen({super.key, required this.climateDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: ListView.builder(
        itemCount: climateDataList.length,
        itemBuilder: (context, index) {
          return ClimateItem(climateData: climateDataList[index]);
        },
      ),
    );
  }
}
