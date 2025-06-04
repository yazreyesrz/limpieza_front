import 'package:app_limpieza/features/task/domain/usecases/create_task.dart';
import 'package:app_limpieza/features/task/domain/usecases/delete_task.dart';
import 'package:app_limpieza/features/task/domain/usecases/get_active_tasks.dart';
import 'package:app_limpieza/features/task/domain/usecases/get_completed_tasks_by_category.dart';
import 'package:app_limpieza/features/task/domain/usecases/complete_task.dart';

class TaskUseCases {
  final CreateTask createTask;
  final DeleteTask deleteTask;
  final GetActiveTasks getActiveTasks;
  final GetCompletedTasksByCategory getCompletedTasksByCategory;
  final CompleteTask completeTask;

  TaskUseCases({
    required this.createTask,
    required this.deleteTask,
    required this.getActiveTasks,
    required this.getCompletedTasksByCategory,
    required this.completeTask,
  });
}
