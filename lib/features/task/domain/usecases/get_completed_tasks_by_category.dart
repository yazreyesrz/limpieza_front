import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetCompletedTasksByCategory {
  final TaskRepository repository;
  GetCompletedTasksByCategory(this.repository);

  Future<List<TaskEntity>> call(String categoria) {
    return repository.getCompletedTasksByCategory(categoria);
  }
}
