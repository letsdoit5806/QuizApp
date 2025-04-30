import 'package:flutter/material.dart';
import 'package:quiz_app/model/attempted_quiz_summary.dart';
import 'package:quiz_app/views/quiz_result.dart';

class AttemptedQuizCard extends StatelessWidget {
  final AttemptedQuizSummary attemptedQuiz;

  const AttemptedQuizCard({super.key, required this.attemptedQuiz});

  @override
  Widget build(BuildContext context) {
    final quizSummary = attemptedQuiz.quizSummary;
    final score = attemptedQuiz.score;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizSummary.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Category: ${quizSummary.category}"),
            Text("Questions: ${quizSummary.totalQuestions}"),
            Text("Marks: ${quizSummary.totalMarks}"),
            Text("Score: $score"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuizResultPage(attemptId: quizSummary.id),
                  ),
                );
              },
              child: const Text("View"),
            ),
            const SizedBox(height: 10),
            Text(
              quizSummary.description,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
