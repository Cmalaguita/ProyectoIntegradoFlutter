// To parse this JSON data, do
//
//     final alumno = alumnoFromJson(jsonString);

import 'dart:convert';
import 'package:ejerciciocomponentes/src/models/ciclo.dart';
import 'package:ejerciciocomponentes/src/models/provincia.dart';

Alumno alumnoFromJson(String str) => Alumno.fromJson(json.decode(str));
String alumnoToJson(List<Alumno> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alumno {
    Alumno(
        this.id,
        this.email,
        this.password,
        this.nombre,
        this.apellidos,
        this.idCiclo,
        this.ciclo,
        this.fechaDeNacimiento,
        this.localidad,
        this.idProvincia,
        this.provincia,
        this.notaMedia,
    );

    int id;
    String email;
    String? password;
    String nombre;
    String apellidos;
    int idCiclo;
    Ciclo ciclo;
    DateTime fechaDeNacimiento;
    String localidad;
    int idProvincia;
    Provincia provincia;
    int notaMedia;

    factory Alumno.fromJson(Map<String, dynamic> json) => Alumno(
        json["id"],
        json["email"],
        json["password"],
        json["nombre"],
        json["apellidos"],
        json["idCiclo"],
        Ciclo.fromJson(json["ciclo"]),
        DateTime.parse(json["fechaDeNacimiento"]),
        json["localidad"],
        json["idProvincia"],
        Provincia.fromJson(json["provincia"]),
        json["notaMedia"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "nombre": nombre,
        "apellidos": apellidos,
        "idCiclo": idCiclo,
        "ciclo": ciclo.toJson(),
        "fechaDeNacimiento": fechaDeNacimiento.toIso8601String(),
        "localidad": localidad,
        "idProvincia": idProvincia,
        "provincia": provincia.toJson(),
        "notaMedia": notaMedia,
    };
}
