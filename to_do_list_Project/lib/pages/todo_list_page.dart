import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/edit_task_dialog.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> addTask() async {
    if (titleController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': titleController.text,
        'description': descController.text,
        'isDone': false,
        'created': FieldValue.serverTimestamp(),
      });
      titleController.clear();
      descController.clear();
    }
  }

  Stream<QuerySnapshot> getTaskStream(int tab) {
    final ref = FirebaseFirestore.instance.collection('tasks').orderBy('created');
    switch (tab) {
      case 1:
        return ref.where('isDone', isEqualTo: true).snapshots();
      case 2:
        return ref.where('isDone', isEqualTo: false).snapshots();
      default:
        return ref.snapshots();
    }
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
            Tab(icon: Icon(Icons.done_all), text: 'Completed'),
            Tab(icon: Icon(Icons.pending), text: 'Pending'),
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
                    return StreamBuilder<QuerySnapshot>(
                      stream: getTaskStream(tab),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No tasks yet. Add one!',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        }
                        final docs = snapshot.data!.docs;
                        return AnimatedOpacity(
                          opacity: opacity,
                          duration: const Duration(milliseconds: 400),
                          child: showList
                              ? ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: docs.length,
                            itemBuilder: (c, i) {
                              final doc = docs[i];
                              final data = doc.data() as Map<String, dynamic>;
                              return TaskTile(
                                task: Task(
                                  title: data['title'] ?? '',
                                  description: data['description'] ?? '',
                                  isDone: data['isDone'] ?? false,
                                ),
                                opacity: opacity,
                                onDelete: () async => await doc.reference.delete(),
                                onEdit: (title, desc) async => await doc.reference.update({
                                  'title': title,
                                  'description': desc,
                                }),
                                onToggleDone: (v) async =>
                                await doc.reference.update({'isDone': v ?? false}),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
