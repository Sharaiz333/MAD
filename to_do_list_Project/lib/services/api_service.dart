import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api';

  Future<List<Task>> fetchTasks(String filter) async {
    final response = await http.get(Uri.parse('$baseUrl/tasks?filter=$filter'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks from backend');
    }
  }

  // Method to add a task
  Future<void> addTask(String title, String description) async {
    await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'description': description}),
    );
  }

  // Method to update a task
  Future<void> updateTask(String id, Map<String, dynamic> updateData) async {
    await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateData),
    );
  }

  // Method to delete a task
  Future<void> deleteTask(String id) async {
    await http.delete(Uri.parse('$baseUrl/tasks/$id'));
  }
}