import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  // Base URL for your Node.js backend
  // Use your actual IP address if testing on a physical device,
  // or '10.0.2.2' for Android Emulator, or 'localhost' for Web/Desktop/iOS Simulator
  final String backendBaseUrl = 'http://localhost:3000';

  String city = "Islamabad";
  String weather = "";
  String description = "";
  num? temp;
  bool isLoading = true;

  String dailyQuote = "";
  String quoteAuthor = "";

  @override
  void initState() {
    super.initState();
    // We don't need fallback quotes or a separate assignRandomFallbackQuote()
    // because the backend provides a default/fallback quote on failure.
    fetchExternalData();
  }

  // Rename the function to better reflect what it does now
  Future<void> fetchExternalData() async {
    setState(() => isLoading = true);
    try {
      final url = '$backendBaseUrl/api/external-data?city=$city';
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temp = data['temp'];
          weather = data['weather'];
          description = data['description'];
          dailyQuote = data['dailyQuote'];
          quoteAuthor = data['quoteAuthor'];
        });
      } else {
        // Handle backend error
        weather = "Backend Error";
        description = "Status: ${response.statusCode}";
      }
    } catch (e) {
      // Handle connection error (server not running, network issue, etc.)
      print("Connection Error: $e");
      setState(() {
        weather = "Connection Error";
        description = "Could not reach backend";
        dailyQuote = "Please ensure the Node.js server is running.";
        quoteAuthor = "Server Check";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (rest of the build method remains the same)
    // The UI part of WeatherWidget remains unchanged, only the data fetching logic is different.

    // ... (Your original build method here)

    // ... (Original build code below)
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
              ? const SizedBox(
            height: 75,
            child: Center(child: CircularProgressIndicator(color: Colors.white)),
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