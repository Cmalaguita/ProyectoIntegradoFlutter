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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Alumno? a;
  cargarPerfil() {
    return FutureBuilder(
        future: AlumnoService().cargarAlumnoPorId(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Alumno) {
              a = snapshot.data;
              return Column(
                children: [
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.blue[900],
                          child: const CircleAvatar(
                            radius: 53,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://static.wikia.nocookie.net/marvelcinematicuniverse/images/6/61/Otto_Octavius.png/revision/latest?cb=20210824014645&path-prefix=es'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade900, width: 5),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.white,
                          offset: new Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Email: " + snapshot.data.email,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.blue[900],
                        ),
                        Text(
                          "Nombre: " + snapshot.data.nombre,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Apellidos: " + snapshot.data.apellidos,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Fecha de nacimiento: " +
                              snapshot.data.fechaDeNacimiento
                                  .toString()
                                  .substring(0, 10),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.blue[900],
                        ),
                        Text(
                          "Provincia: " + snapshot.data.provincia.nombre,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Localidad: " + snapshot.data.localidad,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Ciclo en curso: " + snapshot.data.ciclo.nombre,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "Nota media: " + snapshot.data.notaMedia.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Opensans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text("no es un alumno");
            }
          } else if (snapshot.hasError) {
            return const Text("error en data");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget _buildUpdateBtn() {
    final ButtonStyle _eBtnStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5.0,
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    );

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          child: const Text(
            'Editar Perfil',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Opensans'),
          ),
          style: _eBtnStyle,
          onPressed: () {
            Navigator.pushNamed(context, 'updateProfile')
                .then((value) => {setState(() {})});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        )),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: cargarPerfil(),
              ),
              _buildUpdateBtn()
            ],
          ),
        ]),
      ),
      drawer: navigationDrawer(),
    );
  }
}
