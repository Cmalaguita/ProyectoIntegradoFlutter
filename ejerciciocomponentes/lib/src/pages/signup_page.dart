// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:ejerciciocomponentes/src/models/ciclo.dart';
import 'package:ejerciciocomponentes/src/models/familia.dart';
import 'package:ejerciciocomponentes/src/models/provincia.dart';
import 'package:ejerciciocomponentes/src/models/tipociclo.dart';
import 'package:ejerciciocomponentes/src/services/ciclo_service.dart';
import 'package:ejerciciocomponentes/src/services/familia_service.dart';
import 'package:ejerciciocomponentes/src/services/provincia_service.dart';
import 'package:ejerciciocomponentes/src/services/tipociclo_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formValidatorKey = GlobalKey<FormState>();
  int dropdownProvinceValue = 0;
  int dropdownFamilyId = 0;
  int dropdownTypeId = 0;
  int dropdownVTInProgressId = 0;
  DateTime? _birthDate = DateTime.now();
  Future? futureCiclos;
  FutureBuilder? fbCiclos;
  FutureBuilder? dropCiclos;
  String _selectedFamilia = "";
  String _selectedTipoCiclo = "";
  String _selectedCiclo = "";
   String _selectedProvincia = "";
  //controllers
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var repeatPassController = TextEditingController();
  var nameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dateController = TextEditingController();
  var townController = TextEditingController();
  var qualificationController = TextEditingController();

//estilo del boton de fecha
  final ButtonStyle _dateBtnStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    elevation: 5.0,
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
  );

  provincias() {
    return FutureBuilder(
        future: ProvinciaService().loadAllProvincias(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<DropdownMenuItem<Provincia>> listaProvincias = [];
            if (snapshot.data is List<Provincia>) {
              for (var p in snapshot.data) {
                listaProvincias.add(DropdownMenuItem(
                  child: Text(p.nombre),
                  value: p,
                ));
              }
              return DropdownButton<Provincia>(
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (Provincia? newValue) {
                  if (newValue != null) {
                    dropdownProvinceValue = newValue.id;
                    setState(() {
                    _selectedProvincia=newValue.nombre;
                      
                    });
                  }
                },
                hint: Text(_selectedProvincia,style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Opensans',
                    )),
                items: listaProvincias,
              );
            } else {
              return const Text(
                  "Se ha producido un error al cargar las provincias");
            }
          } else if (snapshot.hasError) {
            return const Text(
                "Se ha producido un error al cargar las provincias");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  familias() {
    return FutureBuilder(
        future: FamiliaService().cargarTodasLasFamilias(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<DropdownMenuItem<Familia>> listaFamilias = [];
            if (snapshot.data is List<Familia>) {
              for (var f in snapshot.data) {
                listaFamilias.add(DropdownMenuItem(
                  child: Text(f.nombre),
                  value: f,
                ));
              }
              return DropdownButton<Familia>(
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (newValue) {
                  if (newValue != null) {
                    dropdownFamilyId = newValue.id;
                    setState(() {
                    _selectedFamilia = newValue.nombre;
                      if (dropdownFamilyId > 0 && dropdownTypeId > 0) {
                        futureCiclos = CicloService()
                            .cargarCiclosPorFamiliaYTipo(
                                dropdownFamilyId.toString(),
                                dropdownTypeId.toString());
                      } else if (dropdownFamilyId > 0) {
                        futureCiclos = CicloService().cargarCiclosPorFamilia(
                            dropdownFamilyId.toString());
                      }
                    });
                  }
                },
                hint: Text(_selectedFamilia,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Opensans',
                    )),
                items: listaFamilias,
              );
            } else {
              return const Text(
                  "Se ha producido un error al cargar las familias");
            }
          } else if (snapshot.hasError) {
            return const Text(
                "Se ha producido un error al cargar las familias, no se han devuelto datos");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  tipoCiclos() {
    return FutureBuilder(
        future: TipoCicloService().cargarTodosLosTipoCiclos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<DropdownMenuItem<TipoCiclo>> listaTipoCiclos = [];
            if (snapshot.data is List<TipoCiclo>) {
              for (var tc in snapshot.data) {
                listaTipoCiclos.add(DropdownMenuItem(
                  child: Text(tc.nombre),
                  value: tc,
                ));
              }
              return DropdownButton<TipoCiclo>(
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (TipoCiclo? newValue) {
                  if (newValue != null) {
                    dropdownTypeId = newValue.id;
                    setState(() {
                    _selectedTipoCiclo = newValue.nombre;
                      if (dropdownFamilyId > 0 && dropdownTypeId > 0) {
                        futureCiclos = CicloService()
                            .cargarCiclosPorFamiliaYTipo(
                                dropdownFamilyId.toString(),
                                dropdownTypeId.toString());
                      } else if (dropdownTypeId > 0) {
                        futureCiclos = CicloService()
                            .cargarCiclosPorTipo(dropdownTypeId.toString());
                      }
                    });
                  }
                },
                hint: Text(_selectedTipoCiclo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Opensans',
                    )),
                items: listaTipoCiclos,
              );
            } else {
              return const Text(
                  "Se ha producido un error al cargar los tipos de ciclo");
            }
          } else if (snapshot.hasError) {
            return const Text(
                "Se ha producido un error al cargar los tipos de ciclo, no se han devuelto datos");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  ciclos() {
    if (futureCiclos != null) {
      return FutureBuilder(
          future: futureCiclos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DropdownMenuItem<Ciclo>> listaCiclos = [];
              if (snapshot.data is List<Ciclo>) {
                for (var c in snapshot.data) {
                  listaCiclos.add(DropdownMenuItem(
                    child: Text(c.nombre),
                    value: c,
                  ));
                }

                return DropdownButton<Ciclo>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (Ciclo? newValue) {
                    if (newValue != null) {
                      dropdownVTInProgressId = newValue.id;
                      setState(() {
                      _selectedCiclo = newValue.nombre;
                        
                      });
                    }
                  },
                  hint: Text(_selectedCiclo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Opensans',
                      )),
                  items: listaCiclos,
                );
              } else {
                return const Text(
                    "Se ha producido un error al cargar los ciclos");
              }
            } else if (snapshot.data == null || snapshot.hasError) {
              return const Text(
                  "Se ha producido un error al cargar los ciclos, no se han devuelto datos");
            } else {
              return const CircularProgressIndicator();
            }
          });
    } else {
      return DropdownButtonFormField(
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: null,
        items: const [],
      );
    }
  }

//future de registro
  Future<void> signUp() async {
   
    if (passController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty &&
        nameController.value.text.isNotEmpty &&
        lastnameController.value.text.isNotEmpty &&
        townController.value.text.isNotEmpty &&
        qualificationController.value.text.isNotEmpty &&
        dropdownVTInProgressId > 0 &&
        dropdownProvinceValue > 0 &&
        repeatPassController.value.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('http://10.0.2.2:5000/api/Alumno/Sign_Up_Alumno'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
          },
          body: jsonEncode({
            'email': emailController.text,
            'password': passController.text,
            'nombre': nameController.text,
            'apellidos': lastnameController.text,
            "idCiclo": dropdownVTInProgressId,
            "fechaDeNacimiento": _birthDate!.toIso8601String(),
            "localidad": townController.text,
            "idProvincia": dropdownProvinceValue,
            "notaMedia": double.parse(qualificationController.text)
          }));

      if (response.statusCode == 200) {
        print(response.statusCode);

        Navigator.pushNamed(context, 'login');
      } else {
        print(response.statusCode);
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error 400")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Hay campos en blanco")));
    }
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contraseña',
          style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
        ),
        const SizedBox(
          height: 10.0,
        ),
        //container 1
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            controller: passController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Contraseña',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        //container 2
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            controller: repeatPassController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Repetir contraseña',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 15.0,
        ),
        const Text(
          'Información de perfil ',
          style: TextStyle(
              fontFamily: 'Opensans',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        //container 1
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
              return null;
            },
            controller: nameController,
            obscureText: false,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              hintText: 'Nombre',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        //container 2
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField( validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
              return null;
            },
            controller: lastnameController,
            obscureText: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              hintText: 'Apellidos',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Fecha de nacimiento',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
          ),
        ),

        const SizedBox(
          height: 10.0,
        ),

        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              _birthDate == null
                  ? 'Fecha no seleccionada'
                  : _birthDate.toString().substring(0, 10),
              style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Opensans'),
            ),
            style: _dateBtnStyle,
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2200))
                  .then((date) {
                setState(() {
                  _birthDate = date;
                });
              });
            },
          ),
        ),

        const SizedBox(
          height: 20.0,
        ),

        Container(
          alignment: Alignment.center,
          child: const Text(
            'Provincia',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
          ),
        ),

        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue.shade800,
          ),
          child: provincias(),
        ),

        const SizedBox(
          height: 20.0,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
             validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
              return null;
            },
            controller: townController,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_searching_outlined,
                color: Colors.white,
              ),
              hintText: 'Localidad',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
