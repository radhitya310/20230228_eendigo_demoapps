import 'package:eendigodemo/components/CopyDataComponent/CopyDataKTP.dart';
import 'package:eendigodemo/model/KKOCRModel.dart' as KK;
import 'package:flutter/material.dart';

class OcrKKResults
 extends StatelessWidget {
  final List<KK.Kkocr> data;
  const OcrKKResults
  ({required this.data});

  // final List<Widget> data1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            Icon(Icons.search),
                            SizedBox(width: 16,),
                            Text('Find services, food, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () { },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.person,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),  
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          children: [
                Text('alamat : '+ data[0].read.alamat),
                Text('desa kelurahan : ' + data[0].read.desaKelurahan),
                Text('kabupaten kota : ' + data[0].read.kabupatenKota),
                Text('kecamatan : ' + data[0].read.kecamatan),
                Text('Kode Pos : ' + data[0].read.kodePos),
                Text('Nama Kepala Keluarga : ' +  data[0].read.namaKepalaKeluarga),
                Text('Nomor Blanko : ' +  data[0].read.nomorBlanko),
                Text('Nomor KK : ' + data[0].read.nomorKk),
                Text('Provinsi : ' + data[0].read.provinsi),
                Text('Rt/Rw : ' + data[0].read.rtRw),
                Text('Data Keluarga'),
                for (int i = 0; i < data[0].read.table.length; i++ )... {
                Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Data  ${i + 1}'),
                      Table(
                      border: TableBorder.all(width: 1.0, color: Colors.grey),
                      children: [
                        if (data[0].read.table.isNotEmpty)...{
                          TableRow(children: [
                          TableCell(child: Text('Nama Lengkap')),
                          TableCell(child: Text(data[0].read.table[i].namaLengkap)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Nama Ayah')),
                          TableCell(child: Text(data[0].read.table[i].namaAyah)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Nama Ibu')),
                          TableCell(child: Text(data[0].read.table[i].namaIbu)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Kewarnegaraan')),
                          TableCell(child: Text(data[0].read.table[i].kewarganegaraan)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Pekerjaan')),
                          TableCell(child: Text(data[0].read.table[i].jenisPekerjaan)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Hubungan status')),
                          TableCell(child: Text(data[0].read.table[i].statusHubunganDalamKeluarga)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Agama')),
                          TableCell(child: Text(data[0].read.table[i].agama)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('NIK')),
                          TableCell(child: Text(data[0].read.table[i].nik)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Tanggal Lahir')),
                          TableCell(child: Text(data[0].read.table[i].tanggalLahir)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Tempat Lahir')),
                          TableCell(child: Text(data[0].read.table[i].tempatLahir)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Status Perkawinan')),
                          TableCell(child: Text(data[0].read.table[i].statusPerkawinan)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Tanggal Perkawinan')),
                          TableCell(child: Text(data[0].read.table[i].tanggalPerkawinan)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('Pendidikan')),
                          TableCell(child: Text(data[0].read.table[i].pendidikan)),
                        ]),
                        TableRow(children: [
                          TableCell(child: Text('No Paspor')),
                          TableCell(child: Text(data[0].read.table[i].noPaspor)),
                        ]),
                         TableRow(children: [
                          TableCell(child: Text('No Kitas Kitab')),
                          TableCell(child: Text(data[0].read.table[i].noKitasKitap)),
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
    );
  }
}