import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final VoidCallback onAdd;
  final Color backgroundColor;

  const AddTaskDialog({
    super.key,
    required this.titleController,
    required this.descController,
    required this.onAdd,
    this.backgroundColor = const Color(0xFFB39DDB),
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Add New Task', style: TextStyle(fontWeight: FontWeight.bold)),
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
          onPressed: onAdd,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
