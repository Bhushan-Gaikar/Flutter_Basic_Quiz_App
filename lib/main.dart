import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'quiz_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(
        onStartQuiz: () {
          // This will be handled in the LoadingScreen's button
        },
      ),
    );
  }
}
