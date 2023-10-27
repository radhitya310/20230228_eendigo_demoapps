import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/CameraController/CameraContorller.dart';
import 'package:eendigodemo/components/Liveness/LivenessCatcher.dart';
import 'package:eendigodemo/components/OCRResult/PasporResult.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/model/PasporOCRModel.dart';
import 'package:eendigodemo/pageBase.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PASPOROCR extends StatefulWidget {
  final List<OcrPaspor> data = [];
  final String title;

  PASPOROCR(this.title);

  @override
  State<PASPOROCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<PASPOROCR> {
  Uint8List? webimage;
  bool isLoading = false;
  final String title;
  File? _image;
  String base64Image = "";

  _OcrHomepageState(this.title);

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final pickedImageFile = File(image.path);
        _image = pickedImageFile;         
        webimage = await image.readAsBytes();

      setState(() {
          base64Image = base64Encode(webimage!);
      });
    }
    // var image = await FilePicker.platform.pickFiles();
    // if (image != null) {
    //   final pickedImageFile = image.files.first.bytes;
    //   setState(() {
    //     _image = pickedImageFile;
    //     // print('Image Path $_image');
    //   });
    // }
  }

  // @override
  // Future getImagecamera() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (image != null) {
  //     final pickedImageFile = File(image.path);
  //     setState(() {
  //       _image = pickedImageFile.readAsBytesSync();
  //       print('Image Path $_image');
  //     });
  //   }
  // }

  Future<List<OcrPaspor>> PASPOROcrApi(Uint8List _PasporImage) async {
    List<OcrPaspor> data = [];

    final Url = UrlPath.ocrPASSPOR;

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    // final file = File(_KtpImage.path);
    // final file = File(_KtpImage.path);
    final pic =
        http.MultipartFile.fromBytes('img', _PasporImage, filename: 'PASPOR');
    request.files.add(pic);
    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

    final timeout = Duration(seconds: 10);
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
        if (status == 'FAILED') {
          setState(() {
            isLoading = false;
          });
          print('failed');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else if (status == 'SUCCESS') {
          Map<String, dynamic> read = responses['read'];
          Read reads = Read.fromJson(read);

          Map<String, dynamic> readConfidences = responses['read_confidence'];
          ReadConfidence readConfidence =
              ReadConfidence.fromJson(readConfidences);

          data.add(OcrPaspor(
              message: message,
              ocrDate: date,
              read: reads,
              readConfidence: readConfidence,
              status: status));
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
    return PageBase(
      body: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: EendigoLogo(context),
          floatingActionButton: (isLoading == false)
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (_image != null) {
                      PASPOROcrApi(webimage!).then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PASPORresult(data: value)));
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
              width: MediaQuery.of(context).size.height / 1.3,
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
          ))
    );
  }

  void imageChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select image from",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getImage();
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.archivebox,
                                size: 50,
                              ),
                              Text("From gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);                         
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LivenessCatcher("OCR KK")));
                          _image = File(result.path);
                          webimage = await result.readAsBytes();
                          setState(() {
                            base64Image = base64Encode(webimage!);
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.camera,
                              size: 50,
                            ),
                            Text("From camera")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 2.2,
            child: (_image == null)
                ? InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      getImage();
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
                : Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Image.memory(
                            webimage!,
                          )),
                      Positioned(
                        right: 20,
                        top: 0,
                        child: Container(
                          color: Color.fromARGB(255, 219, 218, 218),
                          width: 40,
                          height: 40,
                          child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ))),
                        ),
                      )
                    ],
                  )));
  }
}