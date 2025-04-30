import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/model/attempted_quiz_summary.dart';
import 'package:quiz_app/model/combine_response.dart';
import 'package:quiz_app/model/full_quiz.dart';
import 'package:quiz_app/model/quiz_summary.dart';
import 'package:quiz_app/model/user_attempt.dart' as userAttempt show Answer;
// Import FullQuizDto

class QuizService {
  static const String baseurl = "https://186d-27-59-100-69.ngrok-free.app";
  static const String _baseSummaryUrl = '$baseurl/api/quizzes/all';
  static const String _baseQuizDetailUrl =
      '$baseurl/api/quizzes/'; // NOTE: + {id}

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

  static Future<String> submitQuizAttempt({
    required String quizId,
    required String userId,
    required List<userAttempt.Answer> answers,
  }) async {
    final payload = {
      'quizId': quizId,
      'userId': userId,
      'answers': answers.map((a) => a.toJson()).toList(),
    };
    final uid = FirebaseAuth.instance.currentUser?.uid;

    final response = await http.post(
      Uri.parse('$baseurl/api/attempts/submit/$uid'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit quiz attempt');
    }

    final data = json.decode(response.body);
    return data['attemptId']; // Assumes response JSON has an 'attemptId' field
  }

  static Future<List<AttemptedQuizSummary>> fetchAttemptedQuizzes() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final response = await http.get(
      Uri.parse('$baseurl/api/attempts/attempted/$uid'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> quizzesJson = jsonData['data'];

      return quizzesJson
          .map((quiz) => AttemptedQuizSummary.fromJson(quiz))
          .toList();
    } else {
      throw Exception('Failed to load attempted quizzes');
    }
  }

  static Future<CombineResponse> fetchCombinedQuizData(String attemptId) async {
    final url = Uri.parse('$baseurl/api/attempts/attempted/results/$attemptId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CombineResponse.fromJson(data);
    } else {
      throw Exception('Failed to load combined quiz data');
    }
  }
}
