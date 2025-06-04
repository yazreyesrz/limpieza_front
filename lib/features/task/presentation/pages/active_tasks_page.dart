import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_cubit.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_state.dart';
import 'package:app_limpieza/features/task/presentation/widgets/task_card.dart';

class ActiveTasksPage extends StatefulWidget {
  const ActiveTasksPage({super.key});

  @override
  State<ActiveTasksPage> createState() => _ActiveTasksPageState();
}

class _ActiveTasksPageState extends State<ActiveTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().cargarTareasPendientes();
  }

  @override
  Widget build(BuildContext context) {
    final azul = Colors.blue[800];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: azul,
        title: const Text(
          'Tareas Activas',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskError) {
            return Center(
              child: Text(
                'Error: ${state.mensaje}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is TaskLoaded) {
            final tareas = state.tareas.where((t) => !t.completada).toList();
            if (tareas.isEmpty) {
              return const Center(
                child: Text(
                  'No hay tareas activas.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return TaskCard(
                  tarea: tarea,
                  onComplete:
                      () => context.read<TaskCubit>().completarTarea(tarea.id),
                  onDelete:
                      () => context.read<TaskCubit>().eliminarTarea(tarea.id),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
