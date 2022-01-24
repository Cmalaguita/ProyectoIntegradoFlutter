 import 'package:ejerciciocomponentes/auth_http_client/auth_http_client.dart';
import 'package:ejerciciocomponentes/src/models/alumno.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
 import 'package:http/http.dart' as http;
 class AlumnoService {
AuthHttpClient authHttpClient= AuthHttpClient();

Future <Alumno> cargarAlumnoPorId(String id) async {
    final response = await authHttpClient.get(Uri.parse('http://10.0.2.2:5000/api/Alumno/Buscar_Alumno_Id?id='+id));
    if (response.statusCode == 200) {
      return alumnoFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
Future generarCodigo(String email) async{
final response= await http.put(Uri.parse('http://10.0.2.2:5000/api/Alumno/Generar_Codigo_Verificacion?email='+email));
if (response.statusCode==200) {
  return true;
} else{
  return false;
}
}

Future <bool> comprobarCodigo(String email, String codigo) async{
final response= await authHttpClient.get(Uri.parse('http://10.0.2.2:5000/api/Alumno/Comprobar_Codigo_Verificacion?email='+email+'&codigo='+codigo));
if (response.statusCode==200) {
  return true;
} else{
  return false;
}
}
Future <bool> comprobarCodigoVerificacionEmail(String codigo, String email) async{
final response= await authHttpClient.put(Uri.parse('http://10.0.2.2:5000/api/Alumno/Comprobar_Codigo_Verificacion_Email?codigo='+codigo+'&email='+email));
if (response.statusCode==200) {
  return true;
} else{
  return false;
}
}
Future <bool> cambiarPassword(String pass, String email) async{
final response= await authHttpClient.put(Uri.parse('http://10.0.2.2:5000/api/Alumno/Cambiar_Password_Alumno?pass='+pass+'&email='+email));
if (response.statusCode==200) {
  return true;
} else{
  return false;
}
 }
 }