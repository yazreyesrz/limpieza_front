import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String correo, String contrasena);
  Future<UserEntity> register(String nombre, String correo, String contrasena);
}
