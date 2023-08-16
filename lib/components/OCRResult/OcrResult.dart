import 'package:eendigodemo/components/CopyDataComponent/CopyDataKTP.dart';
import 'package:eendigodemo/model/KtpOCRModel.dart';
import 'package:flutter/material.dart';

class OcrResults extends StatelessWidget {
  final List<Ktpocr> data;
  const OcrResults({required this.data});

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
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('date : ' + data[0].date),
              Text('message : ' + data[0].message),
              Text('status : ' + data[0].status),
              Text('Data KTP'),
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
                                  child: Text(
                                      data[i].readConfidence.nama.toString()))
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('NIK')),
                              TableCell(child: Text(data[i].read.nik)),
                              TableCell(
                                  child: Text(
                                      data[i].readConfidence.nik.toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Tanggal Lahir')),
                              TableCell(child: Text(data[i].read.tanggalLahir)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .tanggalLahir
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Kewarnegaraan')),
                              TableCell(
                                  child: Text(data[i].read.kewarganegaraan)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .kewarganegaraan
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Tempat Lahir')),
                              TableCell(child: Text(data[i].read.tempatLahir)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .tempatLahir
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Agama')),
                              TableCell(child: Text(data[i].read.agama)),
                              TableCell(
                                  child: Text(
                                      data[i].readConfidence.agama.toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Alamat')),
                              TableCell(child: Text(data[i].read.alamat)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .alamat
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Provinsi')),
                              TableCell(child: Text(data[i].read.provinsi)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .provinsi
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Kecamatan')),
                              TableCell(child: Text(data[i].read.kecamatan)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .kecamatan
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Kelurahan Desa')),
                              TableCell(
                                  child: Text(data[i].read.kelurahanDesa)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .kelurahanDesa
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Kota Kabupaten')),
                              TableCell(
                                  child: Text(data[i].read.kotaKabupaten)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .kotaKabupaten
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Rt.Rw')),
                              TableCell(child: Text(data[i].read.rtRw)),
                              TableCell(
                                  child: Text(
                                      data[i].readConfidence.rtRw.toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Golongan Darah')),
                              TableCell(
                                  child: Text(data[i].read.golonganDarah)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .golonganDarah
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Jenis Kelamin')),
                              TableCell(child: Text(data[i].read.jenisKelamin)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .jenisKelamin
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Pekerjaan')),
                              TableCell(child: Text(data[i].read.pekerjaan)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .pekerjaan
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Status Kawin')),
                              TableCell(
                                  child: Text(data[i].read.statusPerkawinan)),
                              TableCell(
                                  child: Text(data[i]
                                      .readConfidence
                                      .statusPerkawinan
                                      .toString())),
                            ]),
                          }
                        ],
                      ),
                    ],
                  ),
                )
              }
            ],
          ),
        )),
      ),
    );
  }
}
