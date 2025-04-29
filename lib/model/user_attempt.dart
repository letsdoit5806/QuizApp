// models/user_attempt.dart

class UserAttempt {
  String? id;
  String userId;
  String quizId;
  DateTime? attemptedOn;
  int score;
  int maxScore;
  int totalQuestions;
  int correctAnswers;
  int incorrectAnswers;
  List<Answer> answers;

  UserAttempt({
    this.id,
    required this.userId,
    required this.quizId,
    this.attemptedOn,
    required this.score,
    required this.maxScore,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.answers,
  });

  // From JSON
  factory UserAttempt.fromJson(Map<String, dynamic> json) {
    return UserAttempt(
      id: json['_id'] ?? json['id'],
      userId: json['userId'],
      quizId: json['quizId'],
      attemptedOn: json['attemptedOn'] != null ? DateTime.parse(json['attemptedOn']) : null,
      score: json['score'],
      maxScore: json['maxScore'],
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      incorrectAnswers: json['incorrectAnswers'],
      answers: (json['answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'quizId': quizId,
      'attemptedOn': attemptedOn?.toIso8601String(),
      'score': score,
      'maxScore': maxScore,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class Answer {
  String questionId;
  int selectedAnswer;

  Answer({
    required this.questionId,
    required this.selectedAnswer,
  });

  // From JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionId: json['questionId'],
      selectedAnswer: json['selectedAnswer'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedAnswer': selectedAnswer,
    };
  }
}
