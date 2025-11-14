import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceDetailScreen extends StatefulWidget {
  final Device device;
  final ValueChanged<double> onLevelChanged;
  final ValueChanged<bool> onPowerChanged;

  const DeviceDetailScreen({super.key, required this.device, required this.onLevelChanged, required this.onPowerChanged});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late double _level;
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _level = widget.device.level;
    _isOn = widget.device.isOn;
  }

  @override
  Widget build(BuildContext context) {
    final isAdjustable = widget.device.type == 'Light' || widget.device.type == 'Fan';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(widget.device.getIcon(), size: 120),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_isOn ? 'Status: ON' : 'Status: OFF', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: 20),
                Switch(
                  value: _isOn,
                  onChanged: (v) {
                    setState(() => _isOn = v);
                    widget.onPowerChanged(v);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (isAdjustable) ...[
              Text(isAdjustable ? 'Adjust ${widget.device.type} Level' : '', style: Theme.of(context).textTheme.bodyLarge),
              Slider(
                value: _level,
                min: 0,
                max: 100,
                divisions: 20,
                label: _level.round().toString(),
                onChanged: (v) {
                  setState(() => _level = v);
                  widget.onLevelChanged(v);
                },
              ),
              const SizedBox(height: 8),
              Text('Level: ${_level.round()}%', style: Theme.of(context).textTheme.bodyMedium),
            ],

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
