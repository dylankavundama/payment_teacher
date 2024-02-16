import 'package:flutter/material.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';
import 'package:payment_teacher/groupeTP.dart';
import 'package:payment_teacher/salaire/ListSalaire.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int currentindex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  List<Widget> screen = [List_Enseignant(), const List_Salaire(), ListGroupe()];
  void _listbotton(int index) {
    currentindex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 60),
      //     child: Row(children: const [
      //       Text(
      //         'CONGO',
      //         style: TextStyle(color: Colors.orange),
      //       ),
      //       Text(
      //         'CHECK',
      //         style: TextStyle(color: Colors.lightBlue),
      //       ),
      //     ]),
      //   ),
      //   centerTitle: true,
      //   elevation: 1,
      // ),
      //   body: Container(),
      bottomSheet: screen[currentindex],

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blue[900],
        labelBehavior: labelBehavior,
        selectedIndex: currentindex,
        onDestinationSelected: (int index) {
          setState(() {
            currentindex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person_3),
            label: 'Enseignant',
          ),
          NavigationDestination(
            icon: Icon(Icons.comment_bank),
            selectedIcon: Icon(Icons.info),
            label: 'Salaire',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.list_alt),
            icon: Icon(Icons.list),
            label: 'Groupe',
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: currentindex,
      //     selectedItemColor: Colors.black,
      //     onTap: (index) {
      //       setState(() {
      //         currentindex = index;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.house_outlined,
      //             size: 19,
      //             color: Colors.black,
      //           ),
      //           label: 'Acceuil',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.sports_soccer_outlined,
      //             size: 19,
      //             color: Colors.black,
      //           ),
      //           label: 'Matches',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.people,
      //             size: 19,
      //             color: Colors.black,
      //           ),
      //           label: 'Joueurs',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.movie_outlined,
      //             size: 19,
      //             color: Colors.black,
      //           ),
      //           label: 'Videos',
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.info_outline_rounded,
      //             size: 19,
      //             color: Colors.black,
      //           ),
      //           label: 'A-propos',
      //           backgroundColor: Colors.white),
      //     ]),
    );
  }
}
