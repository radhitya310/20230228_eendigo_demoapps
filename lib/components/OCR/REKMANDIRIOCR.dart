import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/CameraController/CameraContorller.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/components/OCRResult/REKMANDIRIOCRReslts.dart';
import 'package:eendigodemo/model/MANDIRIOCR.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class REKMANDIRIOCR extends StatefulWidget {
  final List<Rekmandiriocr> data = [];
  final String title;

  REKMANDIRIOCR(this.title);

  @override
  State<REKMANDIRIOCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<REKMANDIRIOCR> {
  File? _file;
  bool isLoading = false;
  final String title;

  _OcrHomepageState(this.title);

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<List<Rekmandiriocr>> REKBCAOcrApi(File _fileRek) async {
    List<Rekmandiriocr> data = [];

    final Url =
        'https://5236635838005115.ap-southeast-5.fc.aliyuncs.com/2016-08-15/proxy/ocr/rkmandiripdfib/';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    final files = await http.MultipartFile.fromPath('file', _fileRek.path);
    request.files.add(files);
    request.fields['key'] = 'CV-ADINS-H1@W35GHRE0ZBFIF';
    request.fields['tenant_code'] = 'FIF';

    final timeout = Duration(seconds: 120);
    final client = http.Client();

    try {
      final response =
          await client.send(request).timeout(timeout, onTimeout: () async {
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

          data.add(Rekmandiriocr(
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
    } catch (e) {
      print('aaaa ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e}')),
      );
      setState(() {
        isLoading = false;
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("Assets/img/background-eendigo_(1).png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
          title: const Text('OCR Rek Mandiri'),
        ),floatingActionButton: (isLoading == false)
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (_file != null) {
                      REKBCAOcrApi(_file!).then((value) {
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
                                      OCRREKMANDIRIResults(data: value)));
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
          body: (isLoading == false)
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
                )),
    );
  }

  @override
  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 3.5,
      child: (_file == null)
          ? InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                getFile();
              },
              child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
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
          : Center(child: Text(_file.toString())),
    ));
  }
}
