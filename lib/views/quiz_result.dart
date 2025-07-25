import 'package:flutter/material.dart';
import 'package:quiz_app/model/combine_response.dart';
import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/user_attempt.dart';
import '../services/quiz_service.dart';

class QuizResultPage extends StatefulWidget {
  final String attemptId;

  const QuizResultPage({super.key, required this.attemptId});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  // Replace with actual base URL

  bool isLoading = true;
  CombineResponse? resultData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadResult();
  }

  Future<void> loadResult() async {
    try {
      final data = await QuizService.fetchCombinedQuizData(widget.attemptId);

      setState(() {
        resultData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text('Error: $errorMessage'))
              : resultData == null
              ? const Center(child: Text('No data available'))
              : buildResultContent(),
    );
  }

  Widget buildResultContent() {
    final data = resultData!;
    final questions = data.fullQuizDto.questions;
    final userAnswers = data.userAttempt.answers;
    final correctAnswers = data.correctAnswer;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz: ${data.fullQuizDto.title}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text('Category: ${data.fullQuizDto.category}'),
          Text('Difficulty: ${data.fullQuizDto.difficulty}'),
          const SizedBox(height: 12),
          Text(
            'Your Score: ${data.userAttempt.score} / ${data.userAttempt.maxScore}',
          ),
          Text('Correct Answers: ${data.userAttempt.correctAnswers}'),
          Text('Incorrect Answers: ${data.userAttempt.incorrectAnswers}'),
          const Divider(height: 30),
          Text(
            'Questions and Answers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),

          ...questions.map((q) {
            final selected = userAnswers.firstWhere(
              (ua) => ua.questionId == q.id,
              orElse: () => Answer(questionId: '', selectedAnswer: -1),
            );
            final correct = correctAnswers.firstWhere(
              (ca) => ca.questionID == q.id,
              orElse: () => CorrectAns(questionID: '', ans: -1),
            );

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.questionText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(q.options.length, (index) {
                      bool isCorrect = correct.ans == index;
                      bool isSelected = selected.selectedAnswer == index;

                      return ListTile(
                        leading: Icon(
                          isCorrect
                              ? Icons.check_circle
                              : isSelected
                              ? Icons.cancel
                              : Icons.circle_outlined,
                          color:
                              isCorrect
                                  ? Colors.green
                                  : isSelected
                                  ? Colors.red
                                  : null,
                        ),
                        title: Text(q.options[index]),
                      );
                    }),
                    const SizedBox(height: 6),
                    Text(
                      'Explanation: ${q.explanation}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
