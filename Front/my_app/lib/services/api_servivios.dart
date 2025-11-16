import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio dio;
  final _storage = FlutterSecureStorage();
  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'http://172.20.10.11:8000', // ipconfig
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<List<dynamic>> getUsuarios() async {
    try {
      final response = await dio.get('/usuarios');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error en la respuesta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  Future<bool> postUsuario(
    String nombre,
    String documento,
    String email,
    String telefono,
    String password,
  ) async {
    try {
      final response = await dio.post(
        '/usuario/registrar',
        data: {
          'nombre_completo': nombre,
          'documento': documento,
          'email': email,
          'telefono': telefono,
          'password': password,
        },
      );
      print('Respuesta: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    }
  }

  Future<bool> testConnection() async {
    try {
      final response = await dio.get('/');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/usuario/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data is Map
            ? response.data
            : Map<String, dynamic>.from(response.data);
        if (data['Usuario'] != null) {
          if (data["Usuario_id"] != null) {
            _storage.write(key: "usuario_id", value: data["Usuario_id"]);
            return true;
          }
        }
      }

      return false;
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> reservarCancha(
    int canchaId,
    String fecha,
    String horaInicio,
    String horaFin,
  ) async {
    try {
      final idUsuario = await _storage.read(key: "usuario_id");
      final response = await dio.post(
        'POST  /reservas/crear',
        data: {
          "usuario_id": int.parse(idUsuario!),
          "cancha_id": canchaId,
          "fecha": fecha,
          "hora_inicio": horaInicio,
          "hora_fin": horaFin,
        },
      );
      if (response.statusCode != 200) return false;
      return true;
    } catch (_) {
      return false;
    }
  }
}
