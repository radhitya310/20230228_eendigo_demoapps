import 'package:eendigodemo/components/CopyDataComponent/CopyDataNPWP.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/model/NPWPModel.dart';
import 'package:eendigodemo/model/PasporOCRModel.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
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
        appBar: EendigoLogo(context),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('date : ' + data[0].ocrDate!),
              Text('message : ' + data[0].message!,),
              Text('status : ' + data[0].status!),
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
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Hasil OCR',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Read Confidence',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nama Depan',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.name!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.name.toString(),),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nama Belakang',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.surname!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.surname.toString(),),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('Mrz'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.mrz!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.mrz.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Gender',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.gender!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.gender.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Date Birth',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.dateBirth!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.dateBirth.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Date Expire',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.dateExpire!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.dateExpire.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nationality',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nationality!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.nationality.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Country',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.country!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.country.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Passport No',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.passportNo!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.passportNo.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Passport Type',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.passportType!,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .passportType
                                        .toString(),),
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
      ),
    );
  }
}
