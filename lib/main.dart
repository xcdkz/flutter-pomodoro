import 'package:flutter/material.dart';
import 'package:pomodoro/screens/pomodoro.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Color(0xFFA1FF00));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(colorScheme: kColorScheme, useMaterial3: true),
      home: Pomodoro(),
    );
  }
}
