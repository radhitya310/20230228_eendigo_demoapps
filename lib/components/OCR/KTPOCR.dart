import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/components/Liveness/LivenessCatcher.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/pageBase.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eendigodemo/model/KtpOCRModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class KTPOCR extends StatefulWidget {
  final List<Ktpocr> data = [];
  final String title;

  KTPOCR(this.title);

  @override
  State<KTPOCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<KTPOCR> {
  bool isLoading = false;
  Uint8List? webimage;
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
    //   setState(() {
    //     webimage = image.files.first.bytes!;
    //   });
    // }
  }

  Future getImagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() async {
        webimage = await image.readAsBytes();
        // print('Image Path $_image');
      });
    }
  }

  Future<List<Ktpocr>> KtpOcrApi(Uint8List _KtpImage) async {
    List<Ktpocr> data = [];

    var headers = {
      'Content-Type': 'multipart/form-data',
      'Merchant-Key': '',
      'Authorization': 'Basic YWRpbnM6N3VscHFtNXc2a2RycWVqbDY1N20='
    };

    print(_KtpImage);

    var request = http.MultipartRequest(
        'POST', Uri.parse(UrlPath.ocrKTP));

    request.fields.addAll(
        {'key': 'CV-ADINS-PROD-H1@DT476WATDADT4WA', 'tenant_code': 'ADINS'});

    request.files
        .add(http.MultipartFile.fromBytes('img', _KtpImage, filename: 'KTP'));
    request.headers.addAll(headers);
    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

    final timeout = Duration(seconds: 120);
    final client = http.Client();

    try {
      http.StreamedResponse response = await request.send();

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
          print(message.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else if (status == 'SUCCESS') {
          Map<String, dynamic> read = responses['read'];
          Read reads = Read.fromJson(read);

          Map<String, dynamic> readC = responses['read_confidence'];
          Read2 readConfidence = Read2.fromJson(readC);

          data.add(Ktpocr(
              date: date,
              message: message,
              read: reads,
              readConfidence: readConfidence,
              status: status));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('failed');
        print(response.statusCode);
        print('Server error: ${await response.stream.bytesToString()}');

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
                    if (webimage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('no image')),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      print('a');
                      KtpOcrApi(webimage!).then((value) {
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
                    }
                  },
                  backgroundColor: Color.fromARGB(255, 190, 126, 174),
                  child: const Icon(Icons.send),
                )
              : null,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: (isLoading == false)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GradientText(title,
                                  style: (TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold)),
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
            ),
          )));
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
                        onTap: () async {
                          Navigator.pop(context);                         
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LivenessCatcher("OCR KTP")));
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

  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 2.2,
            child: (webimage == null)
                ? InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      imageChooser(context);
                    },
                    child: Container(
                        height: 200,
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
                                  base64Decode(base64Image)),),
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
                                      webimage = null;
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
