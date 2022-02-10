import 'package:ejerciciocomponentes/src/models/tipociclo.dart';
import 'package:http/http.dart' as http;

class TipoCicloService {
  Future<List<TipoCiclo>> cargarTodosLosTipoCiclos() async {
    final response = await http.get(Uri.parse(
        'http://vps-697f2832.vps.ovh.net/api/TipoDeCiclo/Obtener_Todos_Los_Tipos_De_Ciclo'));
    if (response.statusCode == 200) {
      return tipoCicloFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
