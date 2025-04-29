import 'package:flutter/material.dart';
import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/user_attempt.dart';
import 'package:quiz_app/services/quiz_service.dart'; // new

class QuizScreen extends StatefulWidget {
  final String quizId;

  const QuizScreen({super.key, required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  FullQuizDto? quiz;
  Map<String, int> selectedAnswers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    try {
      final result = await QuizService.fetchQuizById(widget.quizId);
      setState(() {
        quiz = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  void submitQuiz() async {
    if (quiz == null) return;

    final unanswered = quiz!.questions.where((q) => !selectedAnswers.containsKey(q.id)).toList();
    if (unanswered.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions')),
      );
      return;
    }

    final answers = selectedAnswers.entries
        .map((entry) => Answer(questionId: entry.key, selectedAnswer: entry.value))
        .toList();

    try {
      await QuizService.submitQuizAttempt(
        quizId: quiz!.id,
        userId: 'user123', // You can fetch this from login/session
        answers: answers,
      );

      int correctCount = 0;
      for (var q in quiz!.questions) {
        if (selectedAnswers[q.id] == q.correctAnswer) {
          correctCount++;
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Quiz Submitted"),
          content: Text("Your Score: $correctCount / ${quiz!.questions.length}"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } catch (e) {
      print('Submit error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit quiz')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : quiz == null
              ? const Center(child: Text("Quiz not found"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: quiz!.questions.length,
                        itemBuilder: (context, index) {
                          final q = quiz!.questions[index];
                          return Card(
                            margin: const EdgeInsets.all(12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Q${index + 1}. ${q.questionText}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  ...List.generate(q.options.length, (i) {
                                    return RadioListTile<int>(
                                      title: Text(q.options[i]),
                                      value: i,
                                      groupValue: selectedAnswers[q.id],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedAnswers[q.id] = value!;
                                        });
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: submitQuiz,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                      child: const Text("Submit Quiz"),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
    );
  }
}
