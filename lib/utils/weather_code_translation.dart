import 'package:flutter/material.dart';
import 'package:flutter_application_base/models/weather_code.dart';

Map<int, WeatherCode> weatherCodes = {
  0: WeatherCode(label: 'Cielo despejado', icon: Icons.wb_sunny),
  1: WeatherCode(label: 'Cielo principalmende despejado', icon: Icons.cloud),
  2: WeatherCode(label: 'Cielo parcialmente despejado', icon: Icons.cloud),
  3: WeatherCode(label: 'Nublado', icon: Icons.cloud),
  45: WeatherCode(label: 'Niebla', icon: Icons.cloud),
  48: WeatherCode(label: 'Escarcha', icon: Icons.cloud),
  51: WeatherCode(label: 'Llovizna ligera', icon: Icons.cloud),
  53: WeatherCode(label: 'Llovizna moderada', icon: Icons.cloud),
  55: WeatherCode(label: 'Llovizna intensa', icon: Icons.cloud),
  56: WeatherCode(label: 'Llovizna helada ligera', icon: Icons.cloud),
  57: WeatherCode(label: 'Llovizna helada intensa', icon: Icons.cloud),
  61: WeatherCode(label: 'Lluvia ligera', icon: Icons.cloud),
  63: WeatherCode(label: 'Lluvia moderada', icon: Icons.cloud),
  65: WeatherCode(label: 'Lluvia intensa', icon: Icons.cloud),
  66: WeatherCode(label: 'Lluvia helada ligera', icon: Icons.cloud),
  67: WeatherCode(label: 'Lluvia helada intensa', icon: Icons.cloud),
  71: WeatherCode(label: 'Caida de nieve ligera', icon: Icons.cloud),
  73: WeatherCode(label: 'Caida de nieve moderada', icon: Icons.cloud),
  75: WeatherCode(label: 'Caida de nieve intensa', icon: Icons.cloud),
  77: WeatherCode(label: 'Cinarra', icon: Icons.cloud),
  80: WeatherCode(label: 'Aguacero ligero', icon: Icons.cloud),
  81: WeatherCode(label: 'Aguacero moderado', icon: Icons.cloud),
  82: WeatherCode(label: 'Aguacero violento', icon: Icons.cloud),
  85: WeatherCode(label: 'Nevada ligera', icon: Icons.cloud),
  86: WeatherCode(label: 'Nevada fuerte', icon: Icons.cloud),
  95: WeatherCode(
      label: 'Tormenta eléctrica ligera o moderada', icon: Icons.cloud),
  96: WeatherCode(label: 'Tormenta con ligero granizo', icon: Icons.cloud),
  99: WeatherCode(label: 'Tormenta con fuerte granizo', icon: Icons.cloud),
};
