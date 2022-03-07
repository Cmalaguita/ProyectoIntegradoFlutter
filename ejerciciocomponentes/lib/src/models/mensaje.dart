// To parse this JSON data, do
//
//     final mensaje = mensajeFromJson(jsonString);

import 'dart:convert';

Mensaje mensajeFromJson(String str) => Mensaje.fromJson(json.decode(str));
List<Mensaje> mensajesFromJson(String str) => List<Mensaje>.from(json.decode(str).map((x) => Mensaje.fromJson(x)));
String mensajeToJson(Mensaje data) => json.encode(data.toJson());

class Mensaje {
    Mensaje(
        this.id,
        this.alumnoId,
        this.empresaId,
        this.contenido,
        this.leido,
    );

    int id;
    int alumnoId;
    int empresaId;
    String contenido;
    bool leido;

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(

         json["id"],
         json["alumnoId"],
         json["empresaId"],
         json["contenido"],
         json["leido"],

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "alumnoId": alumnoId,
        "empresaId": empresaId,
        "contenido": contenido,
        "leido": leido,
    };
}
