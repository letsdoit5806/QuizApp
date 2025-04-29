import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_summary.dart';
import 'package:quiz_app/views/quiz_screen.dart';

 // Make sure this import exists

class QuizCard extends StatelessWidget {
  final QuizSummary quizSummary;

  const QuizCard({super.key, required this.quizSummary});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizSummary.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("Category: ${quizSummary.category}"),
            Text("Questions: ${quizSummary.totalQuestions}"),
            Text("Marks: ${quizSummary.totalMarks}"),
            const SizedBox(height: 10),
            Text(
              quizSummary.description,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => QuizScreen(quizId: quizSummary.id),
                                      ),
                                );

                },
                child: const Text("Start Quiz"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage {
}
