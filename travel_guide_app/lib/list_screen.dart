import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {'name': 'Paris', 'desc': 'City of Light and Love'},
    {'name': 'Tokyo', 'desc': 'Land of the Rising Sun'},
    {'name': 'New York', 'desc': 'The Big Apple'},
    {'name': 'London', 'desc': 'Capital of England'},
    {'name': 'Dubai', 'desc': 'Luxury in the Desert'},
    {'name': 'Istanbul', 'desc': 'Where East meets West'},
    {'name': 'Rome', 'desc': 'Home of Ancient History'},
    {'name': 'Bangkok', 'desc': 'Vibrant City of Temples'},
    {'name': 'Sydney', 'desc': 'Harbour City of Australia'},
    {'name': 'Lahore', 'desc': 'Heart of Pakistan'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.location_on, color: Colors.teal),
          title: Text(destinations[index]['name']!),
          subtitle: Text(destinations[index]['desc']!),
        );
      },
    );
  }
}
