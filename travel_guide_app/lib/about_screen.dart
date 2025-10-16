import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final List<Map<String, String>> landmarks = [
    {'image': 'assets/landmarks/eiffel.jpg', 'name': 'Eiffel Tower'},
    {'image': 'assets/landmarks/wall.jpg', 'name': 'Great Wall'},
    {'image': 'assets/landmarks/taj.jpg', 'name': 'Taj Mahal'},
    {'image': 'assets/landmarks/opera.jpg', 'name': 'Opera House'},
    {'image': 'assets/landmarks/liberty.jpg', 'name': 'Statue of Liberty'},
    {'image': 'assets/landmarks/bashahi.jpg', 'name': 'Badshahi Mosque'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: landmarks.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: Image.asset(
                landmarks[index]['image']!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              landmarks[index]['name']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
