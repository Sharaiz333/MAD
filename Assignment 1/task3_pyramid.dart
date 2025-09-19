import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Pyramid',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PyramidPage(),
    );
  }
}

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final TextEditingController nController = TextEditingController();
  String patternResult = "";

  /// ✅ Generate pyramid pattern
  void generatePattern() {
    int? n = int.tryParse(nController.text);
    if (n == null || n <= 0) {
      setState(() {
        patternResult = "Please enter a valid positive number!";
      });
      return;
    }

    StringBuffer buffer = StringBuffer();

    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= i; j++) {
        buffer.write("$j ");
      }
      buffer.writeln();
    }

    setState(() {
      patternResult = buffer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 3: Number Pyramid 57288")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nController,
              decoration: const InputDecoration(
                labelText: "Enter n",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: generatePattern,
              child: const Text("Generate Pyramid"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  patternResult,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
