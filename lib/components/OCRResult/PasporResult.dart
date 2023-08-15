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
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
          child: Column(
        children: [
          Text('date : ' + data[0].ocrDate),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          Text('Nama Depan : ' + data[0].read.name),
          Text('Nama Belakang : ' + data[0].read.surname),
          Text('Id No : ' + data[0].read.idNo),
          Text('Tanggal lahir : ' + data[0].read.dateBirth),
          Text('Gender : ' + data[0].read.gender),
          Text('Kewarnegaraan : ' + data[0].read.nationality),
          Text('Tangggal Expire : ' + data[0].read.dateExpire),
          Text('Passport No : ' + data[0].read.passportNo),
          Text('Passport Date : ' + data[0].read.passportType),
          // CopyColumnDataButtonNPWP(data: data[0].read),
        ],
      )),
    );
  }
}
