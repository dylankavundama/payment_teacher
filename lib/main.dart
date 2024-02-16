import 'package:flutter/material.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue[900],
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.blue[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[900]),
      ),
      home: List_Enseignant(),
    );
  }
}
