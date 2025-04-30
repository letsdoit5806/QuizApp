import 'package:flutter/material.dart';
import 'package:quiz_app/views/attempted_quiz_list_page.dart';
import 'package:quiz_app/views/quiz_list_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App Home"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                _buildButton(
                  context,
                  label: "View Quizzes",
                  icon: Icons.visibility,
                  color: Colors.deepPurple,
                  onPressed: () {
                    // Navigate to View Quizzes screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizListPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  context,
                  label: "View Quiz results",
                  icon: Icons.history,
                  color: Colors.teal,
                  onPressed: () {
                    // Navigate to View Old Quizzes screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AttemptedQuizListPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  context,
                  label: "Create New Quiz",
                  icon: Icons.add_circle_outline,
                  color: Colors.orange,
                  onPressed: () {
                    // Navigate to Create New Quiz screen
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      ),
    );
  }
}
