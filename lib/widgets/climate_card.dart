import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';

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
    final theme = Theme.of(context);
    final cardColor = theme.colorScheme.surface;
    final shadowColor = theme.shadowColor.withOpacity(0.5);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [cardColor.withOpacity(0.9), cardColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Preferences.city}, ${Preferences.country}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    weatherIcon,
                    size: 80,
                    color: textColor.withOpacity(0.8),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                weatherStateName,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    temperature.toStringAsFixed(0),
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '°',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
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
