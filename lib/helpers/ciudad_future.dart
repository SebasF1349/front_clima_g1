import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_app/models/ciudad_model.dart';

String get ip => dotenv.env['IP_CHROME'] ?? '127.0.0.1:3000';

Future<CiudadesLista?> searchCiudad(String query) async {
  try {
    final url = Uri.http(ip, '/api/v1/ciudad', {'nombre': query});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        try {
          return ciudadesListaFromJson(response.body);
        } on FormatException {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}