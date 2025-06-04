import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_limpieza/shared/widgets/card_container.dart';
import 'package:app_limpieza/shared/widgets/central_title.dart';
import 'package:app_limpieza/shared/widgets/main_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A66C2),
        title: const Text(
          'Bitácora de Limpieza',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: CardContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CentralTitle(
                icon: Icons.home,
                text: '¡Bienvenido!',
                subtitle: 'Selecciona una acción para continuar:',
              ),
              const SizedBox(height: 16),
              MainButton(
                label: 'Crear nueva tarea',
                icon: Icons.add_circle_outline,
                onPressed: () => context.push('/crear-tarea'),
              ),
              const SizedBox(height: 12),
              MainButton(
                label: 'Ver bitácora de tareas',
                icon: Icons.list_alt_outlined,
                color: Colors.blueGrey,
                onPressed: () => context.push('/bitacora'),
              ),
              const SizedBox(height: 12),
              MainButton(
                label: 'Ver tareas activas',
                icon: Icons.pending_actions_outlined,
                color: Colors.green,
                onPressed: () => context.push('/tareas-activas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
