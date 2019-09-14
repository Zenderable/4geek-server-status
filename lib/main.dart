import 'package:flutter/material.dart';
import 'screens/waiting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaitingScreen(),
      theme: ThemeData.dark().copyWith(accentColor: Colors.grey),
    );
  }
}
