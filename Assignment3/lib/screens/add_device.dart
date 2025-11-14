import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/device.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _roomCtrl = TextEditingController();
  String _type = 'Light';
  bool _isOn = false;

  void _save() {
    if (_formKey.currentState!.validate()) {
      final id = const Uuid().v4();
      final device = Device(
        id: id,
        name: _nameCtrl.text,
        type: _type,
        room: _roomCtrl.text,
        isOn: _isOn,
      );
      Navigator.pop(context, device);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _roomCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Device')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (v) => (v == null || v.isEmpty) ? 'Enter a name' : null,
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _type,
                items: ['Light', 'Fan', 'AC', 'Camera'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (v) => setState(() => _type = v ?? 'Light'),
                decoration: const InputDecoration(labelText: 'Device Type'),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _roomCtrl,
                decoration: const InputDecoration(labelText: 'Room Name'),
                validator: (v) => (v == null || v.isEmpty) ? 'Enter room' : null,
              ),

              const SizedBox(height: 12),

              SwitchListTile(
                title: const Text('Start as ON'),
                value: _isOn,
                onChanged: (v) => setState(() => _isOn = v),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: _save,
                child: const Text('Add Device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
