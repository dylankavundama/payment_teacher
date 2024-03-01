import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:payment_teacher/mb.dart';
import 'package:payment_teacher/salaire/AjouterSalaire.dart';
import 'package:payment_teacher/salaire/UpdateSalaire.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

// ignore: camel_case_types
class List_Salaire extends StatefulWidget {
  const List_Salaire({super.key});
  @override
  State<List_Salaire> createState() => _List_SalaireState();
}

// ignore: camel_case_types
class _List_SalaireState extends State<List_Salaire> {
  //rapport

  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      var url =
          "https://royalrisingplus.com/payment_teacher/salaire/delete-Salaire.php";
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
    var url = "https://royalrisingplus.com/payment_teacher/readvie.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        userdata = jsonDecode(response.body);
        print(userdata);
      });
    } catch (e) {
      print(e);
    }
  }
// List<String> items = List.generate(10, (index) => "Item ${index + 1}");

  @override
  void initState() {
    // TODO: implement initState
    getrecord();
    getrecords();
    print(userdatas);
    //print(getrecord);
    super.initState();
  }

  List userdatas = [];

  Future<List<dynamic>> getrecords() async {
    var url = "https://royalrisingplus.com/payment_teacher/readvie.php";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> userdatas = jsonDecode(response.body);
        return userdatas; // Return the list
      } else {
        // Handle non-200 status code
        print("Error: ${response.statusCode}");
        return []; // Return an empty list on error
      }
    } catch (e) {
      print(e);
      return []; // Return an empty list on error
    }
  }

  Future<void> _createPDF(
      String date, String nom, String code, Future<List<dynamic>> data) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
      'Voici votre programme \n Nom:$nom \n Date:$date \n Code:$code  ',
      PdfStandardFont(PdfFontFamily.helvetica, 50),
    );

    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Nom: $nom',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );
    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Date: $date',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );
    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Code: $code',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );

    // page.graphics.drawImage(
    //     PdfBitmap(await _readImageData('Pdf_Succinctly.jpg')),
    //     Rect.fromLTWH(0, 100, 440, 550));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
    List<dynamic> records = await getrecords();
    grid.columns.add(count: records.length);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll No';
    header.cells[1].value = 'Name';
    header.cells[2].value = 'Montant';
    header.cells[3].value = 'Date';

    for (var i = 0; i < records.length; i++) {
      var transaction = records[i];

      PdfGridRow row = grid.rows.add();
      row.cells[0].value = transaction['id'];
      row.cells[1].value = transaction['name'];
      row.cells[2].value = transaction['montant'];
      row.cells[3].value = transaction['dateP'];
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'rapport${DateTime.now()}.pdf');
  }

  Future<void> _createPDFe(String date, String nom, String code) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
      'Voici votre programme \n Nom:$nom \n Date:$date \n Code:$code  ',
      PdfStandardFont(PdfFontFamily.helvetica, 50),
    );
    page.graphics.drawString(
      'Voici votre programme \n Nom:$nom \n Date:$date \n Code:$code  ',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
    );
    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Nom: $nom',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );
    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Date: $date',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );
    // const SizedBox(height: 12,);
    // page.graphics.drawString('\n Code: $code',
    // PdfStandardFont(PdfFontFamily.helvetica, 17),

    // );

    // page.graphics.drawImage(
    //     PdfBitmap(await _readImageData('Pdf_Succinctly.jpg')),
    //     Rect.fromLTWH(0, 100, 440, 550));

    List dy = [
      ["dylan", "travai", "tp"],
      [
        ["jp", "travai", "tp"],
      ],
      ["el", "travai", "tp"]
    ];

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: dy.length);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Roll No';
    header.cells[1].value = 'Name';
    header.cells[2].value = 'Class';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = dy[0][0];
    row.cells[1].value = dy[0][1];
    row.cells[2].value = dy[0][1];

    // for (var i = 0; i < dy.length; i++) {
    //   var transaction = dy[i];

    //   PdfGridRow row = grid.rows.add();
    //   row.cells[0].value = dy[0][0];
    //   row.cells[1].value = dy[0][1];
    //   row.cells[2].value = dy[0][1];
    //   // row.cells[i + 1].value = transaction['name'];
    //   // row.cells[i + 2].value = transaction['montant'];
    //   // row.cells[i + 3].value = transaction['dateP'];
    // }

    for (var i = 0; i < userdatas.length; i++) {
      var transaction = userdatas[i];

      PdfGridRow row = grid.rows.add();
      row.cells[0].value = transaction['id'];
      row.cells[1].value = transaction['name'];
      row.cells[2].value = transaction['montant'];
      // row.cells[i + 3].value = transaction['dateP'];
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'rapportr.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salaire"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(199, 3, 204, 244),
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
                    builder: (context) => UpdateSalaire(
                        userdata[index]["nom"],
                        userdata[index]["montant"],
                        userdata[index]["dateP"],
                        userdata[index]["id"]),
                  ),
                );
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: const Icon(LineIcons.userCircle, size: 35),
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
                                  Row(
                                    children: [
                                      Text(
                                        userdata[index]["name"],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userdata[index]["dateP"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w200),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(LineIcons.discourse,
                                              color: Colors.blue, size: 15),
                                          SizedBox(width: 5),
                                          Text(
                                            "montant : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(userdata[index]["montant"]),
                                      Text('\$'),
                                      // SizedBox(
                                      //   width: ss * 0.11,
                                      //   child: GestureDetector(
                                      //       onTap: () {
                                      //         delrecord(userdata[index]["id"]);
                                      //       },
                                      //       child: const Icon(Icons.delete)),
                                      // ),
                                      SizedBox(
                                        width: ss * 0.22,
                                        child: GestureDetector(
                                          onTap: () {
                                            _createPDF(
                                              userdata[index]["name"],
                                              userdata[index]["dateP"],
                                              userdata[index]["dateP"],
                                              getrecords(),
                                            );
                                          },
                                          child: const Icon(Icons.print),
                                        ),
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
                return const Center(
                  child: AddSalaire(),
                );
              }).then((value) {});
        },
        backgroundColor: Color.fromARGB(199, 3, 204, 244),
        child: const Icon(Icons.add),
      ),
    );
  }
}
