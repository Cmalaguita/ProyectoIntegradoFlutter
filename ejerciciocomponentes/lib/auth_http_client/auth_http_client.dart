import 'package:ejerciciocomponentes/src/services/storage_service.dart';
import 'package:http/http.dart' as http;

class AuthHttpClient extends http.BaseClient {
  final StorageService storageService = StorageService();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = 'Bearer ' + await storageService.read('authorization');
    if (token.isNotEmpty) {
      request.headers.putIfAbsent('authorization', () => token);
    }

    return request.send();
  }
}
