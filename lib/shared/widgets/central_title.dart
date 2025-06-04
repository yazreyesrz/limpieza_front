import 'package:flutter/material.dart';

class CentralTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subtitle;

  const CentralTitle({
    super.key,
    required this.icon,
    required this.text,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 48, color: const Color(0xFF0A66C2)),
        const SizedBox(height: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
