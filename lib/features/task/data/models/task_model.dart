import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final String? completadaPor;
  final DateTime fecha;

  TaskModel({
    required super.id,
    required super.descripcion,
    required super.categoria,
    required super.completada,
    this.completadaPor,
    required this.fecha,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] ?? '',
      descripcion: json['descripcion'] ?? '',
      categoria: json['categoria'] ?? '',
      completada: json['completada'] ?? false,
      completadaPor:
          json['completadaPor'] is Map
              ? json['completadaPor']['nombre']
              : json['completadaPor'],
      fecha: DateTime.tryParse(json['fecha'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'descripcion': descripcion, 'categoria': categoria};
  }
}
