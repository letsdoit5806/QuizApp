class FullQuizDto {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final List<QuestionDto> questions;

  FullQuizDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.questions,
  });

  factory FullQuizDto.fromJson(Map<String, dynamic> json) {
    return FullQuizDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      difficulty: json['difficulty'],
      questions:
          (json['questions'] as List)
              .map((question) => QuestionDto.fromJson(question))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class QuestionDto {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuestionDto({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
      id: json['id'] ?? json['questionId'], // fallback support
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'] ?? -1,
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }
}

class CorrectAns {
  final String questionID;
  final int ans;

  CorrectAns({required this.questionID, required this.ans});

  factory CorrectAns.fromJson(Map<String, dynamic> json) {
    return CorrectAns(questionID: json['questionID'], ans: json['ans']);
  }

  Map<String, dynamic> toJson() {
    return {'questionID': questionID, 'ans': ans};
  }
}
