// To parse this JSON data, do
//
//     final inscripcion = inscripcionFromJson(jsonString);

import 'dart:convert';

import 'package:ejerciciocomponentes/src/models/alumno.dart';
import 'package:ejerciciocomponentes/src/models/posicion.dart';

List<Inscripcion> inscripcionesFromJson(String str) => List<Inscripcion>.from(json.decode(str).map((x) => Inscripcion.fromJson(x)));
Inscripcion inscripcionFromJson(String str) => Inscripcion.fromJson(json.decode(str));
String inscripcionToJson(List<Inscripcion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Inscripcion {
    Inscripcion(

        this.alumnoId,
       
        this.empresaId,
       
        this.posicionId,
      
        this.estadoInscripcion,
        this.fechaInscripcion,{
this.id,
this.alumno,
this.empresa,
this.posicion,
        }
    );

    int? id;
    int alumnoId;
    Alumno? alumno;
    int empresaId;
    Empresa? empresa;
    int posicionId;
    Posicion? posicion;
    String estadoInscripcion;
    DateTime fechaInscripcion;
    
    factory Inscripcion.fromJson(Map<String, dynamic> json) => Inscripcion(
        
        json["alumnoId"],
        json["empresaId"],
        
        json["posicionId"],
        json["estadoInscripcion"],
        DateTime.parse(json["fechaInscripcion"]),
        id: (json["id"]),
       posicion: Posicion.fromJson(json["posicion"]),
       empresa: Empresa.fromJson(json["empresa"]),
       alumno: Alumno.fromJson(json["alumno"]),
    );

    Map<String, dynamic> toJson() => {
        "id":id,
        "alumnoId": alumnoId,
        "alumno": alumno!.toJson(),
        "empresaId": empresaId,
        "empresa": empresa!.toJson(),
        "posicionId": posicionId,
        "posicion": posicion!.toJson(),
        "estadoInscripcion": estadoInscripcion,
        "fechaInscripcion": fechaInscripcion.toIso8601String(),
    };
}
