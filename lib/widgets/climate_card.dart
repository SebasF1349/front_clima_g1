import 'package:flutter/material.dart';

class ClimateCard extends StatelessWidget {
  final String weatherStateName;
  final IconData weatherIcon;
  final double temperature;

  const ClimateCard({
    Key? key,
    required this.weatherStateName,
    required this.weatherIcon,
    required this.temperature,
  }) : super(key: key);

@override
  Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), 
    child: Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff90CAF9), Color(0xff42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            offset: const Offset(0, 10),
            blurRadius: 15,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 20,
            child: Icon(
              weatherIcon,
              size: 80,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              weatherStateName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature.toStringAsFixed(0),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '°',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}