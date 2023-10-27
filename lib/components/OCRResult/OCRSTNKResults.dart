import 'package:eendigodemo/components/CopyDataComponent/CopyDataSTNK.dart';
import 'package:eendigodemo/model/STNKOCRModel.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:flutter/material.dart';

class STNKRESULTS extends StatelessWidget {
  final List<Stnkocr> data;
  const STNKRESULTS({required this.data});

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
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [           
              Text('date : ' + data[0].ocrDate),
              Text('message : ' + data[0].message),
              Text('status : ' + data[0].status),
              Table(
                border: TableBorder.all(width: 1.0, color: Colors.grey),
                children: [
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Parameter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hasil OCR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Read Confidence',
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nama Pemilik',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.namaPemilik,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.namaPemilik.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Alamat',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.alamat,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.alamat.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Tahun Pembuatan',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.tahunPembuatan,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.tahunPembuatan.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Tahun Registrasi',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.tahunRegistrasi,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.tahunRegistrasi.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Berlaku Sampai',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.berlakuSampai,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.berlakuSampai.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Jenis Bahan Bakar',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.bahanBakar,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.bahanBakar.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Isi Silinder',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.isiSilinder,),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.isiSilinder.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No Pajak Aktif',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.isPajakAktif.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('',),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Jenis',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.jenis.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.jenis.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Masa Berlaku Pajak',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.masaBerlakuPajak.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.masaBerlakuPajak.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Kode Lokasi',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.kodeLokasi.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.kodeLokasi.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Merk',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.merk.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.merk.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Model',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.model.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.model.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor BPKB',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorBpkb.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorBpkb.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor Mesin',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorMesin.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorMesin.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor Rangka',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorRangka.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorRangka.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor STNK',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorStnk.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorStnk.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor Urut Pendaftaran',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorUrutPendaftaran.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorUrutPendaftaran.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nomor Registrasi',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.nomorRegistrasi.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.nomorRegistrasi.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Warna',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.warna.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.warna.toString(),),
                      )),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Warna TNKB',),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].read.warnaTnkb.toString(),),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(data[0].readConfidence.warnaTnkb.toString(),),
                      )),
                    ]),
                ]
              ),
              CopyColumnDataButton(data: data[0].read),
            ],
          )),
        ),
      ),
    );
  }
}
