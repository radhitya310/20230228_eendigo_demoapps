import 'package:eendigodemo/components/CopyDataComponent/CopyDataNPWP.dart';
import 'package:eendigodemo/model/NPWPModel.dart';
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
            Text('date : ' + data[0].ocrDate, style: TextStyle(fontSize: 24)),
            Text('message : ' + data[0].message,
                style: TextStyle(fontSize: 24)),
            Text('status : ' + data[0].status, style: TextStyle(fontSize: 24)),
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
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Hasil OCR',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Read Confidence',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Nama Lengkap',
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.nama,
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.nama.toString(),
                                  style: TextStyle(fontSize: 24)),
                            ))
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('NIK', style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.nik,
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].readConfidence.nik.toString(),
                                  style: TextStyle(fontSize: 24)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text('KPP', style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.kpp,
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].readConfidence.kpp.toString(),
                                  style: TextStyle(fontSize: 24)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No NPWP',
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.noNpwp,
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.noNpwp.toString(),
                                  style: TextStyle(fontSize: 24)),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Tempat Lahir',
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[i].read.alamat,
                                  style: TextStyle(fontSize: 24)),
                            )),
                            TableCell(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  data[i].readConfidence.alamat.toString(),
                                  style: TextStyle(fontSize: 24)),
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
    );
  }
}
