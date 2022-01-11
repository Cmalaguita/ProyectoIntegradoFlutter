 import 'package:ejerciciocomponentes/src/models/alumno.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
 import 'package:http/http.dart' as http;
 class AlumnoService {

Future <Alumno> cargarAlumnoPorId(String id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/Alumno/Buscar_Alumno_Id?id='+id));
    if (response.statusCode == 200) {
      return alumnoFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

 }