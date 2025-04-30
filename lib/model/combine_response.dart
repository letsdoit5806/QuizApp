import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/user_attempt.dart';

class CombineResponse {
  final FullQuizDto fullQuizDto;
  final UserAttempt userAttempt;
  final List<CorrectAns> correctAnswer;

  CombineResponse({
    required this.fullQuizDto,
    required this.userAttempt,
    required this.correctAnswer,
  });

  factory CombineResponse.fromJson(Map<String, dynamic> json) {
    return CombineResponse(
      fullQuizDto: FullQuizDto.fromJson(json['fullQuizDto']),
      userAttempt: UserAttempt.fromJson(json['userAttempt']),
      correctAnswer:
          (json['correctAnswer'] as List)
              .map((item) => CorrectAns.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullQuizDto': fullQuizDto.toJson(),
      'userAttempt': userAttempt.toJson(),
      'correctAnswer': correctAnswer.map((ans) => ans.toJson()).toList(),
    };
  }
}
