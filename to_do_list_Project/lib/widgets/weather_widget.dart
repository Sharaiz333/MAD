import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String city = "Islamabad";
  String weather = "";
  String description = "";
  num? temp;
  bool isLoading = true;

  // List of motivational quotes
  final List<Map<String, String>> fallbackQuotes = [
    {
      "body": "Stay positive and keep pushing forward!",
      "author": "Unknown"
    },
    {
      "body": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "body": "Don't watch the clock; do what it does. Keep going.",
      "author": "Sam Levenson"
    },
    {
      "body": "Opportunities don't happen, you create them.",
      "author": "Chris Grosser"
    },
  ];

  String dailyQuote = "";
  String quoteAuthor = "";

  @override
  void initState() {
    super.initState();
    assignRandomFallbackQuote();
    fetchWeatherAndQuote();
  }

  void assignRandomFallbackQuote() {
    final randomIndex = Random().nextInt(fallbackQuotes.length);
    dailyQuote = fallbackQuotes[randomIndex]["body"]!;
    quoteAuthor = fallbackQuotes[randomIndex]["author"]!;
  }

  Future<void> fetchWeatherAndQuote() async {
    setState(() => isLoading = true);
    try {
      await fetchWeather();
      await fetchDailyQuote();
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchWeather() async {
    final apiKey = 'a7128a1e9eb5fef935080a93098612ba';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 7));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        temp = data['main']['temp'];
        weather = data['weather'][0]['main'];
        description = data['weather'][0]['description'];
      } else {
        weather = "Unavailable";
        description = data['message'] ?? "";
      }
    } catch (_) {
      weather = "Error";
      description = "";
    }
  }

  Future<void> fetchDailyQuote() async {
    final url = 'https://favqs.com/api/qotd';

    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 7));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final quote = data['quote'];
        setState(() {
          dailyQuote = quote['body'] ?? dailyQuote;
          quoteAuthor = quote['author'] ?? quoteAuthor;
        });
      }
      // If fails, keep fallback quote
    } catch (_) {
      // Use fallback quote if API call fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tileMaxWidth = 440.0; // Compact for desktop/tablet, responsive for mobile

    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 18,
        child: Container(
          width: screenWidth < tileMaxWidth ? screenWidth * 0.93 : tileMaxWidth,
          constraints: BoxConstraints(maxWidth: tileMaxWidth),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: isLoading
              ? SizedBox(
            height: 75,
            child:
            Center(child: CircularProgressIndicator(color: Colors.white)),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 43,
                height: 43,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  weather.contains("Rain")
                      ? Icons.umbrella
                      : weather.contains("Cloud")
                      ? Icons.cloud
                      : Icons.wb_sunny_rounded,
                  color: Colors.yellow[600],
                  size: 29,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      temp != null
                          ? "${temp!.round()}°C, $weather"
                          : "No weather data",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.87),
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withOpacity(0.72),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\"$dailyQuote\"",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "- $quoteAuthor",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.80),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
