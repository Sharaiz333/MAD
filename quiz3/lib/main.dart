import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class Flashcard {
  String question;
  String answer;
  bool showAnswer;
  bool learned;

  Flashcard({
    required this.question,
    required this.answer,
    this.showAnswer = false,
    this.learned = false,
  });
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({super.key});

  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Flashcard> flashcards = [
    Flashcard(question: "What is Flutter?", answer: "A framework to build cross-platform apps."),
    Flashcard(question: "Who developed Flutter?", answer: "Google."),
    Flashcard(question: "What language does Flutter use?", answer: "Dart."),
    Flashcard(question: "What is a widget in Flutter?", answer: "A building block of the UI."),
    Flashcard(question: "What is hot reload?", answer: "A feature to update UI instantly."),
  ];

  int get learnedCount => flashcards.where((c) => c.learned).length;

  Future<void> _refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      flashcards = [
        Flashcard(question: "What is setState() used for?", answer: "To update the UI in StatefulWidgets."),
        Flashcard(question: "What does Scaffold do?", answer: "Provides basic layout structure."),
        Flashcard(question: "What is a StatelessWidget?", answer: "A widget without any state."),
        Flashcard(question: "What is a StatefulWidget?", answer: "A widget that can change over time."),
        Flashcard(question: "What is MaterialApp?", answer: "The root widget for a Material Design app."),
      ];
    });
  }

  void _addFlashcard() {
    final newCard = Flashcard(
      question: "New Question ${flashcards.length + 1}",
      answer: "New Answer ${flashcards.length + 1}",
    );
    flashcards.insert(0, newCard);
    _listKey.currentState!.insertItem(0);
  }

  void _removeFlashcard(int index) {
    final removedItem = flashcards[index];
    flashcards.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildCard(removedItem, index),
      ),
    );
  }

  Widget _buildCard(Flashcard card, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Text(
                card.question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(
                  card.showAnswer ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.blue,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    card.showAnswer = !card.showAnswer;
                    // Mark as learned when answer is revealed
                    if (card.showAnswer) {
                      card.learned = true;
                    } else {
                      card.learned = false;
                    }
                  });
                },
              ),
            ),
            if (card.showAnswer)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
                child: Text(
                  card.answer,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addFlashcard,
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshList,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Learned $learnedCount of ${flashcards.length}"),
                  background: Container(color: Colors.blue.shade100),
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedList(
                  key: _listKey,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  initialItemCount: flashcards.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: Dismissible(
                        key: ValueKey(flashcards[index]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                        onDismissed: (_) => _removeFlashcard(index),
                        child: _buildCard(flashcards[index], index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
