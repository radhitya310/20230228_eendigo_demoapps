import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/CameraController/CameraContorller.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/model/KtpOCRModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class KtpOCR extends StatefulWidget {
  final List<Ktpocr> data = [];
  final String title;

  KtpOCR(this.title);

  @override
  State<KtpOCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<KtpOCR> {
  File? _image;
  bool isLoading = false;
  final String title;

  _OcrHomepageState(this.title);

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  @override
  Future getImagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  Future<List<Ktpocr>> KtpOcrApi(File _KtpImage) async {
    List<Ktpocr> data = [];

    final Url = 'https://api.eendigo.app/ocr/ktp';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    // final file = File(_KtpImage.path);
    final file = File(_KtpImage.path);
    final pic = await http.MultipartFile.fromPath('img', file.path);
    request.files.add(pic);
    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

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

          Map<String, dynamic> readC = responses['read_confidence'];
          Read2 readsConfidence = Read2.fromJson(readC);

          data.add(Ktpocr(
              date: date,
              message: message,
              read: reads,
              readConfidence: readsConfidence,
              status: status));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Failed ${response.statusCode}')),
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('Assets/icons/logo-eendigo-trial.png',
                        width: 250, fit: BoxFit.scaleDown),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: (isLoading == false)
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (_image != null) {
                      KtpOcrApi(_image!).then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OcrResults(data: value)));
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
                // flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
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
                      width: 150,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getImagecamera();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CameraConts()));
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
            height: MediaQuery.of(context).size.height / 3.5,
            child: (_image == null)
                ? InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      imageChooser(context);
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
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Image.file(
                            File(_image!.path),
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
