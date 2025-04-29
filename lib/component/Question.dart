class Question {
  String question;
  List<String> options;
  String correctAns;
  Question({required this.question,required this.options,required this.correctAns});
}

List<Question> questionList = [
  Question(
    question: "What is the capital of France?",
    options: ["Berlin", "Madrid", "Paris", "Rome"],
    correctAns: "Paris",
  ),
  Question(
    question: "What is 2 + 2?",
    options: ["3", "4", "5", "6"],
    correctAns: "4",
  ),
  Question(
    question: "Which planet is known as the Red Planet?",
    options: ["Earth", "Mars", "Venus", "Jupiter"],
    correctAns: "Mars",
  ),
  Question(
    question: "Who wrote 'Hamlet'?",
    options: ["Shakespeare", "Dickens", "Austen", "Hemingway"],
    correctAns: "Shakespeare",
  ),
  Question(
    question: "What is the largest ocean on Earth?",
    options: ["Atlantic", "Indian", "Pacific", "Arctic"],
    correctAns: "Pacific",
  ),
  Question(
    question: "What is the square root of 81?",
    options: ["7", "8", "9", "10"],
    correctAns: "9",
  ),
  Question(
    question: "Which element has the chemical symbol 'O'?",
    options: ["Oxygen", "Osmium", "Ozone", "Oxygenium"],
    correctAns: "Oxygen",
  ),
  Question(
    question: "What is the freezing point of water?",
    options: ["0°C", "32°F", "-1°C", "10°C"],
    correctAns: "0°C",
  ),
  Question(
    question: "Which animal is known as the king of the jungle?",
    options: ["Lion", "Tiger", "Elephant", "Giraffe"],
    correctAns: "Lion",
  ),
  Question(
    question: "What is the fastest animal on land?",
    options: ["Lion", "Cheetah", "Elephant", "Horse"],
    correctAns: "Cheetah",
  ),
];
