import 'package:ejerciciocomponentes/auth_http_client/auth_http_client.dart';
import 'package:ejerciciocomponentes/src/models/posicion.dart';

class PosicionService {
  AuthHttpClient authHttpClient = AuthHttpClient();
  Future<List<Posicion>> cargarTodasLasPosiciones(String id) async {
    final response = await authHttpClient.get(Uri.parse(
        'https://api.infocarlos.me/api/PosicionDeTrabajo/Obtener_Posiciones_De_Trabajo_Por_Ciclo?id=' +
            id));
    if (response.statusCode == 200) {
      return posicionesFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
