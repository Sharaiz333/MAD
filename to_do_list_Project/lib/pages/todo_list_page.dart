import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';
import '../services/api_service.dart'; // NEW IMPORT
import '../widgets/weather_widget.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> with SingleTickerProviderStateMixin {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool showList = true;
  double opacity = 1.0;
  late TabController tabController;
  final ApiService apiService = ApiService(); // Initialize API Service
  Future<List<Task>>? tasksFuture; // Future to hold task data

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_loadTasks);
    _loadTasks();
  }

  @override
  void dispose() {
    tabController.removeListener(_loadTasks);
    tabController.dispose();
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  String _getFilterString(int tab) {
    switch (tab) {
      case 1: return 'completed';
      case 2: return 'pending';
      default: return 'all';
    }
  }

  void _loadTasks() {
    final filter = _getFilterString(tabController.index);
    setState(() {
      tasksFuture = apiService.fetchTasks(filter);
    });
  }

  Future<void> addTask() async {
    if (titleController.text.isNotEmpty) {
      await apiService.addTask(titleController.text, descController.text);
      titleController.clear();
      descController.clear();
      _loadTasks();
    }
  }


  Future<void> _deleteTask(String id) async {
    await apiService.deleteTask(id);
    _loadTasks();
  }

  Future<void> _editTask(String id, String title, String desc) async {
    await apiService.updateTask(id, {'title': title, 'description': desc});
    _loadTasks();
  }

  Future<void> _toggleDone(String id, bool? isDone) async {
    await apiService.updateTask(id, {'isDone': isDone ?? false});
    _loadTasks();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✨ Riphahtasker To-Do List ✨'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'All'),
            Tab(icon: Icon(Icons.done_all), text: 'completed'),
            Tab(icon: Icon(Icons.pending), text: 'pending'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB993D6), Color(0xFF8CA6DB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: WeatherWidget(),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: List.generate(3, (tab) {
                    // Replace StreamBuilder with FutureBuilder
                    return FutureBuilder<List<Task>>(
                      key: ValueKey(tab), // Key to re-run future when tab changes
                      future: tasksFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting || tasksFuture == null) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          // Display error from the API call
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                            ),
                          );
                        }

                        final tasks = snapshot.data ?? [];

                        if (tasks.isEmpty) {
                          return const Center(
                            child: Text(
                              'No tasks yet. Add one!',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        }

                        return AnimatedOpacity(
                          opacity: opacity,
                          duration: const Duration(milliseconds: 400),
                          child: showList
                              ? ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: tasks.length,
                            itemBuilder: (c, i) {
                              final task = tasks[i];

                              // Make sure we have an ID before rendering
                              if (task.id == null) return const SizedBox.shrink();

                              return TaskTile(
                                task: task,
                                opacity: opacity,
                                onDelete: () async => await _deleteTask(task.id!),
                                onEdit: (title, desc) async => await _editTask(task.id!, title, desc),
                                onToggleDone: (v) async => await _toggleDone(task.id!, v),
                              );
                            },
                          )
                              : const Center(
                            child: Text(
                              'List Hidden 👀',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    mini: true,
                    heroTag: 'refreshBtn',
                    backgroundColor: Colors.blueGrey,
                    onPressed: _loadTasks,
                    tooltip: 'Refresh task list',
                    child: const Icon(Icons.refresh),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    mini: true,
                    heroTag: 'toggleBtn',
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() => opacity = 0.0);
                      Future.delayed(const Duration(milliseconds: 400), () {
                        setState(() {
                          showList = !showList;
                          opacity = 1.0;
                        });
                      });
                    },
                    tooltip: showList ? 'Hide task list' : 'Show task list',
                    child: const Icon(Icons.visibility),
                  ),
                  FloatingActionButton(
                    heroTag: 'addBtn',
                    backgroundColor: Colors.pinkAccent,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AddTaskDialog(
                        titleController: titleController,
                        descController: descController,
                        onAdd: () async {
                          await addTask();
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.deepPurple[100] ?? Colors.purple.shade100,
                      ),
                    ),
                    tooltip: 'Add new task',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Riphah International University',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Created by Sharaiz Ahmed',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'SAP ID: 57288',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
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