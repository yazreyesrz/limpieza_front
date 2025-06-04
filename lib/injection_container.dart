import 'package:get_it/get_it.dart';

// 📦 AUTH
import 'package:app_limpieza/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app_limpieza/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:app_limpieza/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_limpieza/features/auth/domain/usecases/login_user.dart';
import 'package:app_limpieza/features/auth/domain/usecases/register_user.dart';
import 'package:app_limpieza/features/auth/presentation/cubit/auth_cubit.dart';

// 📦 TASKS
import 'package:app_limpieza/features/task/data/datasources/task_remote_datasource.dart';
import 'package:app_limpieza/features/task/data/repositories_impl/task_repository_impl.dart';
import 'package:app_limpieza/features/task/domain/repositories/task_repository.dart';
import 'package:app_limpieza/features/task/domain/usecases/create_task.dart';
import 'package:app_limpieza/features/task/domain/usecases/delete_task.dart';
import 'package:app_limpieza/features/task/domain/usecases/get_active_tasks.dart';
import 'package:app_limpieza/features/task/domain/usecases/get_completed_tasks_by_category.dart';
import 'package:app_limpieza/features/task/domain/usecases/complete_task.dart';
import 'package:app_limpieza/features/task/domain/usecases/task_usecases.dart';
import 'package:app_limpieza/features/task/presentation/cubit/task_cubit.dart';

final sl = GetIt.instance;

void init() {
  // AUTH
  sl.registerFactory(() => AuthCubit(loginUser: sl(), registerUser: sl()));

  sl.registerLazySingleton(() => AuthRemoteDatasource());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // TASKS
  sl.registerFactory(() => TaskCubit(sl()));
  sl.registerLazySingleton(() => TaskRemoteDatasource());
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  sl.registerLazySingleton(
    () => TaskUseCases(
      createTask: CreateTask(sl()),
      deleteTask: DeleteTask(sl()),
      getActiveTasks: GetActiveTasks(sl()),
      getCompletedTasksByCategory: GetCompletedTasksByCategory(sl()),
      completeTask: CompleteTask(sl()),
    ),
  );
}
