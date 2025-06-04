import '../repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;
  CreateTask(this.repository);

  Future<void> call(String descripcion, String categoria) {
    return repository.createTask(descripcion, categoria);
  }
}
