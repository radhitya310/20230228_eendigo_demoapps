import 'package:eendigodemo/components/CopyDataComponent/CopyDataNPWP.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/model/NPWPModel.dart';
import 'package:eendigodemo/model/PasporOCRModel.dart';
import 'package:flutter/material.dart';

class PASPORresult extends StatelessWidget {
  final List<OcrPaspor> data;
  const PASPORresult({required this.data});

  // final List<Widget> data1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/img/background-eendigo_(1).png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Assets/icons/logo-eendigo-trial.png',
                      fit: BoxFit.contain),
                ],
              ),
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('date : ' + data[0].ocrDate, style: TextStyle(fontSize: 14)),
            Text('message : ' + data[0].message,
                style: TextStyle(fontSize: 14)),
            Text('status : ' + data[0].status, style: TextStyle(fontSize: 14)),
            for (int i = 0; i < data.length; i++) ...{
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(width: 1.0, color: Colors.grey),
                      children: [
                        if (data.isNotEmpty) ...{
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Parameter',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Hasil OCR',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Read Confidence',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Nama Depan',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.name,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.name.toString(),
                                  style: TextStyle(fontSize: 14)),
                            ))
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Nama Belakang',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.surname,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.surname.toString(),
                                  style: TextStyle(fontSize: 14)),
                            ))
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('Id No', style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.idNo,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.idNo.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Gender',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.gender,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.gender.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Date Birth',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.dateBirth,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.dateBirth.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Date Expire',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.dateExpire,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.dateExpire.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Nationality',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.nationality,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.nationality.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Country',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.country,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.country.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Passport No',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.passportNo,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.passportNo.toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Passport Type',
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.passportType,
                                  style: TextStyle(fontSize: 14)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i]
                                      .readConfidence
                                      .passportType
                                      .toString(),
                                  style: TextStyle(fontSize: 14)),
                            )),
                          ]),
                        }
                      ],
                    ),
                  ],
                ),
              )
            },
          ],
        )),
      ),
    );
  }
}
