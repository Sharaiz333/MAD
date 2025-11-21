import 'package:flutter/material.dart';

class EditTaskDialog extends StatefulWidget {
  final String initialTitle;
  final String initialDesc;
  final Function(String, String) onSave;
  final Color backgroundColor;

  const EditTaskDialog({
    super.key,
    required this.initialTitle,
    required this.initialDesc,
    required this.onSave,
    this.backgroundColor = const Color(0xFFB39DDB),
  });

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late final TextEditingController titleController =
  TextEditingController(text: widget.initialTitle);
  late final TextEditingController descController =
  TextEditingController(text: widget.initialDesc);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Edit Task', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descController,
            decoration: const InputDecoration(
              labelText: 'Task Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.deepPurple.shade400, width: 1.5),
            foregroundColor: Colors.deepPurple.shade700,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade300,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            widget.onSave(titleController.text, descController.text);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
