import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetActiveTasks {
  final TaskRepository repository;
  GetActiveTasks(this.repository);

  Future<List<TaskEntity>> call() {
    return repository.getActiveTasks();
  }
}
