import 'package:eendigodemo/components/CopyDataComponent/CopyDataBPKB.dart';
import 'package:eendigodemo/model/BPKBModel.dart';
import 'package:flutter/material.dart';

class BPKBRESULTS extends StatelessWidget {
  final List<Bpkbocr> data;
  const BPKBRESULTS({required this.data});

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
          Text('Alamat : ' + data[0].read.alamat),
          Text('Alamat Email : ' + data[0].read.alamatEmail),
          Text('Bahan Bakar : ' + data[0].read.bahanBakar),
          Text('Isi Silinder : ' + data[0].read.isiSilinder),
          Text('Jenis : ' + data[0].read.jenis),
          Text('Jumlah Roda : ' + data[0].read.jumlahRoda),
          Text('Jumlah Sumbu : ' + data[0].read.jumlahSumbu),
          Text('Lok Dikeluarkan : ' + data[0].read.lokDikeluarkan),
          Text('Merk : ' + data[0].read.merk),
          Text('Model : ' + data[0].read.model),
          Text('NIK : ' + data[0].read.nik),
          Text('No BPKB : ' + data[0].read.noBpkb),
          Text('No Mesin : ' + data[0].read.nomorMesin),
          Text('No Rangka : ' + data[0].read.nomorRangka),
          Text('No Registrasi : ' + data[0].read.nomorRegistrasi),
          Text('Pekerjaan : ' + data[0].read.pekerjaan),
          Text('Tanggal Dikeluarkan : ' + data[0].read.tglDikeluarkan),
          Text('Tahun Pembuatan : ' + data[0].read.tahunPembuatan),
          Text('Type : ' + data[0].read.type),
          Text('Warna : ' + data[0].read.warna),
          CopyColumnDataButton(data: data[0].read),
        ],
      )),
    );
  }
}
