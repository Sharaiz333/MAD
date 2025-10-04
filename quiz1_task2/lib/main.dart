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
      title: "List & Conditions Example",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NumberInputPage(),
    );
  }
}

class NumberInputPage extends StatefulWidget {
  const NumberInputPage({super.key});

  @override
  State<NumberInputPage> createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  final List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());

  String result = "";

  void calculateResults() {
    List<int> numbers = [];

    for (var controller in controllers) {
      int? value = int.tryParse(controller.text);
      if (value != null) {
        numbers.add(value);
      }
    }

    if (numbers.length < 6) {
      setState(() {
        result = "⚠️ Please enter all 6 integers!";
      });
      return;
    }

    int sumOfOdd = 0;
    for (int num in numbers) {
      if (num % 2 != 0) {
        sumOfOdd += num;
      }
    }

    int smallest = numbers[0];
    for (int num in numbers) {
      if (num < smallest) {
        smallest = num;
      }
    }

    setState(() {
      result = "Numbers: $numbers\n"
          "Sum of odd numbers: $sumOfOdd\n"
          "Smallest number: $smallest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List & Conditions Example by Sharaiz[57288]")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Sharaiz[57288] App to Enter 6 integers:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            for (int i = 0; i < 6; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: controllers[i],
                  decoration: InputDecoration(
                    labelText: "Number ${i + 1}",
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: calculateResults,
              child: const Text("Calculate"),
            ),

            const SizedBox(height: 15),

            // Show results
            Text(
              result,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
