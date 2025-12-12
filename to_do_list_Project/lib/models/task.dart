class Task {
  String? id;
  String title;
  String description;
  bool isDone;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  // New factory constructor to convert JSON from the backend into a Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
    );
  }
}