import 'package:flutter/material.dart';

class Device {
  final String id;
  String name;
  String type;
  String room;
  bool isOn;
  double level;

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.level = 50.0,
  });

  IconData getIcon() {
    switch (type) {
      case 'Light':
        return Icons.lightbulb;
      case 'Fan':
        return Icons.toys;
      case 'AC':
        return Icons.ac_unit;
      case 'Camera':
        return Icons.videocam;
      default:
        return Icons.device_hub;
    }
  }
}
