import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:app_limpieza/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_limpieza/features/auth/presentation/cubit/auth_state.dart';

import 'package:app_limpieza/shared/widgets/card_container.dart';
import 'package:app_limpieza/shared/widgets/central_title.dart';
import 'package:app_limpieza/shared/widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A66C2),
        title: const Text(
          "Iniciar sesión",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: CardContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CentralTitle(icon: Icons.lock, text: 'Iniciar sesión'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _correoController,
                        decoration: const InputDecoration(
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator:
                            (value) =>
                                value != null && value.contains('@')
                                    ? null
                                    : 'Correo inválido',
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _contrasenaController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator:
                            (value) =>
                                value != null && value.length >= 6
                                    ? null
                                    : 'Mínimo 6 caracteres',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      context.go('/home');
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('❌ ${state.message}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }

                    return MainButton(
                      label: 'Ingresar',
                      icon: Icons.login,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            _correoController.text,
                            _contrasenaController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text("¿No tienes cuenta? Regístrate"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
