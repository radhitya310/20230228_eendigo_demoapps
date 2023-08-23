import 'package:eendigodemo/model/KKOCRModel.dart' as KK;
import 'package:flutter/material.dart';

class OcrKKResults extends StatelessWidget {
  final List<KK.Kkocr> data;
  const OcrKKResults({required this.data});

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
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Text('alamat : ' + data[0].read.alamat,
                  style: TextStyle(fontSize: 24)),
              Text('desa kelurahan : ' + data[0].read.desaKelurahan,
                  style: TextStyle(fontSize: 24)),
              Text('kabupaten kota : ' + data[0].read.kabupatenKota,
                  style: TextStyle(fontSize: 24)),
              Text('kecamatan : ' + data[0].read.kecamatan,
                  style: TextStyle(fontSize: 24)),
              Text('Kode Pos : ' + data[0].read.kodePos,
                  style: TextStyle(fontSize: 24)),
              Text('Nama Kepala Keluarga : ' + data[0].read.namaKepalaKeluarga,
                  style: TextStyle(fontSize: 24)),
              Text('Nomor Blanko : ' + data[0].read.nomorBlanko,
                  style: TextStyle(fontSize: 24)),
              Text('Nomor KK : ' + data[0].read.nomorKk,
                  style: TextStyle(fontSize: 24)),
              Text('Provinsi : ' + data[0].read.provinsi,
                  style: TextStyle(fontSize: 24)),
              Text('Rt/Rw : ' + data[0].read.rtRw,
                  style: TextStyle(fontSize: 24)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Read Confidence', style: TextStyle(fontSize: 24)),
              ),
              Text('alamat : ' + data[0].readConfidence.alamat.toString(),
                  style: TextStyle(fontSize: 24)),
              Text(
                  'desa kelurahan : ' +
                      data[0].readConfidence.desaKelurahan.toString(),
                  style: TextStyle(fontSize: 24)),
              Text(
                  'kabupaten kota : ' +
                      data[0].readConfidence.kabupatenKota.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('kecamatan : ' + data[0].readConfidence.kecamatan.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('Kode Pos : ' + data[0].readConfidence.kodePos.toString(),
                  style: TextStyle(fontSize: 24)),
              Text(
                  'Nama Kepala Keluarga : ' +
                      data[0].readConfidence.namaKepalaKeluarga.toString(),
                  style: TextStyle(fontSize: 24)),
              Text(
                  'Nomor Blanko : ' +
                      data[0].readConfidence.nomorBlanko.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('Nomor KK : ' + data[0].readConfidence.nomorKk.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('Provinsi : ' + data[0].readConfidence.provinsi.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('Rt/Rw : ' + data[0].readConfidence.rtRw.toString(),
                  style: TextStyle(fontSize: 24)),
              Text('Data Keluarga', style: TextStyle(fontSize: 24)),
              for (int i = 0; i < data[0].read.table.length; i++) ...{
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Data  ${i + 1}', style: TextStyle(fontSize: 24)),
                      Table(
                        border: TableBorder.all(width: 1.0, color: Colors.grey),
                        children: [
                          if (data[0].read.table.isNotEmpty) ...{
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
                                child: Text(data[0].read.table[i].namaLengkap,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .namaLengkap_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nama Ayah',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[0].read.table[i].namaAyah,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .namaAyah_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Nama Ibu',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[0].read.table[i].namaIbu,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .namaIbu_confidence
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
                                child: Text(
                                    data[0]
                                        .read
                                        .table[i]
                                        .kewarganegaraan
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .kewarganegaraan_confidence
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
                                child: Text(
                                    data[0].read.table[i].jenisPekerjaan,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .jenisPekerjaan_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Text('Hubungan status',
                                      style: TextStyle(fontSize: 24))),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .read
                                        .table[i]
                                        .statusHubunganDalamKeluarga,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .statusHubunganDalamKeluarga_confidence
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
                                child: Text(
                                    data[0].read.table[i].agama.toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .agama_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
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
                                child: Text(data[0].read.table[i].nik,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .nik_confidence
                                        .toString(),
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
                                child: Text(data[0].read.table[i].tanggalLahir,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .tanggalLahir_confidence
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
                                child: Text(
                                    data[0]
                                        .read
                                        .table[i]
                                        .tempatLahir
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .tempatLahir_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Status Perkawinan',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .read
                                        .table[i]
                                        .statusPerkawinan
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .statusPerkawinan_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tanggal Perkawinan',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .read
                                        .table[i]
                                        .tanggalPerkawinan
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .tanggalPerkawinan_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Pendidikan',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0].read.table[i].pendidikan.toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .pendidikan_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Paspor',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[0].read.table[i].noPaspor,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .noPaspor_confidence
                                        .toString(),
                                    style: TextStyle(fontSize: 24)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Kitas Kitab',
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[0].read.table[i].noKitasKitap,
                                    style: TextStyle(fontSize: 24)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[0]
                                        .readConfidence
                                        .table2[i]
                                        .noKitasKitap_confidence
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
          )),
        ),
      ),
    );
  }
}
