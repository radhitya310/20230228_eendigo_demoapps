import 'package:eendigodemo/model/KtpOCRModel.dart';
import 'package:flutter/material.dart';

class OcrResults extends StatelessWidget {
  final List<Ktpocr> data;
  const OcrResults({required this.data});

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
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('date : ' + data[0].date, style: TextStyle(fontSize: 24)),
                Text('message : ' + data[0].message,
                    style: TextStyle(fontSize: 24)),
                Text('status : ' + data[0].status,
                    style: TextStyle(fontSize: 24)),
                Text('Data KTP', style: TextStyle(fontSize: 24)),
                for (int i = 0; i < data.length; i++) ...{
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Table(
                          border:
                              TableBorder.all(width: 1.0, color: Colors.grey),
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
                                  child: Text('NIK',
                                      style: TextStyle(fontSize: 24)),
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
                                  child: Text(
                                      data[i].readConfidence.nik.toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Tanggal Lahir',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.tanggalLahir,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .tanggalLahir
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Kewarnegaraan',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.kewarganegaraan,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .kewarganegaraan
                                          .toString(),
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
                                  child: Text(data[i].read.tempatLahir,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .tempatLahir
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Agama',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.agama,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i].readConfidence.agama.toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Alamat',
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
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Provinsi',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.provinsi,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .provinsi
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Kecamatan',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.kecamatan,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .kecamatan
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Kelurahan Desa',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.kelurahanDesa,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .kelurahanDesa
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Kota Kabupaten',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.kotaKabupaten,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .kotaKabupaten
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Rt.Rw',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.rtRw,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i].readConfidence.rtRw.toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Golongan Darah',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.golonganDarah,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .golonganDarah
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Jenis Kelamin',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.jenisKelamin,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .jenisKelamin
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Pekerjaan',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.pekerjaan,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .pekerjaan
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Status Kawin',
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[i].read.statusPerkawinan,
                                      style: TextStyle(fontSize: 24)),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      data[i]
                                          .readConfidence
                                          .statusPerkawinan
                                          .toString(),
                                      style: TextStyle(fontSize: 24)),
                                )),
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
      ),
    );
  }
}
