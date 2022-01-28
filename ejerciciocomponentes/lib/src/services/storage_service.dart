import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = const FlutterSecureStorage();

  Future<dynamic> read(String key) async {
    var datos = await storage.read(key: key);
    return datos;
  }

  add(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
