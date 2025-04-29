import 'package:flutter/material.dart';
import 'package:quiz_app/model/full_quiz.dart';

class QuestionCard extends StatelessWidget {
  final QuestionDto question;
  final int? selectedAnswer;
  final ValueChanged<int> onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...List.generate(question.options.length, (index) {
          return RadioListTile<int>(
            title: Text(question.options[index]),
            value: index,
            groupValue: selectedAnswer,
            onChanged: (val) => onOptionSelected(val!),
          );
        }),
      ],
    );
  }
}
