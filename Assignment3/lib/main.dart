import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'themes/theme.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Dashboard made by Sharaiz Ahmed [57288]',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}