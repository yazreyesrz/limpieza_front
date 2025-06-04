import 'package:equatable/equatable.dart';
import 'package:app_limpieza/features/task/domain/entities/task_entity.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tareas;

  const TaskLoaded(this.tareas);

  @override
  List<Object?> get props => [tareas];
}

class TaskError extends TaskState {
  final String mensaje;

  const TaskError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
