import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz.dart';
import 'result.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is Flutter?',
      'answers': [
        {'text': 'A programming language', 'score': -2},
        {'text': 'A web development framework', 'score': -2},
        {'text': 'A UI toolkit for building natively compiled applications for mobile, web, and desktop', 'score': 10},
        {'text': 'A database management system', 'score': -2},
      ],
    },
    {
      'question': 'Who developed Flutter?',
      'answers': [
        {'text': 'Apple', 'score': -2},
        {'text': 'Microsoft', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Facebook', 'score': -2},
      ],
    },
    {
      'question': 'What language is used to write Flutter apps?',
      'answers': [
        {'text': 'Java', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
        {'text': 'Swift', 'score': -2},
        {'text': 'Dart', 'score': 10},
      ],
    },
    {
      'question': 'Which widget in Flutter provides a simple way to create a set of tabs?',
      'answers': [
        {'text': 'ListView', 'score': -2},
        {'text': 'TabBar', 'score': 10},
        {'text': 'Drawer', 'score': -2},
        {'text': 'BottomNavigationBar', 'score': -2},
      ],
    },
    {
      'question': 'What is the main entry point function for a Flutter application?',
      'answers': [
        {'text': 'main()', 'score': 10},
        {'text': 'runApp()', 'score': -2},
        {'text': 'startApp()', 'score': -2},
        {'text': 'initApp()', 'score': -2},
      ],
    },
    {
      'question': 'What is a StatefulWidget in Flutter?',
      'answers': [
        {'text': 'A widget that does not change its state', 'score': -2},
        {'text': 'A widget that can change its state during its lifetime', 'score': 10},
        {'text': 'A widget that is used to display a list of items', 'score': -2},
        {'text': 'A widget that is used for navigation', 'score': -2},
      ],
    },
    {
      'question': 'Which of the following is NOT a layout widget in Flutter?',
      'answers': [
        {'text': 'Container', 'score': -2},
        {'text': 'Column', 'score': -2},
        {'text': 'Row', 'score': -2},
        {'text': 'Button', 'score': 10},
      ],
    },
    {
      'question': 'What is the purpose of the pubspec.yaml file in a Flutter project?',
      'answers': [
        {'text': 'To manage dependencies for the project', 'score': 10},
        {'text': 'To define the main entry point', 'score': -2},
        {'text': 'To configure the app’s routing', 'score': -2},
        {'text': 'To handle database connections', 'score': -2},
      ],
    },
    {
      'question': 'What is the use of the build() method in Flutter?',
      'answers': [
        {'text': 'To initialize the app', 'score': -2},
        {'text': 'To describe the part of the UI represented by the widget', 'score': 10},
        {'text': 'To handle user interactions', 'score': -2},
        {'text': 'To manage state', 'score': -2},
      ],
    },
    {
      'question': 'Which of the following widgets is used to create a scrolling list of items in Flutter?',
      'answers': [
        {'text': 'Stack', 'score': -2},
        {'text': 'ListView', 'score': 10},
        {'text': 'GridView', 'score': -2},
        {'text': 'Column', 'score': -2},
      ],
    },

    // Add the remaining questions here...
  ];


  int _questionIndex = 0;
  int _totalScore = 0;
  late AnimationController _controller;
  int _timer = 30;
  bool _isTimeUp = false;
  bool _isCorrectAnswer = false;
  int _selectedAnswerIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _timer),
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        setState(() {
          _isTimeUp = true;
          _questionIndex++;
          _controller.reset();
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _answerQuestion(int score, int answerIndex) {
    if (_isTimeUp) {
      _isTimeUp = false;
      return;
    }

    _isCorrectAnswer = score > 0;
    _selectedAnswerIndex = answerIndex;

    setState(() {
      _totalScore += score;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _questionIndex++;
        _selectedAnswerIndex = -1;
        _isCorrectAnswer = false;
      });

      _controller.reset();
      _controller.forward();

      if (_questionIndex >= _questions.length) {
        _saveScore();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _controller.reset();
      _controller.forward();
    });
  }

  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highscore', _totalScore);
  }

  Future<int> _getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('highscore') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Flutter Quiz App'),
      ),
      body: FutureBuilder<int>(
        future: _getHighScore(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          int highScore = snapshot.data ?? 0;

          return _questionIndex < _questions.length
              ? Quiz(
            questions: _questions,
            questionIndex: _questionIndex,
            answerQuestion: _answerQuestion,
            controller: _controller,
            timer: _timer,
            isCorrectAnswer: _isCorrectAnswer,
            selectedAnswerIndex: _selectedAnswerIndex,
          )
              : Result(_totalScore, highScore, _resetQuiz);
        },
      ),
    );
  }
}