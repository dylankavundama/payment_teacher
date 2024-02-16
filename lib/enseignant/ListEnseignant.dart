import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payment_teacher/enseignant/Ajouter.dart';

import 'package:line_icons/line_icons.dart';
import 'package:payment_teacher/enseignant/UpdateEnseignant.dart';

// ignore: camel_case_types
class List_Enseignant extends StatefulWidget {
  const List_Enseignant({super.key});
  @override
  State<List_Enseignant> createState() => _List_EnseignantState();
}

class _List_EnseignantState extends State<List_Enseignant> {
  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      var url = "http://192.168.1.66/payment_teacher/delete-enseignant.php";
      var result = await http.post(Uri.parse(url), body: {"id": id});
      var reponse = jsonDecode(result.body);
      if (reponse["Success"] == "True") {
        print("record deleted");
        getrecord();
      } else {
        print("Erreur de suppression");
        getrecord();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    var url = "http://192.168.1.66/payment_teacher/read-enseignant.php";
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
      appBar: AppBar(
        title: const Text("Enseignant"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            onPressed: () {
              //     showSearch(context: context,delegate: ClientSearchDelegate(),);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ListView.builder(
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
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                              child: Icon(LineIcons.userCircle, size: 35),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //   child:

                                  Row(
                                    children: [
                                      Text(
                                        userdata[index]["nom"],
                                      ),
                                    ],
                                  ),

                                  Text(
                                    userdata[index]["dateN"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w200),
                                  ),
                                  // ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(LineIcons.discourse,
                                              color: Colors.blue, size: 15),
                                          SizedBox(width: 5),
                                          Text(
                                            "Matricule : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      ),

                                      //  Icon(LineIcons.arrowRight, size: 12),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(userdata[index]["matricule"]),

                                      SizedBox(
                                        width: ss * 0.22,
                                        child: GestureDetector(
                                            onTap: () {
                                              delrecord(userdata[index]["id"]);
                                            },
                                            child: Icon(Icons.delete)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: AddEnseignant(),
                );
              }).then((value) {
            // _bloc.add(BlocEventFetch());
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}