// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';
import 'package:payment_teacher/salaire/AjouterSalaire.dart';

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
      CupertinoPageRoute(builder: (context) => List_Enseignant()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ScreenH = MediaQuery.of(context).size.height;
    final ScreenW = MediaQuery.of(context).size.width;
    return SizedBox(
      height: ScreenH,
      width: ScreenW,
      child: Image.network(
          'https://png.pngtree.com/element_our/png_detail/20181227/online-payment-icon-designed-creatively-and-simple-for-freshness-for-application-png_293646.jpg'),
    );
  }
}
