import 'package:eendigodemo/components/CopyDataComponent/CopyDataNPWP.dart';
import 'package:eendigodemo/model/NPWPModel.dart';
import 'package:flutter/material.dart';

class NPWPResults extends StatelessWidget {
  final List<Npwpocr> data;
  const NPWPResults({required this.data});

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
                          TableCell(child: Text('Nama Lengkap')),
                          TableCell(child: Text(data[i].read.nama)),
                          TableCell(
                              child:
                                  Text(data[i].readConfidence.nama.toString()))
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('NIK')),
                          TableCell(child: Text(data[i].read.nik)),
                          TableCell(
                              child:
                                  Text(data[i].readConfidence.nik.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('KPP')),
                          TableCell(child: Text(data[i].read.kpp)),
                          TableCell(
                              child:
                                  Text(data[i].readConfidence.kpp.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('No NPWP')),
                          TableCell(child: Text(data[i].read.noNpwp)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.noNpwp.toString())),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Tempat Lahir')),
                          TableCell(child: Text(data[i].read.alamat)),
                          TableCell(
                              child: Text(
                                  data[i].readConfidence.alamat.toString())),
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
    );
  }
}
