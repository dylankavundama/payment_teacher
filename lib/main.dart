import 'package:flutter/material.dart';
import 'package:payment_teacher/Homepage.dart';
import 'package:payment_teacher/MyLogin.dart';
import 'package:payment_teacher/Rapport.dart';
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
      color: Color.fromRGBO(33, 150, 243, 1),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(33, 150, 243, 1),
        backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        ),
      ),
      home: isOpened ? LoadingPage() : const MyLogin(),
      routes: {
        // '/splash': (context) => SplashScreen(),
        // '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        // '/category': (context) => new CategorySearch(
        //  category: ModalRoute.of(context).settings.arguments),
        '/List_Enseignant': (context) => const List_Enseignant(),
        '/List_Salaire': (context) => const List_Salaire(),
        '/Rapport': (context) => const Rapport(),
        '/ListGroupe': (context) => const ListGroupe(),
        // '/client': (context) => const ClientList(),
        // '/vente/main': (context) => const DetailVente(),
        // '/vente/client': (context) => const MainVente(),
        // '/vente/list': (context) => const VenteList(),
        // '/settings': (context) => const SettingMainScreen(),
        // '/depense/add': (context) => const AddDepenseForm(),
        // '/depense/list': (context) => const DepenseListScreen(),
        // '/facture': (context) => new FactureScreen(),
      },
    );
  }
}
