import 'package:flutter/material.dart';
import 'package:payment_teacher/loading.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue[900],
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.blue[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[900]),
      ),
      home:  const LoadingPage(),
    );
  }
}
