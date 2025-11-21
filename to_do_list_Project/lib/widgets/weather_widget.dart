import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String? quote;
  final String tip = "Don't forget: Even small progress is progress!";

  @override
  void initState() {
    super.initState();
    _getQuote();
  }

  void _getQuote() async {
    final r = await http.get(Uri.parse('https://api.quotable.io/random'));
    setState(() {
      quote = r.statusCode == 200
          ? jsonDecode(r.body)['content']
          : "Stay motivated and enjoy your day!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.13),
      borderRadius: BorderRadius.circular(22),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.wb_sunny_rounded,
                      color: Color(0xFFF6BE2C), size: 34),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Islamabad',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    SizedBox(height: 2),
                    Text('18°C, Sunny',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 14),
            Text(
              tip,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, 2)),
                ],
              ),
            ),
            const SizedBox(height: 7),
            quote == null
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white70),
            )
                : Text(
              '"$quote"',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                height: 1.3,
                shadows: [
                  Shadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
