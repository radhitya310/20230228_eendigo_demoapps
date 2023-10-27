import 'package:eendigodemo/CONTOHCAMERAOVERLAY.dart';
import 'package:eendigodemo/components/OCR/BCAOCR.dart';
import 'package:eendigodemo/components/OCR/BPKBOCR.dart';
import 'package:eendigodemo/components/OCR/INVOICEOCR.dart';
import 'package:eendigodemo/components/OCR/KKOCR.dart';
import 'package:eendigodemo/components/OCR/KTPOCR.dart';
import 'package:eendigodemo/components/OCR/NPWPOCR.dart';
import 'package:eendigodemo/components/OCR/PASPOROCR.dart';
import 'package:eendigodemo/components/OCR/REKMANDIRIOCR.dart';
import 'package:eendigodemo/components/OCR/STNKOCR.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OCRchoice extends StatefulWidget {
  const OCRchoice({key});

  @override
  State<OCRchoice> createState() => _OCRchoiceState();
}

class _OCRchoiceState extends State<OCRchoice> {
  @override
  final List<Map> OCRCHOI = [
    {
      'label': 'OCR KTP',
      'icon': 'Assets/icons/ktp.png',
      'screens': KTPOCR('KTP \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR REK BCA',
      'icon': 'Assets/icons/RK.png',
      'screens': REKBCAOCR('RK BCA \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR RK MANDIRI',
      'icon': 'Assets/icons/RK.png',
      'screens': REKMANDIRIOCR('RK MANDIRI \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR KK',
      'icon': 'Assets/icons/kk.png',
      'screens': KKOCR('KK \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR STNK',
      'icon': 'Assets/icons/stnk.png',
      'screens': STNKOCR('STNK \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 40.0,
      'icon-height': 40.0
    },
    {
      'label': 'OCR BPKB',
      'icon': 'Assets/icons/bpkb.png',
      'screens': BPKBOCR('BPKB \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR NPWP',
      'icon': 'Assets/icons/npwp.png',
      'screens': NPWPOCR('NPWP \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR Paspor',
      'icon': 'Assets/icons/paspor.png',
      'screens': PASPOROCR('PASPOR \nOCR'),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    {
      'label': 'OCR Invoice',
      'icon': 'Assets/icons/invoice_icon.png',
      'screens': InvoiceOCR(),
      'color': Color.fromARGB(255, 176, 162, 191),
      'icon-width': 100.0,
      'icon-height': 100.0
    },
    // {
    //   'label': 'TEST CAMERA',
    //   'icon': 'Assets/icons/npwp.png',
    //   'screens': contohKamera(),
    //   'color': Color.fromARGB(255, 176, 162, 191),
    //   'icon-width': 100.0,
    //   'icon-height': 100.0
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState
    // if (Platform.isAndroid) {
    //   print('The app is running on an Android device.');
    // } else if (Platform.isIOS) {
    //   print('The app is running on an iOS device.');
    // } else {
    //   print('The app is running on an unknown platform.');
    // }
    if (kIsWeb == true) {
      print('web');
    }
    super.initState();
  }

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
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'OCR',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Wrap(
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (final OCR in OCRCHOI)
                          Material(
                              color: Color.fromARGB(113, 255, 255, 255),
                              borderRadius: BorderRadius.circular(16),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                width: 125,
                                height: 130,
                                child: InkWell(
                                  splashColor: OCR['color'].withOpacity(0.5),
                                  highlightColor: OCR['color'].withOpacity(0.2),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => OCR['screens']));
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: OCR['color']
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  child: Image(
                                                    image:
                                                        AssetImage(OCR['icon']),
                                                    width: OCR['icon-width'],
                                                    height: OCR['icon-height'],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            OCR['label'],
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
