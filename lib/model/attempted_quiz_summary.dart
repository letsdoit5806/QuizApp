import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/user_attempt.dart';

import 'quiz_summary.dart';

class AttemptedQuizSummary {
  final QuizSummary quizSummary;
  final int score;

  AttemptedQuizSummary({required this.quizSummary, required this.score});

  factory AttemptedQuizSummary.fromJson(Map<String, dynamic> json) {
    return AttemptedQuizSummary(
      quizSummary: QuizSummary.fromJson(json['quizSummary']),
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'quizSummary': quizSummary.toJson(), 'score': score};
  }
}

class AttemptDetailResponse {
  final UserAttempt userAttempt;
  final FullQuizDto quiz;

  AttemptDetailResponse({required this.userAttempt, required this.quiz});

  factory AttemptDetailResponse.fromJson(Map<String, dynamic> json) {
    return AttemptDetailResponse(
      userAttempt: UserAttempt.fromJson(json['userAttempt']),
      quiz: FullQuizDto.fromJson(json['quiz']),
    );
  }
}
