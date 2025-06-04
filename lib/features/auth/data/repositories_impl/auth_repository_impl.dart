import 'package:app_limpieza/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app_limpieza/features/auth/domain/entities/user_entity.dart';
import 'package:app_limpieza/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<UserEntity> login(String correo, String contrasena) async {
    final userModel = await remoteDatasource.login(correo, contrasena);
    return UserEntity(nombre: userModel.nombre, token: userModel.token);
  }

  @override
  Future<UserEntity> register(
    String nombre,
    String correo,
    String contrasena,
  ) async {
    final userModel = await remoteDatasource.register(
      nombre,
      correo,
      contrasena,
    );
    return UserEntity(nombre: userModel.nombre, token: userModel.token);
  }
}
