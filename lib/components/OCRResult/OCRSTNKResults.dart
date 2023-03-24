import 'package:eendigodemo/components/CopyDataComponent/CopyDataSTNK.dart';
import 'package:eendigodemo/model/STNKOCRModel.dart';
import 'package:flutter/material.dart';

class STNKRESULTS extends StatelessWidget {
  final List<Stnkocr> data;
  const STNKRESULTS({required this.data});

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
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Find services, food, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.person,
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
      body: Center(
          child: Column(
        children: [
          Text('date : ' + data[0].ocrDate),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          Text('Nama Pemilik : ' + data[0].read.namaPemilik),
          Text('Alamat : ' + data[0].read.alamat),
          Text('Tahun Pembuatan : ' + data[0].read.tahunPembuatan),
          Text('Tahun Registrasi : ' + data[0].read.tahunRegistrasi),
          Text('Berlaku Sampai : ' + data[0].read.berlakuSampai),
          Text('Jenis Bahan Bakar : ' + data[0].read.bahanBakar),
          Text('Isi Silinder : ' + data[0].read.isiSilinder),
          Text('No Pajak Aktif : ' + data[0].read.isPajakAktif.toString()),
          Text('Jenis : ' + data[0].read.jenis),
          Text('Masa Berlaku Pajak : ' + data[0].read.masaBerlakuPajak),
          Text('Kode Lokasi : ' + data[0].read.kodeLokasi),
          Text('Merek : ' + data[0].read.merk),
          Text('Model : ' + data[0].read.model),
          Text('Nomor BPKB : ' + data[0].read.nomorBpkb),
          Text('Nomor Mesin : ' + data[0].read.nomorMesin),
          Text('Nomor Rangka : ' + data[0].read.nomorRangka),
          Text('Nomor STNK : ' + data[0].read.nomorStnk),
          Text('Nomor Urut Pendaftaran : ' + data[0].read.nomorUrutPendaftaran),
          Text('Nomor Registrasi : ' + data[0].read.nomorRegistrasi),
          Text('Warna : ' + data[0].read.warna),
          Text('Warna TNKB : ' + data[0].read.warnaTnkb),
          CopyColumnDataButton(data: data[0].read),
        ],
      )),
    );
  }
}
