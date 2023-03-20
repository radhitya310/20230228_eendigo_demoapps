import 'package:eendigodemo/model/KtpOCRModel.dart';
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
    String dataAsString = 'Nama: ' +
        data.nama +
        '\n' +
        'NIK: ' +
        data.nik +
        '\n' +
        'Pekerjaan: ' +
        data.pekerjaan +
        '\n' +
        'Provinsi: ' +
        data.provinsi +
        '\n' +
        'RT/RW: ' +
        data.rtRw +
        '\n' +
        'Agama: ' +
        data.agama +
        '\n' +
        'Alamat: ' +
        data.alamat +
        '\n' +
        'Berlaku Hingga: ' +
        data.berlakuHingga +
        '\n' +
        'Golongan Darah: ' +
        data.golonganDarah +
        '\n' +
        'e-KTP: ' +
        data.isEktp.toString() +
        '\n' +
        'Jenis Kelamin: ' +
        data.jenisKelamin +
        '\n' +
        'Kecamatan: ' +
        data.kecamatan +
        '\n' +
        'Kelurahan/Desa: ' +
        data.kelurahanDesa +
        '\n' +
        'Kewarganegaraan: ' +
        data.kewarganegaraan +
        '\n' +
        'Kota/Kabupaten: ' +
        data.kotaKabupaten +
        '\n' +
        'Status Perkawinan: ' +
        data.statusPerkawinan +
        '\n' +
        'Tanggal Lahir: ' +
        data.tanggalLahir +
        '\n' +
        'Tempat Lahir: ' +
        data.tempatLahir +
        '\n';
    return dataAsString;
  }
}
