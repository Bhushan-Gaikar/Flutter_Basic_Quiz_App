import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final int highScore;
  final void Function() resetHandler;

  const Result(this.resultScore, this.highScore, this.resetHandler, {super.key});

  String get resultPhrase {
    String resultText;
    if (resultScore >= highScore) {
      resultText = 'New High Score! Your score is $resultScore';
    } else {
      resultText = 'Your score is $resultScore. High Score: $highScore';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            child: Text('Restart Quiz'),
            onPressed: resetHandler,
          ),
        ],
      ),
    );
  }
}
