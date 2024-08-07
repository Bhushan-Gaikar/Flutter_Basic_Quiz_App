import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final void Function(int, int) answerQuestion;
  final AnimationController controller;
  final int timer;
  final bool isCorrectAnswer;
  final int selectedAnswerIndex;

  const Quiz({super.key,
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
    required this.controller,
    required this.timer,
    required this.isCorrectAnswer,
    required this.selectedAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(
          questions[questionIndex]['question'] as String,
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (ctx, child) => Text(
            'Time left: ${(timer - controller.value * timer).toInt()}s',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).asMap().entries.map((entry) {
          int idx = entry.key;
          Map<String, Object> answer = entry.value;
          return Answer(
                () => answerQuestion(answer['score'] as int, idx),
            answer['text'] as String,
            isCorrect: isCorrectAnswer && idx == selectedAnswerIndex,
            isSelected: idx == selectedAnswerIndex,
          );
        }).toList()
      ],
    );
  }
}
