import 'package:eendigodemo/components/CopyDataComponent/CopyDataBPKB.dart';
import 'package:eendigodemo/model/BPKBModel.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
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
        appBar: EendigoLogo(context),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('date : ' + data[0].ocrDate, style: TextStyle(fontSize: 24)),
              Text('message : ' + data[0].message,
                  style: TextStyle(fontSize: 24)),
              Text('status : ' + data[0].status,
                  style: TextStyle(fontSize: 24)),
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
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Hasil OCR',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Read Confidence',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('NIK'),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nik,),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.nik.toString(),
                                    ),
                              ))
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Pemilik',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.pemilik,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.pemilik.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Pekerjaan',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.merk,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.merk.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Alamat',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.alamat,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.alamat.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Lok Dikeluarkan',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.lokDikeluarkan,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .lokDikeluarkan
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No BPKB',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.noBpkb,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.noBpkb.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Mesin',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorMesin,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorMesin
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Rangka',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorRangka,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorRangka
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No Registrasi',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.nomorRegistrasi,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .nomorRegistrasi
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Merek',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.merk,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.merk.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Model',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.model,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.model.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Type',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.type,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.type.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Warna',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.warna,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.warna.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jumlah Roda',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jumlahRoda,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .jumlahRoda
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jumlah Sumbu',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jumlahSumbu,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .jumlahSumbu
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Jenis',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.jenis,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i].readConfidence.jenis.toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Isi Silinder',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.isiSilinder,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .isiSilinder
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Bahan Bakar',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.bahanBakar,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .bahanBakar
                                        .toString(),
                                    ),
                              )),
                            ]),
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tahun Pembuatan',
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[i].read.tahunPembuatan,
                                    ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    data[i]
                                        .readConfidence
                                        .tahunPembuatan
                                        .toString(),
                                    ),
                              )),
                            ]),
                          }
                        ],
                      ),
                    ],
                  ),
                )
              },
              CopyColumnDataButton(data: data[0].read),
            ],
          ),
        )),
      ),
    );
  }
}
