import 'dart:convert';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/model/REKBCAModel.dart';
import 'package:eendigodemo/pageBase.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../OCRResult/BCAOCRResults.dart';

class REKBCAOCR extends StatefulWidget {
  final List<Rekbcaocr> data = [];
  final String title;

  REKBCAOCR(this.title);

  @override
  State<REKBCAOCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<REKBCAOCR> {
  FilePickerResult? _file;
  bool isLoading = false;
  final String title;

  _OcrHomepageState(this.title);

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = result;
      });
    }
  }

  Future<List<Rekbcaocr>> REKBCAOcrApi(Uint8List _fileRek) async {
    List<Rekbcaocr> data = [];

    final response;

    final Url = UrlPath.ocrBCA;

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    final files = await http.MultipartFile.fromBytes('file', _fileRek,
        filename: 'BCAREK');
    request.files.add(files);
    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

    final timeout = Duration(seconds: 120);
    final client = http.Client();
    // try {
    response = await client.send(request).timeout(timeout, onTimeout: () async {
      client.close();
      print('request timeout');
      throw Exception('request timeout');
    });

    if (response.statusCode == 200) {
      print('aa');
      var ujson1 = await utf8.decodeStream(response.stream);
      Map<String, dynamic> responses = json.decode(ujson1);
      var message = responses['message'];
      var date = responses['ocr_date'];
      var status = responses['status'];
      var num_of_pages = responses['num_of_pages'];
      if (status == 'FAILED') {
        setState(() {
          isLoading = false;
        });
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } else if (status == 'SUCCESS') {
        print(responses['read']);
        Map<String, dynamic> read = responses['read'];
        Read reads = Read.fromJson(read);

        data.add(Rekbcaocr(
            ocrDate: date,
            message: message,
            read: reads,
            status: status,
            numOfPages: num_of_pages));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request Failed')),
      );
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
      body: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: EendigoLogo(),
          floatingActionButton: (isLoading == false)
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (_file != null) {
                      REKBCAOcrApi(_file!.files.first.bytes!).then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          print(value);
                          print(value.toList());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OCRBCAResults(data: value)));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('no image')),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  backgroundColor: Color.fromARGB(255, 190, 126, 174),
                  child: const Icon(Icons.send),
                )
              : null,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.height / 1.8,
              child: (isLoading == false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GradientText(title,
                                style: (TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold)),
                                colors: [
                                  Color.fromARGB(255, 37, 162, 220),
                                  Color.fromARGB(255, 28, 115, 185),
                                  Color.fromARGB(255, 59, 67, 127),
                                ])),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 70.0),
                          child: Center(child: ImageCatcher(context)),
                        ),
                        Spacer()
                      ],
                    )
                  : Center(
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(child: CircularProgressIndicator())),
                    ),
            ),
          )
        ),
      );
  }

  @override
  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 2.2,
      child: (_file == null)
          ? InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                getFile();
              },
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width - 50,
                  child: DottedBorder(
                    color: const Color.fromARGB(255, 78, 199, 30),
                    strokeWidth: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.plus),
                        ],
                      ),
                    ),
                  )),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(_file!.files.first.name)),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _file = null;
                      });
                    },
                    child: Text('Delete'))
              ],
            )),
    ));
  }
}
