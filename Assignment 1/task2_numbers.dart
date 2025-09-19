
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
      title: "Assignment Task 2",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<int> numbers = [];
  String result = "";

  /// ✅ Add a number to the list
  void addNumber() {
    int? num = int.tryParse(numberController.text);
    if (num != null) {
      setState(() {
        numbers.add(num);
        numberController.clear();
      });
    }
  }

  /// ✅ Perform calculations
  void calculate() {
    String name = nameController.text.trim();
    int age = int.tryParse(ageController.text) ?? 0;

    // Age check
    if (age < 18) {
      setState(() {
        result = "Sorry $name, you are not eligible to register.";
      });
      return;
    }

    if (numbers.isEmpty) {
      setState(() {
        result = "Please add at least one number!";
      });
      return;
    }

    int sumEven = 0;
    int sumOdd = 0;
    int largest = numbers[0];
    int smallest = numbers[0];

    for (int num in numbers) {
      if (num % 2 == 0) {
        sumEven += num;
      } else {
        sumOdd += num;
      }

      if (num > largest) largest = num;
      if (num < smallest) smallest = num;
    }

    setState(() {
      result = """
Name: $name
Age: $age

Sum of Even Numbers: $sumEven
Sum of Odd Numbers: $sumOdd
Largest Number: $largest
Smallest Number: $smallest
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dart Input Example 57288")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input fields
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Enter a number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Buttons
            Row(
              children: [
                ElevatedButton(onPressed: addNumber, child: const Text("Add Number")),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: calculate, child: const Text("Calculate")),
              ],
            ),

            const SizedBox(height: 20),

            // Show numbers list
            if (numbers.isNotEmpty)
              Text("Numbers: ${numbers.join(", ")}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            const SizedBox(height: 20),

            // Show result
            Text(result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
