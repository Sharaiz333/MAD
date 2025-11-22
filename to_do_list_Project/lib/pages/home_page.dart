import 'package:flutter/material.dart';
import 'todo_list_page.dart';
import 'package:to_do_list_project/widgets/weather_widget.dart';  // Import your dynamic WeatherWidget here

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C3CB6),
        elevation: 0,
        title: _HeaderTitle(),
        centerTitle: true,
        iconTheme: const IconThemeData(size: 30, color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA06CD5), Color(0xFF667EEA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                const _CircleLogo(),
                const SizedBox(height: 36),
                const _WelcomeText(),
                const SizedBox(height: 32),
                WeatherWidget(),  // Replaced static _WeatherCard with dynamic WeatherWidget
                const SizedBox(height: 38),
                const _MainButton(),
                const SizedBox(height: 44),
                const _Footer(),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE2C5FF),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Color(0xFFA06CD5), Color(0xFF667EEA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/app_logo.png', height: 60),
                const SizedBox(height: 12),
                const Text(
                  'Riphahtasker',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your daily task companion app',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('To-Do List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ToDoListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Riphahtasker',
                applicationVersion: 'v1.0.0',
                children: const [
                  Text('Developed by Sharaiz Ahmed (SAP: 57288)'),
                  Text('Riphah International University'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Riphahtasker',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        letterSpacing: 0.3,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Colors.black12,
            offset: Offset(0, 2),
          )
        ],
      ),
    );
  }
}

class _CircleLogo extends StatelessWidget {
  const _CircleLogo();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 22,
      shape: const CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 54,
        child: Icon(
          Icons.check_circle_rounded,
          color: Color(0xFF6C3CB6),
          size: 80,
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Welcome to',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
            shadows: [
              Shadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 3)),
            ],
          ),
        ),
        Text(
          'RiphahTasker!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.06,
            shadows: [
              Shadow(blurRadius: 8, color: Colors.black12, offset: Offset(0, 3)),
            ],
          ),
        ),
        SizedBox(height: 13),
        Text(
          'Your daily task companion.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.13),
      borderRadius: BorderRadius.circular(22),
      elevation: 16,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.wb_sunny_rounded,
                color: Color(0xFFF6BE2C),
                size: 34,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Islamabad',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '18°C, Sunny',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MainButton extends StatelessWidget {
  const _MainButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF6A41A1),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ToDoListPage()),
        );
      },
      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
      label: const Text(
        'Go to To-Do List',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.4),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Sharaiz Ahmed',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17),
          ),
          TextSpan(
            text: '  •  BSCS Department\n',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Riphah International University',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