// DROPDOWN FAMILIAS
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Familia profesional',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue.shade800,
          ),
          child: familias(),
        ),
        const SizedBox(
          height: 20.0,
        ),
// DROPDOWN TIPOCICLOS
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Tipo de grado',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue.shade800,
          ),
          child: tipoCiclos(),
        ),
        const SizedBox(
          height: 20.0,
        ),
        // DROPDOWN CICLOS
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Ciclo',
            style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.blue.shade800,
          ),
          child: ciclos(),
        ),
        const SizedBox(
          height: 20.0,
        ),

        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
             validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
              return null;
            },
            controller: qualificationController,
            obscureText: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.score_rounded,
                color: Colors.white,
              ),
              hintText: 'Calificación media',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Email',
            style: TextStyle(fontFamily: 'Opensans', color: Colors.white)),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }

              if (!EmailValidator.validate(value)) {
                return 'Email no valido';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cancelSignUp() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "¡Llevame de vuelta al login!",
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    final ButtonStyle _eBtnStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5.0,
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    );

    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          child: const Text(
            'Registrarse',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Opensans'),
          ),
          style: _eBtnStyle,
          onPressed: (){
            if (_formValidatorKey.currentState!.validate()) {
              if (passController.value.text==repeatPassController.value.text) {
                signUp();
              }
            }
          }, 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
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
              ))),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 40.0,
              ),
              child: Form(
                key: _formValidatorKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Registro',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Opensans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildEmail(),
                    const SizedBox(height: 30.0),
                    _buildPassword(),
                    _buildPersonalData(),
                    _buildSignUpBtn(),
                    _cancelSignUp(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
