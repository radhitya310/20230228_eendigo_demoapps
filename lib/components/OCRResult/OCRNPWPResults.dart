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
      appBar: AppBar(
          title: const Text('Result'),
        ),
      body: Center(
          child: Column(
        children: [
          Text('date : ' + data[0].ocrDate),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          Text('Nama : ' + data[0].read.nama),
          Text('NIK : ' + data[0].read.nik),
          Text('Tanggal lahir : ' + data[0].read.alamat),
          Text('Kewarnegaraan : ' + data[0].read.kpp),
          Text('Tempat Lahir : ' + data[0].read.nama),
          Text('Agama : ' + data[0].read.nik),
          Text('Alamat : ' + data[0].read.noNpwp),
          CopyColumnDataButtonNPWP(data: data[0].read),
        ],
      )),
    );
  }
}
