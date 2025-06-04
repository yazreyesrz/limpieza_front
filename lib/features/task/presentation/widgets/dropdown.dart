import 'package:flutter/material.dart';

class CategoriaDropdown extends StatelessWidget {
  final List<String> categorias;
  final String? value;
  final void Function(String?) onChanged;

  const CategoriaDropdown({
    super.key,
    required this.categorias,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(
        labelText: 'Categoría',
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(),
      ),
      items:
          categorias
              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
              .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Seleccione una categoría' : null,
    );
  }
}
