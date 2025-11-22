import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYwSp2CayXOuZDNLePQoTOmghzpl6raoY" ,
      appId: "1:527982266770:android:61c1baec3c6fb74ea0994b",
      messagingSenderId: "527982266770",
      projectId: "riphahtasker",
    ),
  );
  runApp(const RiphahtaskerApp());
}

class RiphahtaskerApp extends StatelessWidget {
  const RiphahtaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riphahtasker — your daily task companion by Riphah International University',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
