import 'package:ejerciciocomponentes/src/models/posicion.dart';

import 'package:http/http.dart' as http;
class PosicionService{

Future <List<Posicion>> cargarTodasLasPosiciones() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/PosicionDeTrabajo/Obtener_Posiciones_De_Trabajo_Activas_Hoy'));
    if (response.statusCode == 200) {
      return posicionesFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}