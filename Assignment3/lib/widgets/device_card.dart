import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceCard extends StatefulWidget {
  final Device device;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTap;

  const DeviceCard({super.key, required this.device, required this.onToggle, required this.onTap});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> with SingleTickerProviderStateMixin {

  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.97);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final device = widget.device;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(device.getIcon(), size: 32),
                    Switch(
                      value: device.isOn,
                      onChanged: widget.onToggle,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(device.name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text('${device.room} • ${device.type}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),

                // Current status text
                Text(
                  device.isOn ? '${device.type} is ON' : '${device.type} is OFF',
                  style: TextStyle(color: device.isOn ? Colors.green : Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
