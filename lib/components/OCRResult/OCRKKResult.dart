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
              Text('alamat : ' + data[0].read.alamat),
              Text('desa kelurahan : ' + data[0].read.desaKelurahan),
              Text('kabupaten kota : ' + data[0].read.kabupatenKota),
              Text('kecamatan : ' + data[0].read.kecamatan),
              Text('Kode Pos : ' + data[0].read.kodePos),
              Text('Nama Kepala Keluarga : ' + data[0].read.namaKepalaKeluarga),
              Text('Nomor Blanko : ' + data[0].read.nomorBlanko),
              Text('Nomor KK : ' + data[0].read.nomorKk),
              Text('Provinsi : ' + data[0].read.provinsi),
              Text('Rt/Rw : ' + data[0].read.rtRw),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Read Confidence'),
              ),
              Text('alamat : ' + data[0].readConfidence.alamat.toString()),
              Text('desa kelurahan : ' +
                  data[0].readConfidence.desaKelurahan.toString()),
              Text('kabupaten kota : ' +
                  data[0].readConfidence.kabupatenKota.toString()),
              Text(
                  'kecamatan : ' + data[0].readConfidence.kecamatan.toString()),
              Text('Kode Pos : ' + data[0].readConfidence.kodePos.toString()),
              Text('Nama Kepala Keluarga : ' +
                  data[0].readConfidence.namaKepalaKeluarga.toString()),
              Text('Nomor Blanko : ' +
                  data[0].readConfidence.nomorBlanko.toString()),
              Text('Nomor KK : ' + data[0].readConfidence.nomorKk.toString()),
              Text('Provinsi : ' + data[0].readConfidence.provinsi.toString()),
              Text('Rt/Rw : ' + data[0].readConfidence.rtRw.toString()),
              Text('Data Keluarga'),
              for (int i = 0; i < data[0].read.table.length; i++) ...{
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Data  ${i + 1}'),
                      Table(
                        border: TableBorder.all(width: 1.0, color: Colors.grey),
                        children: [
                          if (data[0].read.table.isNotEmpty) ...{
                            TableRow(children: [
                              TableCell(child: Text('Parameter')),
                              TableCell(child: Text('Hasil OCR')),
                              TableCell(child: Text('Read Confidence')),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Nama Lengkap')),
                              TableCell(
                                  child:
                                      Text(data[0].read.table[i].namaLengkap)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .namaLengkap_confidence
                                      .toString()))
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Nama Ayah')),
                              TableCell(
                                  child: Text(data[0].read.table[i].namaAyah)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .namaAyah_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Nama Ibu')),
                              TableCell(
                                  child: Text(data[0].read.table[i].namaIbu)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .namaIbu_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Kewarnegaraan')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .kewarganegaraan
                                      .toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .kewarganegaraan_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Pekerjaan')),
                              TableCell(
                                  child: Text(
                                      data[0].read.table[i].jenisPekerjaan)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .jenisPekerjaan_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Hubungan status')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .statusHubunganDalamKeluarga)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .statusHubunganDalamKeluarga_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Agama')),
                              TableCell(
                                  child: Text(
                                      data[0].read.table[i].agama.toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .agama_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('NIK')),
                              TableCell(child: Text(data[0].read.table[i].nik)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .nik_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Tanggal Lahir')),
                              TableCell(
                                  child:
                                      Text(data[0].read.table[i].tanggalLahir)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .tanggalLahir_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Tempat Lahir')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .tempatLahir
                                      .toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .tempatLahir_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Status Perkawinan')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .statusPerkawinan
                                      .toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .statusPerkawinan_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Tanggal Perkawinan')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .tanggalPerkawinan
                                      .toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .tanggalPerkawinan_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('Pendidikan')),
                              TableCell(
                                  child: Text(data[0]
                                      .read
                                      .table[i]
                                      .pendidikan
                                      .toString())),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .pendidikan_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('No Paspor')),
                              TableCell(
                                  child: Text(data[0].read.table[i].noPaspor)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .noPaspor_confidence
                                      .toString())),
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('No Kitas Kitab')),
                              TableCell(
                                  child:
                                      Text(data[0].read.table[i].noKitasKitap)),
                              TableCell(
                                  child: Text(data[0]
                                      .readConfidence
                                      .table2[i]
                                      .noKitasKitap_confidence
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
          )),
        ),
      ),
    );
  }
}
