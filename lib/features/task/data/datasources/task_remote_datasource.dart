import 'dart:convert';
import 'package:app_limpieza/features/task/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/api_constants.dart';

class TaskRemoteDatasource {
  final storage = FlutterSecureStorage();

  Future<void> createTask(TaskModel task) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks');

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(task.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception(json.decode(res.body)['msg'] ?? 'Error al crear tarea');
    }
  }

  Future<void> deleteTask(String id) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks/$id');

    final res = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode != 200) {
      throw Exception(
        json.decode(res.body)['msg'] ?? 'Error al eliminar tarea',
      );
    }
  }

  Future<List<TaskModel>> getActiveTasks() async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse('${ApiConstants.baseUrl}/tasks/pendientes');

    final res = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode == 200) {
      final List decoded = json.decode(res.body);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener tareas activas');
    }
  }

  Future<List<TaskModel>> getCompletedTasksByCategory(String categoria) async {
    final token = await storage.read(key: 'token');
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/tasks/completadas/$categoria',
    );

    final res = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode == 200) {
      final List decoded = json.decode(res.body);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener tareas completadas');
    }
  }
}
