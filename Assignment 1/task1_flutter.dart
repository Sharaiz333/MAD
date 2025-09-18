import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner
      home: MaximumBidPage(),
    );
  }
}

class MaximumBidPage extends StatefulWidget {
  const MaximumBidPage({super.key});

  @override
  State<MaximumBidPage> createState() => _MaximumBidPageState();
}

class _MaximumBidPageState extends State<MaximumBidPage> {
  int _bidAmount = 0; // starting bid

  void _increaseBid() {
    setState(() {
      _bidAmount = _bidAmount + 50; // increase bid by 50
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bidding Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Maximum Bid:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "\$$_bidAmount",
              style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increaseBid,
              child: const Text("Increase Bid by \$50"),
            ),
          ],
        ),
      ),
    );
  }
}
