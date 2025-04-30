import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/attempted_quiz_summary.dart';
import 'package:quiz_app/views/auth_widget.dart';
import '../services/quiz_service.dart';
import '../cards/attempted_quiz_card.dart';

class AttemptedQuizListPage extends StatefulWidget {
  const AttemptedQuizListPage({super.key});

  @override
  State<AttemptedQuizListPage> createState() => _AttemptedQuizListPageState();
}

class _AttemptedQuizListPageState extends State<AttemptedQuizListPage> {
  List<AttemptedQuizSummary> attemptedQuizzes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAttemptedQuizzes();
  }

  Future<void> loadAttemptedQuizzes() async {
    try {
      final quizzes = await QuizService.fetchAttemptedQuizzes();
      setState(() {
        attemptedQuizzes = quizzes;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading attempted quizzes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attempted Quizzes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : attemptedQuizzes.isEmpty
              ? const Center(child: Text("No attempted quizzes found"))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: attemptedQuizzes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AttemptedQuizCard(
                      attemptedQuiz: attemptedQuizzes[index],
                    ),
                  );
                },
              ),
    );
  }
}
