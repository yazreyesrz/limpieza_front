import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:app_limpieza/features/auth/presentation/pages/login_page.dart';
import 'package:app_limpieza/features/auth/presentation/pages/register_page.dart';
import 'package:app_limpieza/features/task/presentation/pages/create_task_page.dart';
import 'package:app_limpieza/features/task/presentation/pages/bitacora_page.dart';
import 'package:app_limpieza/features/task/presentation/pages/active_tasks_page.dart';
import 'package:app_limpieza/features/home/presentation/pages/home_page.dart';

import 'package:app_limpieza/injection_container.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_cubit.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    GoRoute(
      path: '/crear-tarea',
      builder:
          (context, state) => BlocProvider.value(
            value: sl<TaskCubit>(),
            child: const CreateTaskPage(),
          ),
    ),
    GoRoute(
      path: '/bitacora',
      builder:
          (context, state) => BlocProvider.value(
            value: sl<TaskCubit>(),
            child: const BitacoraPage(),
          ),
    ),
    GoRoute(
      path: '/tareas-activas',
      builder:
          (context, state) => BlocProvider.value(
            value: sl<TaskCubit>(),
            child: const ActiveTasksPage(),
          ),
    ),
  ],
);
