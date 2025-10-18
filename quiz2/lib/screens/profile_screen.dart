import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_buttons.dart';
import '../widgets/profile_description.dart';
import '../widgets/username_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Sharaiz Ahmed";

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final orientation = isPortrait ? "Portrait" : "Landscape";
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primary, scheme.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        // Soft gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.primaryContainer.withOpacity(0.35),
              scheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600), // nice on tablets
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    ProfileHeader(name: username),
                    const SizedBox(height: 16),
                    const ProfileButtons(),
                    const SizedBox(height: 16),
                    const ProfileDescription(),
                    const SizedBox(height: 16),
                    UsernameField(
                      onNameChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // Colorful orientation chip
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Chip(
                        key: ValueKey(orientation),
                        avatar: Icon(
                          isPortrait ? Icons.stay_current_portrait : Icons.stay_current_landscape,
                          color: scheme.onSecondaryContainer,
                        ),
                        backgroundColor: scheme.secondaryContainer,
                        label: Text(
                          "Orientation: $orientation",
                          style: TextStyle(color: scheme.onSecondaryContainer),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}