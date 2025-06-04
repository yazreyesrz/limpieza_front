import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_limpieza/core/constants/api_constants.dart';
import 'package:app_limpieza/features/auth/data/models/user_model.dart';

class AuthRemoteDatasource {
  Future<UserModel> login(String correo, String contrasena) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/auth/login');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'correo': correo, 'contrasena': contrasena}),
    );

    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['msg']);
    }
  }

  Future<UserModel> register(
    String nombre,
    String correo,
    String contrasena,
  ) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/auth/register');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
      }),
    );

    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['msg']);
    }
  }
}
