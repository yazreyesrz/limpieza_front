import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_cubit.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_state.dart';
import 'package:app_limpieza/features/task/presentation/widgets/task_card.dart';

class BitacoraPage extends StatefulWidget {
  const BitacoraPage({super.key});

  @override
  State<BitacoraPage> createState() => _BitacoraPageState();
}

class _BitacoraPageState extends State<BitacoraPage> {
  String _categoria = 'Cocina';

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().cargarTareasCompletadas(_capitalize(_categoria));
  }

  @override
  Widget build(BuildContext context) {
    final azul = Colors.blue[800];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: azul,
        title: const Text(
          'Bitácora de Tareas',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Filtrar por categoría',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: DropdownButton<String>(
                value: _categoria,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                underline: const SizedBox(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _categoria = value);
                    context.read<TaskCubit>().cargarTareasCompletadas(
                      _capitalize(_categoria),
                    );
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'Cocina', child: Text('Cocina')),
                  DropdownMenuItem(value: 'Sala', child: Text('Sala')),
                  DropdownMenuItem(value: 'Baño', child: Text('Baño')),
                  DropdownMenuItem(value: 'Otros', child: Text('Otros')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
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
                    final tareas =
                        state.tareas.where((t) => t.completada).toList();
                    if (tareas.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hay tareas completadas.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = tareas[index];
                        return TaskCard(
                          tarea: tarea,
                          onComplete: () {}, // Ya está completada
                          onDelete:
                              () => context.read<TaskCubit>().eliminarTarea(
                                tarea.id,
                              ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
