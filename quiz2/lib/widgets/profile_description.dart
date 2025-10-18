import 'package:flutter/material.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.secondaryContainer,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "👨‍💻 Flutter dev‑in‑progress | 🎨 UI/UX fan | 🚀 Building, learning, sharing"
          "🌱 Learning Flutter daily | 🔧 Dart + Firebase | 🤝 Happy to collaborate",
          style: TextStyle(color: scheme.onSecondaryContainer),
        ),
      ),
    );
  }
}