import 'package:eendigodemo/components/CopyDataComponent/CopyDataNPWP.dart';
import 'package:eendigodemo/model/NPWPModel.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:flutter/material.dart';

class NPWPResults extends StatelessWidget {
  final List<Npwpocr> data;
  const NPWPResults({required this.data});

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
              Text('date : ' + data[0].ocrDate,),
              Text('message : ' + data[0].message,),
              Text('status : ' + data[0].status),
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
                                child: Text('Nama Lengkap',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nama,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.nama.toString(),),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('NIK'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nik,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].readConfidence.nik.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('KPP'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.kpp,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].readConfidence.kpp.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No NPWP',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.noNpwp,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.noNpwp.toString(),),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tempat Lahir',),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.alamat,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.alamat.toString(),),
                              )),
                            ]),
                          }
                        ],
                      ),
                    ],
                  ),
                )
              },
              CopyColumnDataButtonNPWP(data: data[0].read),
            ],
          )),
        ),
      ),
    );
  }
}