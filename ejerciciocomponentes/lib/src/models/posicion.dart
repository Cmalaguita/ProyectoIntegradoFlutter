// To parse this JSON data, do
//
//     final posicion = posicionFromJson(jsonString);

import 'dart:convert';

Posicion posicionFromJson(String str) => Posicion.fromJson(json.decode(str));
List<Posicion> posicionesFromJson(String str) => List<Posicion>.from(json.decode(str).map((x) => Posicion.fromJson(x)));

String posicionToJson(Posicion data) => json.encode(data.toJson());

class Posicion {
    Posicion(
        this.fechaInicio,
        this.fechaFin,
        this.id,
        this.empresaId,
        this.empresa,
        this.ciclos,
        this.nombre,
        this.descripcion,
        this.horario,
        this.remuneracion,
    );

    DateTime fechaInicio;
    DateTime fechaFin;
    int id;
    int empresaId;
    Empresa empresa;
    List<Ciclo> ciclos;
    String nombre;
    String descripcion;
    String horario;
    int remuneracion;

    factory Posicion.fromJson(Map<String, dynamic> json) => Posicion(
       DateTime.parse(json["fechaInicio"]),
       DateTime.parse(json["fechaFin"]),
       json["id"],
       json["empresaId"],
       Empresa.fromJson(json["empresa"]),
       List<Ciclo>.from(json["ciclos"].map((x) => Ciclo.fromJson(x))),
       json["nombre"],
       json["descripcion"],
       json["horario"],
       json["remuneracion"],
    );

    Map<String, dynamic> toJson() => {
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFin": fechaFin.toIso8601String(),
        "id": id,
        "empresaId": empresaId,
        "empresa": empresa.toJson(),
        "ciclos": List<dynamic>.from(ciclos.map((x) => x.toJson())),
        "nombre": nombre,
        "descripcion": descripcion,
        "horario": horario,
        "remuneracion": remuneracion,
    };
}

class Ciclo {
    Ciclo(
        this.id,
        this.nombre,
        this.idTipo,
        this.tipociclo,
        this.idFamilia,
        this.familia,
    );

    int id;
    String nombre;
    int idTipo;
    Provincia tipociclo;
    int idFamilia;
    Provincia familia;

    factory Ciclo.fromJson(Map<String, dynamic> json) => Ciclo(
        json["id"],
        json["nombre"],
        json["idTipo"],
        Provincia.fromJson(json["tipociclo"]),
        json["idFamilia"],
         Provincia.fromJson(json["familia"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "idTipo": idTipo,
        "tipociclo": tipociclo.toJson(),
        "idFamilia": idFamilia,
        "familia": familia.toJson(),
    };
}

class Provincia {
    Provincia(
        this.id,
        this.nombre,
    );

    int id;
    String nombre;

    factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
       json["id"],
       json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}

class Empresa {
    Empresa(
        this.id,
        this.email,
        this.password,
        this.nombre,
        this.provinciaId,
        this.provincia,
        this.localidad,
        this.direccion,
    );

    int id;
    String email;
    String? password;
    String nombre;
    int provinciaId;
    Provincia provincia;
    String localidad;
    String direccion;

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
       json["id"],
       json["email"],
       json["password"],
       json["nombre"],
       json["provinciaId"],
       Provincia.fromJson(json["provincia"]),
       json["localidad"],
       json["direccion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "nombre": nombre,
        "provinciaId": provinciaId,
        "provincia": provincia.toJson(),
        "localidad": localidad,
        "direccion": direccion,
    };
}
