import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_cubit.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_state.dart';
import 'package:app_limpieza/features/task/presentation/widgets/task_form.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  String? _categoriaSeleccionada;

  @override
  void dispose() {
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          'Crear nueva tarea',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('❌ ${state.mensaje}')));
          } else if (state is TaskLoaded) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('✅ Tarea creada')));
            _descripcionController.clear();
            setState(() => _categoriaSeleccionada = null);
            context.go('/home');
          }
        },
        builder: (context, state) {
          return Center(
            child: TaskForm(
              formKey: _formKey,
              descripcionController: _descripcionController,
              categoriaSeleccionada: _categoriaSeleccionada,
              onCategoriaChanged: (value) {
                setState(() {
                  _categoriaSeleccionada = value;
                });
              },
              isLoading: state is TaskLoading,
              onSubmit: () {
                if (_formKey.currentState!.validate()) {
                  context.read<TaskCubit>().crearTarea(
                    _descripcionController.text,
                    _categoriaSeleccionada!,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
