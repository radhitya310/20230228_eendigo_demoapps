import 'package:eendigodemo/model/STNKOCRModel.dart';
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
    String dataAsString = 'Nama Pemilik ' +
        data.namaPemilik +
        '\n' +
        'Alamat' +
        data.alamat +
        '\n' +
        'Tahun Pembuatan' +
        data.tahunPembuatan +
        '\n' +
        'Tahun Registrasi' +
        data.tahunRegistrasi +
        '\n' +
        'Berlaku Sampai' +
        data.berlakuSampai +
        '\n' +
        'Jenis Bahan Bakar' +
        data.bahanBakar +
        '\n' +
        'Isi Silinder' +
        data.isiSilinder +
        '\n' +
        'No Pajak Aktif' +
        data.isPajakAktif +
        '\n' +
        'Jenis' +
        data.jenis +
        '\n' +
        'Masa Berlaku Pajak' +
        data.masaBerlakuPajak +
        '\n' +
        'Kode Lokasi' +
        data.kodeLokasi +
        '\n' +
        'Merek' +
        data.merk +
        '\n' +
        'Model' +
        data.model +
        '\n' +
        'Nomor BPKB' +
        data.nomorBpkb +
        '\n' +
        'Nomor Mesin' +
        data.nomorMesin +
        '\n' +
        'Nomor Rangka' +
        data.nomorRangka +
        '\n' +
        'Nomor STNK' +
        data.nomorStnk +
        '\n' +
        'Nomor Urut Pendaftaran' +
        data.nomorUrutPendaftaran +
        '\n' +
        'Nomor Registrasi' +
        data.nomorRegistrasi +
        '\n' +
        'Warna' +
        data.warna +
        '\n' +
        'Warna TNKB' +
        data.warnaTnkb;
    return dataAsString;
  }
}
