import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:payment_teacher/enseignant/ListEnseignant.dart';

class AddEnseignant extends StatefulWidget {
  const AddEnseignant({super.key});

  @override
  State<AddEnseignant> createState() => _AddEnseignantState();
}

class _AddEnseignantState extends State<AddEnseignant> {
  TextEditingController nom = TextEditingController();
  TextEditingController matricule = TextEditingController();
  TextEditingController dateN = TextEditingController();
  @override
  void initState() {
    super.initState();
    // _init();
  }

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

  Future<void> savadatas(Enseignant enseignant) async {
    try {
      var url = "http://192.168.1.66/payment_teacher/add-enseignant.php";
      Uri ulr = Uri.parse(url);

      await http.post(ulr, body: {
        "nom": nom.text,
        "matricule": matricule.text,
        "dateN": dateN.text
      });
      showToast(msg: "Client informations saved");
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(LineIcons.userCircle, color: Colors.blue, size: 80),
                textField(
                  textHint: "Nom ",
                  controller: nom,
                  icon: LineIcons.user,
                  isName: true,
                ),
                textField(
                    textHint: "Matricule",
                    controller: matricule,
                    icon: LineIcons.archive,
                    isNumber: true),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: dateN,
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
                    if (nom.text.isEmpty) {
                      showToast(msg: "y'a une case vide");
                    } else if (dateN.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else if (matricule.text.isEmpty &&
                        nom.text.isEmpty &&
                        dateN.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else if (matricule.text.length != 8) {
                      showToast(
                          msg:
                              "Le numero de matricule doit avoir 8 caractères");
                    } else {
                      setState(() {
                        _isLoading = true;
                      });
                      savadatas(Enseignant(
                        //   code: matricule.text.trim(),
                        nom: nom.text.trim(),
                        matricule: matricule.text.trim(),
                        dateN: dateN.text.trim(),
                      )).then((value) {
                        // Navigator.of(context).pop('saved');
                        Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const List_Enseignant()),
                          (Route<dynamic> route) => false,
                        );
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
        dateN.text = picked.toString().substring(0, 10);
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
                border: InputBorder.none,
                prefixIcon: Icon(icon),
                suffixIcon: isName != null
                    ? IconButton(
                        icon: Icon(suffixIcon),
                        onPressed: onPressed,
                      )
                    : null,
              )),
        ),
      )
    ],
  );
}

class Enseignant {
  int? code;
  String? nom;
  String? matricule;
  String? dateN;

  Enseignant({this.code, this.nom, this.matricule, this.dateN});

  factory Enseignant.fromJson(Map<String, dynamic> json) =>
      _$EnseignantFromJson(json);
  Map<String, dynamic> toJson() => _$EnseignantToJson(this);
}

Enseignant _$EnseignantFromJson(Map<String, dynamic> json) {
  return Enseignant(
      code: json['id'] as int,
      nom: json['nom'] as String,
      dateN: json['dateN'] as String,
      matricule: json['matricule'] as String);
}

Map<String, dynamic> _$EnseignantToJson(Enseignant instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'matricule': instance.matricule,
      'dateN': instance.dateN
    };
