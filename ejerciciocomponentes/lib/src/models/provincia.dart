// To parse this JSON data, do
//
//     final provincia = provinciaFromJson(jsonString);

import 'dart:convert';

List<Provincia> provinciaFromJson(String str) => List<Provincia>.from(json.decode(str).map((x) => Provincia.fromJson(x)));

String provinciaToJson(List<Provincia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Provincia loadProvincias(String str){
final jsonData= json.decode(str);
return Provincia.fromJson(jsonData);
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
