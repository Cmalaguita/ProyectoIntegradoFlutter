import 'dart:convert';
import 'dart:io';

import 'package:ejerciciocomponentes/auth_http_client/auth_http_client.dart';
import 'package:ejerciciocomponentes/src/models/alumno.dart';
import 'package:ejerciciocomponentes/src/models/mensaje.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AlumnoService {
  AuthHttpClient authHttpClient = AuthHttpClient();

  Future<Alumno> cargarAlumnoPorId() async {
    final response = await authHttpClient
        .get(Uri.parse('https://api.infocarlos.me/api/Alumno/Buscar_Alumno_Id'));
    if (response.statusCode == 200) {
      return alumnoFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future generarCodigo(String email) async {
    final response = await http.put(Uri.parse(
        'https://api.infocarlos.me/api/Alumno/Generar_Codigo_Verificacion?email=' +
            email));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> comprobarCodigo(String email, String codigo) async {
    final response = await authHttpClient.get(Uri.parse(
        'https://api.infocarlos.me/api/Alumno/Comprobar_Codigo_Verificacion?email=' +
            email +
            '&codigo=' +
            codigo));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> comprobarCodigoVerificacionEmail(
      String codigo, String email) async {
    final response = await authHttpClient.put(Uri.parse(
        'https://api.infocarlos.me/api/Alumno/Comprobar_Codigo_Verificacion_Email?codigo=' +
            codigo +
            '&email=' +
            email));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cambiarPassword(String pass, String email) async {
    final response = await authHttpClient.put(Uri.parse(
        'https://api.infocarlos.me/api/Alumno/Cambiar_Password_Alumno?pass=' +
            pass +
            '&email=' +
            email));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
Future<List<Mensaje>> cargarMensajesNoLeidos(String id) async {
    final response = await authHttpClient.get(Uri.parse(
        'https://api.infocarlos.me/api/Mensaje/Obtener_Mensajes_No_Leidos?alumnoId=' +
            id));
    if (response.statusCode == 200) {
    List<Mensaje> listam = mensajesFromJson(response.body);
      return listam;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<bool> cambiarEstadoMensaje(String id) async {
    final response = await authHttpClient.put(Uri.parse(
        'https://api.infocarlos.me/api/Mensaje/Cambiar_Estado_Lectura?idmensaje='+id+'&leido=true'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Alumno> cambiarImagen(Alumno a) async {
    final response = await authHttpClient.put(Uri.parse(
        'https://api.infocarlos.me/api/Alumno/Cambiar_Imagen_Alumno'),headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
         "id": a.id,
        "email": a.email,
        "password": a.password,
        "nombre": a.nombre,
        "apellidos": a.apellidos,
        "idCiclo": a.idCiclo,
        "ciclo": a.ciclo!.toJson(),
        "fechaDeNacimiento": a.fechaDeNacimiento.toIso8601String(),
        "localidad": a.localidad,
        "idProvincia": a.idProvincia,
        "provincia": a.provincia!.toJson(),
        "notaMedia": a.notaMedia,
        "emailVerificado":a.emailVerificado,
        "imagen":a.imagen
        }));
    if (response.statusCode == 200) {
      Alumno a = alumnoFromJson(response.body);
      return a;
    } else {
     throw Exception('No se ha podido cambiar de imagen.');
    }
  }



  // crearInscripcion(Inscripcion i) async {
  //   await authHttpClient.post(
  //       Uri.parse('https://api.infocarlos.me/api/Inscripcion/Crear_Inscripcion'),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //         HttpHeaders.acceptHeader: 'application/json',
  //       },
  //       body: jsonEncode({
  //         "alumnoId": i.alumnoId,
  //         "empresaId": i.empresaId,
  //         "posicionId": i.posicionId,
  //         "estadoInscripcion": "pendiente",
  //         "fechaInscripcion": DateTime.now().toIso8601String()
  //       }));
  // }

}