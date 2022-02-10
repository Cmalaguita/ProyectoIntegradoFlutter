import 'package:ejerciciocomponentes/src/models/familia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FamiliaService {
  Future<List<Familia>> cargarTodasLasFamilias() async {
    final response = await http.get(Uri.parse(
        'http://vps-697f2832.vps.ovh.net/api/FamiliaProfesional/Obtener_Todas_Las_Familias_Profesionales'));
    if (response.statusCode == 200) {
      return familiaFromJson(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
