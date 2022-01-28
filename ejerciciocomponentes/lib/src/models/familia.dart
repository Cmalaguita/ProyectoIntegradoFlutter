import 'dart:convert';

List<Familia> familiaFromJson(String str) =>
    List<Familia>.from(json.decode(str).map((x) => Familia.fromJson(x)));
String familiaToJson(List<Familia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Familia {
  Familia(
    this.id,
    this.nombre,
  );

  int id;
  String nombre;

  factory Familia.fromJson(Map<String, dynamic> json) => Familia(
        json["id"],
        json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
