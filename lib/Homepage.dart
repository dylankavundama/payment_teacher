import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:payment_teacher/MyLogin.dart';
import 'package:payment_teacher/enseignant/Ajouter.dart';
import 'package:payment_teacher/enseignant/UpdateEnseignant.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      var url = "https://royalrisingplus.com/payment_teacher/delete-enseignant.php";
      var result = await http.post(Uri.parse(url), body: {"id": id});
      var reponse = jsonDecode(result.body);
      if (reponse["Success"] == "True") {
        debugPrint("record deleted");
        getrecord();
      } else {
        debugPrint("Erreur de suppression");
        getrecord();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    var url = "https://royalrisingplus.com/payment_teacher/read-enseignant.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        final ss = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
              child: Container(
                color:Color.fromARGB(199, 3, 204, 244),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  child: ClipPath(
                    clipper: CustomShapeDetail(),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      color:Color.fromARGB(199, 3, 204, 244),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 25,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 190,
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, bottom: 15, top: 10),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                       
                              ]),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                // onTap: () {
                                //   Navigator.of(context).pushNamed('/profil');
                                // },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      backgroundImage:
                                          AssetImage('assets/images/logo.png'),
                                      radius: 30,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "L.Kena",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Container(
                                        height: 0.2,
                                        color: Colors.grey,
                                        width: 80,
                                      ),
                                    ),
                                    const Text(
                                      "Admin",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 120,
                                width: 1,
                                color: Colors.grey,
                              ),
                                  IconButton(
              icon: Icon(Icons.arrow_circle_right_outlined,size: 33,),
              onPressed: () {
                // Navigate back to the login screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyLogin(),
                    ));
              },
            ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 200,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              // color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/logoWhite.png'))),
                        ),
                        Column(
                          children: [
                            PopupMenuButton(
                            
                                icon: const Icon(LineIcons.verticalEllipsis,
                                    color: Colors.white),
                                itemBuilder: (_) => <PopupMenuItem<String>>[
                                      const PopupMenuItem(

                                          child: Text('Enseignant'),
                                          value: 'List_Enseignant'),
                                      const PopupMenuItem<String>(
                                          child: Text('Salaire'),
                                          value: 'List_Salaire'),
                                      const PopupMenuItem<String>(
                                          child: Text('Rapport'),
                                          value: 'Rapport'),
                        
                                      const PopupMenuItem<String>(
                                          child: Text('Membre du groupe'), value: 'ListGroupe'),
                                    ],
                                onSelected: (value) {
                                  switch (value) {
                                    case 'List_Enseignant':
                                      Navigator.of(context)
                                          .pushNamed('/List_Enseignant');
                                      break;
                                    case 'List_Salaire':
                                      Navigator.of(context)
                                          .pushNamed('/List_Salaire');
                                      break;
                                    case 'Rapport':
                                      Navigator.of(context)
                                          .pushNamed('/Rapport');
                                      break;
                                    case 'ListGroupe':
                                      Navigator.of(context)
                                          .pushNamed('/ListGroupe');
                                      break;
                              
                                

                                    default:
                                  }
                                }),
                            const SizedBox(
                              height: 25,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
 
            ListView.builder(
            physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Update_Enseignant(
                                  userdata[index]["nom"],
                                  userdata[index]["matricule"],
                                  userdata[index]["dateN"],
                                  userdata[index]["id"])));
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: const Icon(LineIcons.userCircle,
                                        size: 35),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              userdata[index]["nom"],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          userdata[index]["dateN"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w200),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(LineIcons.discourse,
                                                    color: Colors.blue,
                                                    size: 15),
                                                SizedBox(width: 5),
                                                Text(
                                                  "Matricule : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(userdata[index]["matricule"]),
                                            SizedBox(
                                              width: ss * 0.22,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    delrecord(
                                                        userdata[index]["id"]);
                                                  },
                                                  child:
                                                      const Icon(Icons.delete)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: AddEnseignant(),
                );
              }).then((value) {});
        },
        backgroundColor:Color.fromARGB(199, 3, 204, 244),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomShapeDetail extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //path.lineTo(0.0, 390.0 - 200);
    path.lineTo(0.0, 140);
    //path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 300, size.width, 140);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
