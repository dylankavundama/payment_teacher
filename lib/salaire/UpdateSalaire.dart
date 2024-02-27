import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payment_teacher/salaire/ListSalaire.dart';


// ignore: must_be_immutable, camel_case_types
class UpdateSalaire extends StatefulWidget {
  String id;
  String nom;
  String montant;
  String dateP;
  UpdateSalaire(this.nom, this.montant, this.dateP, this.id, {super.key});

  @override
  State<UpdateSalaire> createState() => _UpdateSalaireState();
}

// ignore: camel_case_types
class _UpdateSalaireState extends State<UpdateSalaire> {
  String mat = "";
  TextEditingController txtnom = TextEditingController();
  TextEditingController montant = TextEditingController();
  TextEditingController dateP = TextEditingController();

  Future<void> update() async {
    try {
      var url = "https://royalrisingplus.com/payment_teacher/salaire/update_salaire.php";

      var res = await http.post(Uri.parse(url), body: {
        "nom": txtnom.text,
        "montant": montant.text,
        "dateP": dateP.text,
        "id": widget.id
      });
      debugPrint(widget.id);
      var repoe = jsonDecode(res.body);

      if (repoe["Success"] == "True") {
        debugPrint("record updated");
      } else {
        debugPrint("Error on update");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    montant.text = widget.montant;
    dateP.text = widget.dateP;
    txtnom.text = widget.nom;
    mat = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: txtnom,
              decoration: const InputDecoration(hintText: "", labelText: "Nom"),
            ),
            TextField(
              controller: montant,
              decoration:
                  const InputDecoration(hintText: "", labelText: "montant"),
            ),
            TextField(
              onTap: () => _selectDate(context),
              controller: dateP,
              decoration: const InputDecoration(
                  hintText: "Votre dateP", labelText: "dateP"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MaterialButton(
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: const Color.fromARGB(199, 3, 204, 244),
                onPressed: () {
                  update();
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => List_Salaire()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Confirmer"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateP.text = picked.toString().substring(0, 10);
      });
    }
  }
}
