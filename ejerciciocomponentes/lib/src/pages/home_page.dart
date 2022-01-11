import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:ejerciciocomponentes/src/models/alumno.dart';
import 'package:ejerciciocomponentes/src/pages/offers_page.dart';
import 'package:ejerciciocomponentes/src/services/alumno_service.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../main.dart';
import '../menu_provider.dart';
import 'alert_page.dart';


cargarPerfil(){
  String id = dotenv.env['ID_ALUMNO'] ?? "No se encuentra id de usuario";
 return FutureBuilder(
    future: AlumnoService().cargarAlumnoPorId(id),
    builder: (BuildContext context,AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
    
    if (snapshot.data is Alumno) {
        
        return  Column(
          children: [SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children:  [
          CircleAvatar(
            backgroundImage:NetworkImage(
                    'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/6/61/Otto_Octavius.png/revision/latest?cb=20210824014645&path-prefix=es'),
          ),
        ],
      ),
    ),
             Container(
               child: ListView(
                 shrinkWrap: true,
                children: [
                  Text("Email: "+ snapshot.data.email,style:  const TextStyle(color: Colors.black, fontFamily: 'Opensans',),),
                  Text("Nombre: "+ snapshot.data.nombre),
                  Text("Apellidos: "+ snapshot.data.apellidos),
                  Text("Fecha de nacimiento: "+ snapshot.data.fechaDeNacimiento.toString()),
                  Text("Provincia: "+ snapshot.data.provincia.nombre),
                  Text("Localidad: "+ snapshot.data.localidad),
                  Text("Ciclo en curso: "+ snapshot.data.ciclo.nombre),
                  Text("Nota media: "+ snapshot.data.notaMedia.toString()),
                ],
            ),
             ),
          ],
        );
    }else{
      return const Text("no es un alumno");
    }        
      }else if (snapshot.hasError) {
        return const Text("error en data");
      }else{
       return const CircularProgressIndicator();
      }
    }
);
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body:Stack(
children: <Widget>[Column(
  

mainAxisAlignment: MainAxisAlignment.start,
children: <Widget>[
  
Text(dotenv.env['ID_ALUMNO']?? "Falta la id del alumno",style: const TextStyle(color: Colors.redAccent,fontFamily: 'Leelawadee',fontWeight:FontWeight.bold,fontSize:55),


),

Container(
  
  child: cargarPerfil(),
)



],

),

]) ,
     drawer: navigationDrawer(),   
    );
  }

}
