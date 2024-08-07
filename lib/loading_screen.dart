import 'package:flutter/material.dart';

import 'quiz_page.dart';

class LoadingScreen extends StatelessWidget {
  final VoidCallback onStartQuiz;

  LoadingScreen({required this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text('Flutter Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Quiz!',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 20),
            Builder(
              builder: (BuildContext innerContext) {
                return ElevatedButton(
                  onPressed: () {
                    // Use Navigator of innerContext to push to the QuizPage
                    Navigator.of(innerContext).pushReplacement(
                      MaterialPageRoute(builder: (context) => QuizPage()),
                    );
                  },
                  child: Text('Start Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
