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
    return Scaffold(
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
          Text('date : ' + data[0].ocrDate),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          for (int i = 0; i < data.length; i++) ...{
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Data  ${i + 1}'),
                  Table(
                    border: TableBorder.all(width: 1.0, color: Colors.grey),
                    children: [
                      if (data.isNotEmpty) ...{
                        TableRow(children: [
                          TableCell(child: Text('Parameter')),
                          TableCell(child: Text('Hasil OCR')),
                          TableCell(child: Text('Read Confidence')),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Nama Depan')),
                          TableCell(child: Text(data[i].read.name)),
                          TableCell(
                              child:
                                  Text(data[i].readConfidence.name.toString()))
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Nama Belakang')),
                          TableCell(child: Text(data[i].read.surname)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.surname.toString()))
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Id No')),
                          TableCell(child: Text(data[i].read.idNo)),
                          TableCell(
                              child:
                                  Text(data[i].readConfidence.idNo.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Date Birth')),
                          TableCell(child: Text(data[i].read.dateBirth)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.dateBirth.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Passport No')),
                          TableCell(child: Text(data[i].read.dateBirth)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.dateBirth.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Passport No')),
                          TableCell(child: Text(data[i].read.dateExpire)),
                          TableCell(
                              child: Text(data[i]
                                  .readConfidence
                                  .dateExpire
                                  .toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Nationality')),
                          TableCell(child: Text(data[i].read.nationality)),
                          TableCell(
                              child: Text(data[i]
                                  .readConfidence
                                  .nationality
                                  .toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Country')),
                          TableCell(child: Text(data[i].read.country)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.country.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Passport No')),
                          TableCell(child: Text(data[i].read.passportNo)),
                          TableCell(
                              child: Text(data[i]
                                  .readConfidence
                                  .passportNo
                                  .toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Passport Type')),
                          TableCell(child: Text(data[i].read.passportType)),
                          TableCell(
                              child: Text(data[i]
                                  .readConfidence
                                  .passportType
                                  .toString())),
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
    );
  }
}
