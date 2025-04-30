class QuizSummary {
  final String id; // keep id here
  final String title;
  final int totalQuestions;
  final int totalMarks;
  final String category;
  final String description;

  QuizSummary({
    required this.id,
    required this.title,
    required this.totalQuestions,
    required this.totalMarks,
    required this.category,
    required this.description,
  });

  factory QuizSummary.fromJson(Map<String, dynamic> json) {
    return QuizSummary(
      id: json['id'],
      title: json['title'],
      totalQuestions: json['totalQuestions'],
      totalMarks: json['totalMarks'],
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'totalQuestions': totalQuestions,
      'totalMarks': totalMarks,
      'category': category,
      'description': description,
    };
  }
}


// List<QuizSummary> quizList = [
//   QuizSummary(
//     id: '1',
//     title: 'General Knowledge Quiz',
//     totalQuestions: 15,
//     totalMarks: 15,
//     category: 'General Knowledge',
//     description: 'Test your general knowledge skills!',
//   ),
//   QuizSummary(
//     id: '2',
//     title: 'Science Basics',
//     totalQuestions: 20,
//     totalMarks: 20,
//     category: 'Science',
//     description: 'A quiz on basic science facts.',
//   ),
//   QuizSummary(
//     id: '3',
//     title: 'World History',
//     totalQuestions: 18,
//     totalMarks: 18,
//     category: 'History',
//     description: 'Check how much you know about world history!',
//   ),
//   QuizSummary(
//     id: '4',
//     title: 'Mathematics Challenge',
//     totalQuestions: 25,
//     totalMarks: 25,
//     category: 'Mathematics',
//     description: 'Sharpen your math skills with this quiz.',
//   ),
//   QuizSummary(
//     id: '5',
//     title: 'Geography Explorer',
//     totalQuestions: 12,
//     totalMarks: 12,
//     category: 'Geography',
//     description: 'Discover new places and facts about Earth!',
//   ),
//   QuizSummary(
//     id: '6',
//     title: 'Sports Trivia',
//     totalQuestions: 10,
//     totalMarks: 10,
//     category: 'Sports',
//     description: 'Are you a true sports fan? Test yourself!',
//   ),
//   QuizSummary(
//     id: '7',
//     title: 'Famous Personalities',
//     totalQuestions: 14,
//     totalMarks: 14,
//     category: 'Biography',
//     description: 'Learn about famous people from history.',
//   ),
//   QuizSummary(
//     id: '8',
//     title: 'Technology Today',
//     totalQuestions: 16,
//     totalMarks: 16,
//     category: 'Technology',
//     description: 'Stay updated with modern technology trends.',
//   ),
//   QuizSummary(
//     id: '9',
//     title: 'Literature Legends',
//     totalQuestions: 11,
//     totalMarks: 11,
//     category: 'Literature',
//     description: 'Dive into the world of famous books and authors.',
//   ),
//   QuizSummary(
//     id: '10',
//     title: 'Art & Culture',
//     totalQuestions: 13,
//     totalMarks: 13,
//     category: 'Culture',
//     description: 'Explore different cultures and art forms.',
//   ),
// ];