import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_add_alt_1),
          label: const Text("Follow"),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.message_outlined),
          label: const Text("Message"),
        ),
      ],
    );
  }
}