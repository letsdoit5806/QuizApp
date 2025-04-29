import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/quiz_summary.dart';
import 'package:quiz_app/model/user_attempt.dart';
// Import FullQuizDto

class QuizService {
  static const String _baseSummaryUrl = 'http://localhost:8080/api/quizzes/all';
  static const String _baseQuizDetailUrl = 'http://localhost:8080/api/quizzes/'; // NOTE: + {id}

  // Fetch list of quiz summaries
  static Future<List<QuizSummary>> fetchQuizzes() async {
    try {
      final response = await http.get(Uri.parse(_baseSummaryUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> quizzesJson = jsonData['data'];

        return quizzesJson.map((quiz) => QuizSummary.fromJson(quiz)).toList();
      } else {
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      print('Error fetching quiz summaries: $e');
      rethrow;
    }
  }

  // Fetch full quiz by ID
  static Future<FullQuizDto> fetchQuizById(String quizId) async {
    try {
      final url = Uri.parse('$_baseQuizDetailUrl$quizId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final quizJson = jsonData['data']; // Assuming { data: {quiz} }
        return FullQuizDto.fromJson(quizJson);
      } else {
        throw Exception('Failed to load quiz with id $quizId');
      }
    } catch (e) {
      print('Error fetching quiz by id: $e');
      rethrow;
    }
  }

  static Future<void> submitQuizAttempt({
  required String quizId,
  required String userId,
  required List<Answer> answers,
}) async {
  final payload = {
    'quizId': quizId,
    'userId': userId,
    'answers': answers.map((a) => a.toJson()).toList(),
  };

  final response = await http.post(
    Uri.parse('http://localhost:8080/api/attempts/submit'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(payload),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to submit quiz attempt');
  }
}

}
