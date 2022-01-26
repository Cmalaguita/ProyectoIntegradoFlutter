import 'dart:convert';

import 'dart:io';

import 'package:ejerciciocomponentes/auth_http_client/auth_http_client.dart';
import 'package:ejerciciocomponentes/src/models/inscripcion.dart';
class InscripcionService {
  AuthHttpClient authHttpClient= AuthHttpClient();
  crearInscripcion(Inscripcion i) async {
     await authHttpClient.post(Uri.parse('http://10.0.2.2:5000/api/Inscripcion/Crear_Inscripcion'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          "alumnoId": i.alumnoId,
          "empresaId": i.empresaId,
          "posicionId": i.posicionId,
          "estadoInscripcion": "pendiente",
          "fechaInscripcion": DateTime.now().toIso8601String()
        }));
  }
comprobarInscripcion(String idA, String idP) async {
final response = await authHttpClient.get(Uri.parse('http://10.0.2.2:5000/api/Inscripcion/Comprobar_Existencia_Por_Alumno_Y_Posicion?idP='+idP+'&idA='+idA.toString()));
   
      if (response.statusCode==200) {
        
      return inscripcionFromJson(response.body);
      }else{
return -1;
      }
   
  }
  borrarInscripcion(String idInscripcion) async {
final response = await authHttpClient.delete(Uri.parse('http://10.0.2.2:5000/api/Inscripcion/Borrar_Inscripcion?id='+idInscripcion));
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      throw Exception('Fallo al eliminar la inscripcion');
    }
  }
}
