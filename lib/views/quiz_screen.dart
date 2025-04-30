import 'package:flutter/material.dart';
import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/user_attempt.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/views/quiz_result.dart';
// new

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
  bool _isSubmitting = false;

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

  //

  void submitQuiz() async {
    if (quiz == null || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    final unanswered =
        quiz!.questions
            .where((q) => !selectedAnswers.containsKey(q.id))
            .toList();

    if (unanswered.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions')),
      );
      setState(() {
        _isSubmitting = false; // <--- Reset state here
      });
      return;
    }

    final answers =
        selectedAnswers.entries
            .map(
              (entry) =>
                  Answer(questionId: entry.key, selectedAnswer: entry.value),
            )
            .toList();

    try {
      final attemptId = await QuizService.submitQuizAttempt(
        quizId: quiz!.id,
        userId: 'user123', // Replace with actual user ID
        answers: answers,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(attemptId: attemptId),
        ),
      );
    } catch (e) {
      print('Submit error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to submit quiz')));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body:
          isLoading
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
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
                    onPressed: _isSubmitting ? null : submitQuiz,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child:
                        _isSubmitting
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                            : const Text("Submit Quiz"),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
    );
  }
}
