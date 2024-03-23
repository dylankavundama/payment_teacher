import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';

import 'dart:core';

import 'package:payment_teacher/salaire/ListSalaire.dart';

class AddSalaire extends StatefulWidget {
  const AddSalaire({super.key});
  @override
  State<AddSalaire> createState() => _AddSalaireState();
}

class _AddSalaireState extends State<AddSalaire> {
  // TextEditingController nom = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController site = TextEditingController();
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
    var url = "http://192.168.91.195/payment_teacher/read-enseignant.php";
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
      var url = "http://192.168.91.195/payment_teacher/salaire/add-salaire.php";
      Uri ulr = Uri.parse(url);-

      var reponse = await http.post(ulr, body: {
        "nom": nom.text,
        "cat": idenseu,
        "site": site.text,
        "det": detail.text,
        "tel": tel.text
      });
      if (reponse.statusCode == 200) {
        showToast(msg: "Succes!");
      } else {
        showToast(msg: "Probleme d'insertion!");
      }
    } catch (e) {
      showToast(msg: 'Erreur survenue');
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 800,
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
                DropdownButton(
                  hint: const Text("Selectionner"),
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
                    textHint: "nom",
                    controller: nom,
                    icon: LineIcons.archive,
                    suffixIcon: LineIcons.dollarSign,
                    isNumber: false),
                textField(
                    textHint: "telephone",
                    controller: tel,
                    icon: LineIcons.archive,
                    suffixIcon: LineIcons.dollarSign,
                    isNumber: true),
                textField(
                    textHint: "detail",
                    controller: detail,
                    icon: LineIcons.archive,
                    suffixIcon: LineIcons.dollarSign,
                    isNumber: false),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: site,
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
                    } else if (site.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else if (detail.text.isEmpty &&
                        idenseu.isEmpty &&
                        site.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else {
                      setState(() {
                        _isLoading = true;
                      });
                      savadatas(Salaire(
                        nom: idenseu.trim(),
                        detail: detail.text.trim(),
                        site: site.text.trim(),
                      )).then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => List_Salaire()));
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
        site.text = picked.toString().substring(0, 10);
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
  String? detail;
  String? site;

  Salaire({this.code, this.nom, this.detail, this.site});

  factory Salaire.fromJson(Map<String, dynamic> json) =>
      _$SalaireFromJson(json);
  Map<String, dynamic> toJson() => _$SalaireToJson(this);
}

Salaire _$SalaireFromJson(Map<String, dynamic> json) {
  return Salaire(
      code: json['id'] as int,
      nom: json['nom'] as String,
      site: json['site'] as String,
      detail: json['detail'] as String);
}

Map<String, dynamic> _$SalaireToJson(Salaire instance) => <String, dynamic>{
      'nom': instance.nom,
      'detail': instance.detail,
      'site': instance.site
    };
