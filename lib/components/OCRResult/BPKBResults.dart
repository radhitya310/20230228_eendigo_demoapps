import 'package:eendigodemo/model/BPKBModel.dart';
import 'package:flutter/material.dart';

class BPKBRESULTS extends StatelessWidget {
  final List<Bpkbocr> data;
  const BPKBRESULTS({required this.data});

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
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('date : ' + data[0].ocrDate, style: TextStyle(fontSize: 14)),
              Text('message : ' + data[0].message,
                  style: TextStyle(fontSize: 14)),
              Text('status : ' + data[0].status,
                  style: TextStyle(fontSize: 14)),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Hasil OCR',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Read Confidence',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('NIK', style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nik,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.nik.toString(),
                                    style: TextStyle(fontSize: 14)),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Pemilik',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.pemilik,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.pemilik.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Pekerjaan',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.merk,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.merk.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Alamat',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.alamat,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.alamat.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Lok Dikeluarkan',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.lokDikeluarkan,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .lokDikeluarkan
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No BPKB',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.noBpkb,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.noBpkb.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Mesin',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorMesin,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorMesin
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Rangka',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorRangka,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorRangka
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Registrasi',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorRegistrasi,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorRegistrasi
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Merek',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.merk,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.merk.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Model',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.model,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.model.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Type',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.type,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.type.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Warna',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.warna,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.warna.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jumlah Roda',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jumlahRoda,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .jumlahRoda
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jumlah Sumbu',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jumlahSumbu,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .jumlahSumbu
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jenis',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jenis,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.jenis.toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Isi Silinder',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.isiSilinder,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .isiSilinder
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Bahan Bakar',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.bahanBakar,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .bahanBakar
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tahun Pembuatan',
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.tahunPembuatan,
                                    style: TextStyle(fontSize: 14)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .tahunPembuatan
                                        .toString(),
                                    style: TextStyle(fontSize: 14)),
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
    );
  }
}
