import 'package:alphabetgame/Games/AlphabetBubbleGame.dart/AlphabetBubbleGame.dart';
import 'package:alphabetgame/Games/MathTheColours.dart/MatchTheColorGame.dart';
import 'package:alphabetgame/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
