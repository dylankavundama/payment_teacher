import 'package:flutter/material.dart';
import 'package:payment_teacher/Homepage.dart';
import 'package:payment_teacher/MyLogin.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';
import 'package:payment_teacher/groupeTP.dart';
import 'package:payment_teacher/loading.dart';
import 'package:payment_teacher/salaire/ListSalaire.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  isCheckIfAlreadyOpen().then((value) {
    runApp(MyApp(
      isOpened: value,
    ));
  });
}

Future<bool> isCheckIfAlreadyOpen() async {
  final prefs = await SharedPreferences.getInstance();
  bool result = prefs.getBool('opened') ?? false;
  if (!result) {
    prefs.setBool('opened', true);
  }
  return result;
}

class MyApp extends StatelessWidget {
  final bool isOpened;
  const MyApp({Key? key, required this.isOpened}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: const Color.fromARGB(199, 3, 204, 244),
      theme: ThemeData(
        primaryColor: Color.fromARGB(199, 3, 204, 244),
        backgroundColor: Color.fromARGB(199, 3, 204, 244),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(199, 3, 204, 244),
        ),
      ),
      home: isOpened ? HomePage() : const List_Salaire(),
      routes: {

        '/home': (context) => const HomePage(),
 
        '/List_Enseignant': (context) => const List_Enseignant(),
        '/List_Salaire': (context) => const List_Salaire(),
       // '/Rapport': (context) => const Rapport(),
        '/ListGroupe': (context) => const ListGroupe(),

      },
    );
  }
}
