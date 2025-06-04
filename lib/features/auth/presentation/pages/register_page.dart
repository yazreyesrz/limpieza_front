import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app_limpieza/core/constants/api_constants.dart';
import 'package:app_limpieza/shared/widgets/card_container.dart';
import 'package:app_limpieza/shared/widgets/central_title.dart';
import 'package:app_limpieza/shared/widgets/main_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  bool loading = false;

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    final url = Uri.parse('${ApiConstants.baseUrl}/auth/register');

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': _nombreController.text,
          'correo': _correoController.text,
          'contrasena': _contrasenaController.text,
        }),
      );

      if (!mounted) return;

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('✅ Usuario registrado')));
        context.go('/');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${res.body}')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Excepción: $e')));
    }

    if (!mounted) return;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A66C2),
        title: const Text("Registro", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: CardContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CentralTitle(icon: Icons.person_add, text: 'Registro'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator:
                            (value) =>
                                value != null && value.isNotEmpty
                                    ? null
                                    : 'Requerido',
                      ),
                      const SizedBox(height: 16),
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
                loading
                    ? const CircularProgressIndicator()
                    : MainButton(
                      label: 'Registrarme',
                      icon: Icons.check,
                      onPressed: _registrar,
                    ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text("¿Ya tienes cuenta? Inicia sesión"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
