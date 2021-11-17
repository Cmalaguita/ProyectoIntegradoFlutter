// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:ejerciciocomponentes/src/pages/card_page.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../menu_provider.dart';
import 'alert_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String dropdownProvinceValue = 'Málaga';
  String dropdownProFamilyValue = 'Informática y Comunicaciones';
  String dropdownVTTypeValue = 'Superior';
  String dropdownVTInProgressValue = 'Superior';
  DateTime? _birthDate = null;
  final ButtonStyle _dateBtnStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    elevation: 5.0,
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
  );

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
          child: const TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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
          child: const TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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
          style: const TextStyle(fontFamily: 'Opensans', color: Colors.white,fontWeight: FontWeight.bold),
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
          child: const TextField(
            obscureText: false,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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
          child: const TextField(
            obscureText: false,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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
        // FORMATO DE FECHA ANTERIOR
        // Container(
        //   alignment: Alignment.centerLeft,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(30.0),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.shade400.withOpacity(0.2),
        //           spreadRadius: 1,
        //           blurRadius: 2,
        //           offset: Offset(0, 7),
        //         )
        //       ]),
        //   height: 60.0,
        //   child: const TextField(
        //     obscureText: false,
        //     keyboardType: TextInputType.datetime,
        //     style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
        //     decoration: InputDecoration(
        //       border: InputBorder.none,
        //       contentPadding: EdgeInsets.only(top: 14.0),
        //       prefixIcon: Icon(
        //         Icons.date_range_rounded,
        //         color: Colors.white,
        //       ),
        //       hintText: 'Fecha de nacimiento',
        //       hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
        //     ),
        //   ),
        // ),
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
                  : _birthDate.toString(),
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
          child: DropdownButtonFormField<String>(
            value: dropdownProvinceValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                dropdownProvinceValue = newValue!;
              });
            },
            items: <String>['Málaga', 'Córdoba', 'Cádiz', 'Granada']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
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
          child: const TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
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
          child: DropdownButtonFormField<String>(
            value: dropdownProFamilyValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                dropdownProFamilyValue = newValue!;
              });
            },
            items: <String>[
              'Informática y Comunicaciones',
              'Artes Gráficas',
              'Agraria',
              'Energía y agua'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),

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
          child: DropdownButtonFormField<String>(
            value: dropdownVTTypeValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                dropdownVTTypeValue = newValue!;
              });
            },
            items: <String>['Superior', 'FP Básica', 'Medio']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
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
          child: const TextField(
            obscureText: false,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
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

    return Container(
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
        onPressed: () => print('Sign Up Button Pressed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () {
          Focus.of(context).unfocus();
        },
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
                    // Color(0xFF1B262C),
                    // Color(0xFF0F4C75),
                    // Color(0xFF00B7C2),
                    // Color(0xFFF79B4B7),

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
            )
          ],
        ),
      ),
    ));
  }
}
