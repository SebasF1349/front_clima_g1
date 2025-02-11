import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String get ip => dotenv.env['IP_EMULATOR'] ?? '10.0.2.2:3000';

Future<Uint8List> buscarBandera(String query) async {
  final url = Uri.http(ip, '/api/v1/foto/$query');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Error al cargar la bandera');
  }
}
