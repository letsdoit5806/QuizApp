import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_summary.dart';
import 'package:quiz_app/views/auth_widget.dart';
import '../services/quiz_service.dart';
import '../cards/quiz_card.dart';

class QuizListPage extends StatefulWidget {
  const QuizListPage({super.key});

  @override
  State<QuizListPage> createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  List<QuizSummary> quizList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuizzes();
  }

  Future<void> loadQuizzes() async {
    try {
      final quizzes = await QuizService.fetchQuizzes();
      setState(() {
        quizList = quizzes;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading quizzes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Quizzes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(() {
                // Sign out logic here
                // For example, you can use FirebaseAuth to sign out the user
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              });
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : quizList.isEmpty
              ? const Center(child: Text("No quizzes found"))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: quizList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: QuizCard(quizSummary: quizList[index]),
                  );
                },
              ),
    );
  }
}
