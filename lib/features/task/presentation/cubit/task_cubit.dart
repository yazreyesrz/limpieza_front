import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_limpieza/features/task/domain/usecases/task_usecases.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskUseCases useCases;

  TaskCubit(this.useCases) : super(TaskInitial());

  Future<void> cargarTareasPendientes() async {
    emit(TaskLoading());
    try {
      final tareas = await useCases.getActiveTasks.call();
      emit(TaskLoaded(tareas));
    } catch (e) {
      emit(TaskError('Error al cargar tareas pendientes'));
    }
  }

  Future<void> cargarTareasCompletadas(String categoria) async {
    emit(TaskLoading());
    try {
      final tareas = await useCases.getCompletedTasksByCategory.call(categoria);
      emit(TaskLoaded(tareas));
    } catch (e) {
      emit(TaskError('Error al cargar tareas completadas'));
    }
  }

  Future<void> crearTarea(String descripcion, String categoria) async {
    emit(TaskLoading());
    try {
      await useCases.createTask.call(descripcion, categoria);
      await cargarTareasPendientes(); // Recargar después de crear
    } catch (e) {
      emit(TaskError('Error al crear tarea'));
    }
  }

  Future<void> completarTarea(String id) async {
    emit(TaskLoading());
    try {
      await useCases.completeTask.call(id);
      await cargarTareasPendientes();
    } catch (e) {
      emit(TaskError('Error al completar la tarea'));
    }
  }

  Future<void> eliminarTarea(String id) async {
    emit(TaskLoading());
    try {
      await useCases.deleteTask.call(id);
      await cargarTareasPendientes(); // Recargar después de eliminar
    } catch (e) {
      emit(TaskError('Error al eliminar tarea'));
    }
  }
}
