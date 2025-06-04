class TaskEntity {
  final String id;
  final String descripcion;
  final String categoria;
  final bool completada;

  TaskEntity({
    required this.id,
    required this.descripcion,
    required this.categoria,
    required this.completada,
  });
}
