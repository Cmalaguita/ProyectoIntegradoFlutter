import 'dart:convert';

List<TipoCiclo> tipoCicloFromJson(String str) => List<TipoCiclo>.from(json.decode(str).map((x) => TipoCiclo.fromJson(x)));
String tipoCicloToJson(List<TipoCiclo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class TipoCiclo{

    TipoCiclo(
        this.id,
        this.nombre,
    );

    int id;
    String nombre;

    factory TipoCiclo.fromJson(Map<String, dynamic> json) => TipoCiclo(
      json["id"],
      json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}