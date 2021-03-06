import 'package:ejerciciocomponentes/src/models/provincia.dart';
import 'package:http/http.dart' as http;

class ProvinciaService {
  Future<List<Provincia>> loadAllProvincias() async {
    final response = await http.get(Uri.parse(
        'https://api.infocarlos.me/api/Provincia/Obtener_Todas_Las_Provincias'));
    if (response.statusCode == 200) {
      return provinciaFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
