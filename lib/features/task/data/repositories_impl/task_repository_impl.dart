import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_limpieza/core/constants/api_constants.dart';
import 'package:app_limpieza/features/task/domain/entities/task_entity.dart';
import 'package:app_limpieza/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final storage = const FlutterSecureStorage();

  Future<String?> _getToken() async => await storage.read(key: 'token');

  @override
  Future<void> createTask(String descripcion, String categoria) async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks');
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'descripcion': descripcion, 'categoria': categoria}),
    );
    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['msg']);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks/$id');
    final res = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['msg']);
    }
  }

  @override
  Future<List<TaskEntity>> getActiveTasks() async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks/pendientes');
    final res = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['msg']);
    }
    final List data = jsonDecode(res.body);
    return data
        .map(
          (e) => TaskEntity(
            id: e['_id'],
            descripcion: e['descripcion'],
            categoria: e['categoria'],
            completada: false,
          ),
        )
        .toList();
  }

  @override
  Future<void> completeTask(String id) async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks/$id/complete');
    final res = await http.patch(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode != 200) {
      throw Exception(
        jsonDecode(res.body)['msg'] ?? 'Error al completar tarea',
      );
    }
  }

  @override
  Future<List<TaskEntity>> getCompletedTasksByCategory(String categoria) async {
    final token = await _getToken();
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/tasks/completadas/$categoria',
    );
    final res = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)['msg']);
    }
    final List data = jsonDecode(res.body);
    return data
        .map(
          (e) => TaskEntity(
            id: e['_id'],
            descripcion: e['descripcion'],
            categoria: e['categoria'],
            completada: e['completada'] ?? true,
          ),
        )
        .toList();
  }
}
