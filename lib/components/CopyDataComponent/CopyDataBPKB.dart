import 'package:eendigodemo/model/BPKBModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyColumnDataButton extends StatelessWidget {
  final Read data;

  CopyColumnDataButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: _getChildrenText()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Column data copied to clipboard')),
        );
      },
      child: Text('Copy Column Data'),
    );
  }

  String _getChildrenText() {
    String dataAsString = 'Alamat : ' +
        data.alamat +
        '/n' +
        'Alamat Email : ' +
        data.alamatEmail +
        '/n' +
        'Bahan Bakar : ' +
        data.bahanBakar +
        '/n' +
        'Isi Silinder : ' +
        data.isiSilinder +
        '/n' +
        'Jenis : ' +
        data.jenis +
        '/n' +
        'Jumlah Roda : ' +
        data.jumlahRoda +
        '/n' +
        'Jumlah Sumbu : ' +
        data.jumlahSumbu +
        '/n' +
        'Lok Dikeluarkan : ' +
        data.lokDikeluarkan +
        '/n' +
        'Merk : ' +
        data.merk +
        '/n' +
        'Model : ' +
        data.model +
        '/n' +
        'NIK : ' +
        data.nik +
        '/n' +
        'No BPKB : ' +
        data.noBpkb +
        '/n' +
        'No Mesin : ' +
        data.nomorMesin +
        '/n' +
        'No Rangka : ' +
        data.nomorRangka +
        '/n' +
        'No Registrasi : ' +
        data.nomorRegistrasi +
        '/n' +
        'Pekerjaan : ' +
        data.pekerjaan +
        '/n' +
        'Tanggal Dikeluarkan : ' +
        data.tglDikeluarkan +
        '/n' +
        'Tahun Pembuatan : ' +
        data.tahunPembuatan +
        '/n' +
        'Type : ' +
        data.type +
        '/n' +
        'Warna : ' +
        data.warna +
        '/n';
    return dataAsString;
  }
}
