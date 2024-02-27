import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:payment_teacher/Homepage.dart';
import 'dart:core';
import 'ListSalaire.dart';

class AddSalaire extends StatefulWidget {
  const AddSalaire({super.key});
  @override
  State<AddSalaire> createState() => _AddSalaireState();
}

class _AddSalaireState extends State<AddSalaire> {
  // TextEditingController nom = TextEditingController();
  TextEditingController montant = TextEditingController();
  TextEditingController dateP = TextEditingController();
  @override
  void initState() {
    getrecord();
    super.initState();
  }

  late String idenseu;
  var selectens;

  bool _isNumeric(String value) {
    try {
      double result = double.parse(value);
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  showToast({required String msg}) {
    return Fluttertoast.showToast(msg: msg);
  }

  List dataens = [];
  Future<void> getrecord() async {
    var url = "https://royalrisingplus.com/payment_teacher/read-enseignant.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        dataens = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> savadatas(Salaire Salaire) async {
    try {
      var url = "https://royalrisingplus.com/payment_teacher/salaire/add-salaire.php";
      Uri ulr = Uri.parse(url);

      await http.post(ulr,
          body: {"nom": idenseu, "montant": montant.text, "dateP": dateP.text});
      showToast(msg: "Succes!");
    } catch (e) {
      showToast(msg: 'Erreur survenue');
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 550,
        padding: EdgeInsets.all(20.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.attach_money_sharp,
                    color: Colors.blue, size: 80),
                // textField(
                //   textHint: "Nom ",
                //   controller: nom,
                //   icon: LineIcons.user,
                //   isName: true,
                // ),
                DropdownButton(
                  hint: Text("ensi"),
                  items: dataens.map((list) {
                    return DropdownMenuItem(
                      value: list["id"],
                      child: Text(list["nom"]),
                    );
                  }).toList(),
                  value: selectens,
                  onChanged: (value) {
                    selectens = value;
                    idenseu = selectens;
                    print("la vealuur: " + selectens);
                    setState(() {});
                  },
                ),
                textField(
                    textHint: "montant",
                    controller: montant,
                    icon: LineIcons.archive,
                    suffixIcon: LineIcons.dollarSign,
                    isNumber: true),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: dateP,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(
                    hintText: 'Select Date',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
                MaterialButton(
                  minWidth: double.maxFinite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue[800],
                  onPressed: () {
                    if (idenseu.isEmpty) {
                      showToast(msg: "y'a une case vide");
                    } else if (dateP.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else if (montant.text.isEmpty &&
                        idenseu.isEmpty &&
                        dateP.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else {
                      setState(() {
                        _isLoading = true;
                      });
                      savadatas(Salaire(
                        nom: idenseu.trim(),
                        montant: montant.text.trim(),
                        dateP: dateP.text.trim(),
                      )).then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }).whenComplete(() {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Enregistrer",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
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

Widget textField(
    {String? textHint,
    onTap,
    TextEditingController? controller,
    bool? enabled,
    bool? isNumber,
    IconData? icon,
    bool? readOnly,
    VoidCallback? func,
    bool? isName,
    IconData? suffixIcon,
    VoidCallback? onPressed,
    VoidCallback? KboardType,
    VoidCallback? onChange}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text("$textHint"),
      ),
      Container(
        height: 50.0,
        margin: const EdgeInsets.only(top: 5.0),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: TextFormField(
            readOnly: readOnly != true ? false : true,
            onTap: func,
            keyboardType: isNumber == null
                ? TextInputType.text
                : const TextInputType.numberWithOptions(),
            enabled: enabled ?? true,
            controller: controller,
            decoration: InputDecoration(
              hintText: textHint,
              border: InputBorder.none,
              prefixIcon: Icon(icon),
              suffixIcon: isName != null
                  ? IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onPressed,
                    )
                  : null,
            ),
          ),
        ),
      )
    ],
  );
}

class Salaire {
  int? code;
  String? nom;
  String? montant;
  String? dateP;

  Salaire({this.code, this.nom, this.montant, this.dateP});

  factory Salaire.fromJson(Map<String, dynamic> json) =>
      _$SalaireFromJson(json);
  Map<String, dynamic> toJson() => _$SalaireToJson(this);
}

Salaire _$SalaireFromJson(Map<String, dynamic> json) {
  return Salaire(
      code: json['id'] as int,
      nom: json['nom'] as String,
      dateP: json['dateP'] as String,
      montant: json['montant'] as String);
}

Map<String, dynamic> _$SalaireToJson(Salaire instance) => <String, dynamic>{
      'nom': instance.nom,
      'montant': instance.montant,
      'dateP': instance.dateP
    };
