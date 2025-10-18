import 'package:flutter/material.dart';

class UsernameField extends StatefulWidget {
  final Function(String) onNameChanged;

  const UsernameField({super.key, required this.onNameChanged});

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final TextEditingController _controller = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateName() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => errorMessage = "Username cannot be empty");
      return;
    }
    setState(() => errorMessage = null);
    widget.onNameChanged(text); // Only updates on button press
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: "Enter Username"),
            onChanged: (_) {
              if (errorMessage != null) {
                setState(() => errorMessage = null);
              }
            },
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _updateName,
            child: const Text("Update Name"),
          ),
        ],
      ),
    );
  }
}