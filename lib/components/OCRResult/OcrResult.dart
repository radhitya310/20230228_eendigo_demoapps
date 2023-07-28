import 'package:eendigodemo/components/CopyDataComponent/CopyDataKTP.dart';
import 'package:eendigodemo/model/KtpOCRModel.dart';
import 'package:flutter/material.dart';

class OcrResults extends StatelessWidget {
  final List<Ktpocr> data;
  const OcrResults({required this.data});

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
          Text('date : ' + data[0].date),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          Text('Nama : ' + data[0].read.nama),
          Text('NIK : ' + data[0].read.nik),
          Text('Tanggal lahir : ' + data[0].read.tanggalLahir),
          Text('Kewarnegaraan : ' + data[0].read.kewarganegaraan),
          Text('Tempat Lahir : ' + data[0].read.tempatLahir),
          Text('Agama : ' + data[0].read.agama),
          Text('Alamat : ' + data[0].read.alamat),
          Text('Provinsi : ' + data[0].read.provinsi),
          Text('Kecamatan : ' + data[0].read.kecamatan),
          Text('Kelurahan Desa : ' + data[0].read.kelurahanDesa),
          Text('Kota Kabupaten : ' + data[0].read.kotaKabupaten),
          Text('Rt/Rw : ' + data[0].read.rtRw),
          Text('Golongan Darah : ' + data[0].read.golonganDarah),
          Text('Jenis Kelamin : ' + data[0].read.jenisKelamin),
          Text('Pekerjaan : ' + data[0].read.pekerjaan),
          Text('Status Kawin : ' + data[0].read.statusPerkawinan),
          CopyColumnDataButton(data: data[0].read),
        ],
      )),
    );
  }
}
