import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'capture_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartTracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Top card with short description
              Card(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              cs.primary,
                              cs.primaryContainer,
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to SmartTracker',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Track your location, capture activities, and keep your history synced.',
                              style: TextStyle(
                                fontSize: 13,
                                color: cs.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Main action buttons
              _HomeButton(
                icon: Icons.map_outlined,
                label: 'Live Location Tracking',
                subtitle: 'See your real-time position on the map',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _HomeButton(
                icon: Icons.camera_alt_outlined,
                label: 'Capture Activity',
                subtitle: 'Take a photo and log your current spot',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CaptureScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _HomeButton(
                icon: Icons.history,
                label: 'Activity History',
                subtitle: 'Review and manage your past activities',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                ),
              ),

              const Spacer(),

              // Footer credit
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    thickness: 0.6,
                    color: cs.primary.withOpacity(0.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Made by Sharaiz Ahmed (SAP: 57288)',
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onSurface.withOpacity(0.65),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Student of BSCS 5-1, Mobile Application Development',
                    style: TextStyle(
                      fontSize: 11,
                      color: cs.onSurface.withOpacity(0.55),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      cs.primary,
                      cs.secondary,
                    ],
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurface.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: cs.primary.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
