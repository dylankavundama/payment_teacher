// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_teacher/Homepage.dart';
import 'package:payment_teacher/MyLogin.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), NextPage);
  }

  // ignore: non_constant_identifier_names
  void NextPage() {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => MyLogin()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ScreenH = MediaQuery.of(context).size.height;
    final ScreenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  Color.fromARGB(199, 3, 204, 244),
        body: Center(
      child: Image.asset('assets/images/logo.png'),
    ));
  }
}
