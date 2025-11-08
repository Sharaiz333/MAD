import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class Flashcard {
  String question;
  String answer;
  bool learned;

  Flashcard({required this.question, required this.answer, this.learned = false});
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({super.key});

  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Flashcard> flashcards = [
    Flashcard(question: "What is Flutter?", answer: "A UI toolkit by Google."),
    Flashcard(question: "What language is used in Flutter?", answer: "Dart."),
    Flashcard(question: "What is a widget?", answer: "A building block of Flutter UI."),
  ];

  int learnedCount = 0;

  Future<void> _refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      flashcards = [
        Flashcard(question: "What is hot reload?", answer: "Quickly updates UI changes."),
        Flashcard(question: "What is a StatefulWidget?", answer: "Widget that maintains state."),
        Flashcard(question: "What is a StatelessWidget?", answer: "Widget with no state."),
      ];
      learnedCount = 0;
    });
  }

  void _addFlashcard() {
    final newCard = Flashcard(
        question: "New Question ${flashcards.length + 1}",
        answer: "New Answer ${flashcards.length + 1}");
    flashcards.insert(0, newCard);
    _listKey.currentState!.insertItem(0);
  }

  void _removeFlashcard(int index) {
    final removedItem = flashcards[index];
    flashcards.removeAt(index);
    learnedCount++;
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildCard(removedItem, index),
      ),
    );
  }

  Widget _buildCard(Flashcard card, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          card.learned = !card.learned;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                card.question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (card.learned)
                Text(card.answer,
                    style: const TextStyle(fontSize: 16, color: Colors.grey))
              else
                const Text("(Tap to reveal answer)",
                    style: TextStyle(color: Colors.grey)),
            ],
          ),
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
