import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:app_limpieza/features/auth/domain/usecases/login_user.dart';
import 'package:app_limpieza/features/auth/domain/usecases/register_user.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final storage = FlutterSecureStorage();
  final Logger _logger = Logger();

  AuthCubit({required this.loginUser, required this.registerUser})
    : super(AuthInitial());

  Future<void> login(String correo, String contrasena) async {
    emit(AuthLoading());
    try {
      final user = await loginUser.call(correo, contrasena);
      _logger.d('🔐 Token recibido: ${user.token}');
      await storage.write(key: 'token', value: user.token);
      final savedToken = await storage.read(key: 'token');
      _logger.i('📦 Token guardado en storage: $savedToken');
      emit(AuthSuccess(user));
    } catch (e) {
      _logger.e('❌ Error en login: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String nombre, String correo, String contrasena) async {
    emit(AuthLoading());
    try {
      final user = await registerUser.call(nombre, correo, contrasena);
      _logger.d('🙋 Usuario registrado: ${user.nombre}');
      await storage.write(key: 'token', value: user.token);
      emit(AuthSuccess(user));
    } catch (e) {
      _logger.e('❌ Error en registro: $e');
      emit(AuthError(e.toString()));
    }
  }
}
