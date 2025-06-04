import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> createTask(String descripcion, String categoria);
  Future<List<TaskEntity>> getActiveTasks();
  Future<List<TaskEntity>> getCompletedTasksByCategory(String categoria);
  Future<void> deleteTask(String id);
  Future<void> completeTask(String id);
}
