import 'package:ejerciciocomponentes/src/models/ciclo.dart';
import 'package:http/http.dart' as http;

class CicloService {
  Future<List<Ciclo>> cargarTodosLosCiclos() async {
    final response = await http.get(
        Uri.parse('https://api.infocarlos.me/api/Ciclo/Obtener_Todos_Los_Ciclos'));
    if (response.statusCode == 200) {
      return cicloFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Ciclo>> cargarCiclosPorFamiliaYTipo(
      String idFamilia, String idTipo) async {
    final response = await http.get(Uri.parse(
        'https://api.infocarlos.me/api/Ciclo/Obtener_Ciclos_Por_Familia_Y_Tipo?idTipo=' +
            idTipo +
            '&idFamilia=' +
            idFamilia));
    if (response.statusCode == 200) {
      return cicloFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Ciclo>> cargarCiclosPorTipo(String idTipo) async {
    final response = await http.get(Uri.parse(
        'https://api.infocarlos.me/api/Ciclo/Obtener_Ciclos_Por_Tipo?idTipo=' +
            idTipo));
    if (response.statusCode == 200) {
      return cicloFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Ciclo>> cargarCiclosPorFamilia(String idFamilia) async {
    final response = await http.get(Uri.parse(
        'https://api.infocarlos.me/api/Ciclo/Obtener_Ciclos_Por_Familia?idFamilia=' +
            idFamilia));
    if (response.statusCode == 200) {
      return cicloFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
