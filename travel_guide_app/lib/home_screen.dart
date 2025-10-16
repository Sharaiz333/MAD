import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Travel Image
          Image.asset(
            'assets/home/travel.jpg',
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),


          // Welcome Message
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.teal[50],
            child: Text(
              'Welcome to Travel Guide App! Discover amazing places around the world.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),

          // Travel Slogan
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Adventure ',
                style: TextStyle(color: Colors.black, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Awaits — ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  TextSpan(
                    text: 'Discover, Dream, and Explore!',
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                ],
              ),
            ),
          ),


          // Destination Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: 'Enter Destination Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Buttons
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Happy Traveling!')),
              );
            },
            child: Text('Show Message'),
          ),
          TextButton(
            onPressed: () {
              print('Button Pressed!');
            },
            child: Text('Print Message'),
          ),
        ],
      ),
    );
  }
}
