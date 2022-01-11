// To parse this JSON data, do
//
//     final ciclo = cicloFromJson(jsonString);

import 'dart:convert';

import 'familia.dart';
import 'tipociclo.dart';


List<Ciclo> cicloFromJson(String str) => List<Ciclo>.from(json.decode(str).map((x) => Ciclo.fromJson(x)));
String cicloToJson(List<Ciclo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



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
    TipoCiclo tipociclo;
    int idFamilia;
    Familia familia;

    factory Ciclo.fromJson(Map<String, dynamic> json) => Ciclo(
        json["id"],
        json["nombre"],
        json["idTipo"],
        TipoCiclo.fromJson(json["tipociclo"]),
        json["idFamilia"],
        Familia.fromJson(json["familia"]),
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



