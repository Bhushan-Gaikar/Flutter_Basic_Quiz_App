import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final void Function() selectHandler;
  final String answerText;
  final bool isCorrect;
  final bool isSelected;

  Answer(this.selectHandler, this.answerText, {this.isCorrect = false, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.blue,
        ),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}
