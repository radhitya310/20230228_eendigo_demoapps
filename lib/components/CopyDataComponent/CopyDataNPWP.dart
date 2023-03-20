import 'package:eendigodemo/model/NPWPModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyColumnDataButtonNPWP extends StatelessWidget {
  final Read data;

  CopyColumnDataButtonNPWP({required this.data});

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
        data.kpp +
        '\n' +
        'Provinsi: ' +
        data.alamat +
        '\n' +
        'RT/RW: ' +
        data.noNpwp +
        '\n';
    return dataAsString;
  }
}
