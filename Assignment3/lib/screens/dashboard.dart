import 'package:flutter/material.dart';
import '../models/device.dart';
import '../widgets/device_card.dart';
import 'add_device.dart';
import 'device_detail.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Device> _devices = [
    Device(id: 'd1', name: 'Living Room Light', type: 'Light', room: 'Living'),
    Device(id: 'd2', name: 'Bedroom Fan', type: 'Fan', room: 'Bedroom'),
    Device(id: 'd3', name: 'Window AC', type: 'AC', room: 'Bedroom'),
    Device(id: 'd4', name: 'Front Door Camera', type: 'Camera', room: 'Entrance'),
  ];

  void _addDevice(Device device) {
    setState(() => _devices.add(device));
  }

  void _toggleDevice(String id, bool value) {
    setState(() {
      final d = _devices.firstWhere((e) => e.id == id);
      d.isOn = value;
    });
  }

  void _updateLevel(String id, double newLevel) {
    setState(() {
      final d = _devices.firstWhere((e) => e.id == id);
      d.level = newLevel;
    });
  }

  void _removeDevice(String id) {
    setState(() => _devices.removeWhere((d) => d.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width > 600 ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text('Smart Home Dashboard made by Sharaiz Ahmed [57288]'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/picture.jpg'),
              radius: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxis,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.95,
          ),
          itemCount: _devices.length,
          itemBuilder: (context, index) {
            final device = _devices[index];
            return Dismissible(
              key: Key(device.id),
              background: Container(color: Colors.redAccent, child: const Center(child: Text('Delete', style: TextStyle(color: Colors.white)))),
              onDismissed: (_) => _removeDevice(device.id),
              child: DeviceCard(
                device: device,
                onToggle: (v) => _toggleDevice(device.id, v),
                onTap: () async {
                  final result = await Navigator.push<Device?>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DeviceDetailScreen(
                        device: device,
                        onLevelChanged: (val) => _updateLevel(device.id, val),
                        onPowerChanged: (val) => _toggleDevice(device.id, val),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newDevice = await Navigator.push<Device?>(
            context,
            MaterialPageRoute(builder: (_) => const AddDeviceScreen()),
          );

          if (newDevice != null) {
            _addDevice(newDevice);
          }
        },
      ),
    );
  }
}
